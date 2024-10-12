import { loginApi, sendSMSCodeApi } from "../../api/user"
import PageNavBar from "../../components/PageNavBar"
import ScrollContainer from "../../components/ScrollContainer"
import { CODE_REG } from "../../constants/regs"
import { getWindowTopHeight, responsiveFontSize, rvp } from "../../utils/responsive"
import showToast from "../../utils/showToast"

@Entry
@Component
export default struct LoginCode {
  @Consume('indexPathStack') indexPathStack: NavPathStack;

  @Builder
  navBuilder() {
    PageNavBar({ title: '验证码登录' })
  }

  @StorageLink('token') token: string = ''

  // 发送验证码
  @Prop phone: string;
  aboutToAppear() {
    this.sendSMSCode()
  }
  async sendSMSCode() {
    this.startCountDown()
    this.isSendCode = true
    const code = await sendSMSCodeApi(this.phone)
    showToast(code)
  }

  // 倒计时
  @State isSendCode: boolean = false
  @State time: number = 61;
  timeId: number = -1;
  startCountDown() {
    this.time--
    this.timeId = setInterval(() => {
      this.time--
      if (this.time <= 0) {
        this.time = 61
        clearInterval(this.timeId)
      }
    }, 1000)
  }

  aboutToDisappear() {
    clearInterval(this.timeId)
  }

  // 高亮
  @State code: string = ''
  @State isBtnActive: boolean = false
  handleInputChange(val: string) {
    this.code = val;
    this.isBtnActive = CODE_REG.test(val);
  }

  // 登录
  async login() {
    try {
      const result = await loginApi(this.phone, this.code);
      // 持久化存储 token
      this.token = result.token
      // 跳转回去
      this.indexPathStack.clear();
    } catch {
      showToast('验证码不正确')
    }
  }

  @Builder
  contentBuilder() {
    Column() {
      Stack() {
        TextInput({ placeholder: '请输入验证码' }).inputStyles().onChange(this.handleInputChange.bind(this))
        if (this.time <= 60) {
          Text(`${this.time}s`).fontSize(responsiveFontSize.lg).fontColor($r('app.color.primary'))
        } else if (this.isSendCode) {
          Text(`重新发送`).fontSize(responsiveFontSize.md).fontColor($r('app.color.primary')).onClick(this.sendSMSCode.bind(this))
        }
      }.alignContent(Alignment.End)

      Divider().color('#C4EDCE')
      Button('确认')
        .margin({ top: rvp(40) })
        .backgroundColor(this.isBtnActive ? $r('app.color.primary') : '#F0F0F0')
        .fontSize(responsiveFontSize.md)
        .width(rvp(100))
        .fontColor(this.isBtnActive ? $r('app.color.white') : '#C1C1C1')
        .padding({ top: rvp(12), bottom: rvp(12) })
        .enabled(this.isBtnActive)
        .onClick(this.login.bind(this))
    }
    .width('100%')
    .height('100%')
    .padding({ left: rvp(37), right: rvp(37), top: rvp(70) + getWindowTopHeight() })
    .alignItems(HorizontalAlign.End)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#DEFBE5', 0], ['#FFFFFF', 0.3]]
    })
  }

  build() {
    Column() {
      ScrollContainer({
        navBuilder: this.navBuilder,
        contentBuilder: () => {
          this.contentBuilder()
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}

@Styles function pressedStyles() {
  // 无法实现点击时，完全透明
  .backgroundColor('rgba(255, 255, 255, 0)')
  .borderRadius(0)
}

@Extend(TextInput) function inputStyles() {
  .padding({ left: 0, right: 0, top: 0, bottom: rvp(8) })
  .backgroundColor(Color.Transparent)
  .placeholderColor('#C1C1C1')
  .placeholderFont({ size: responsiveFontSize.lg })
  .caretColor('#C1C1C1')
  .type(InputType.PhoneNumber)
  .maxLength(11)
  .stateStyles({
    pressed: pressedStyles,
    clicked: pressedStyles
  })
}
