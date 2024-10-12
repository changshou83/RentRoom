import PageNavBar from "../../components/PageNavBar"
import ScrollContainer from "../../components/ScrollContainer"
import { PHONE_REG } from "../../constants/regs"
import { LoginCodeRouteParams } from "../../model/RouteParams"
import { getWindowTopHeight, responsiveFontSize, rvp } from "../../utils/responsive"
import showToast from "../../utils/showToast"

@Entry
@Component
export default struct LoginPhone {
  @Consume('indexPathStack') indexPathStack: NavPathStack;

  @Builder
  navBuilder() {
    PageNavBar({ title: '验证码登录' })
  }

  // 手机号功能
  @State phone: string = ''
  @State isPhoneValid: boolean = false
  handleInputChange(val: string) {
    this.phone = val;
    this.isPhoneValid = PHONE_REG.test(val);
    this.handleBtnActive()
  }

  // 用户协议功能
  @State isAgree: boolean = false
  handleAgree() {
    this.isAgree = !this.isAgree;
    this.handleBtnActive()
  }

  // 获取验证码按钮功能
  @State isBtnActive: boolean = false;
  handleBtnActive() {
    if (this.isAgree && this.phone) {
      this.isBtnActive = true
    } else {
      this.isBtnActive = false
    }
  }

  // 点击跳转LoginCode页面
  goLoginCode() {
    if (!this.isBtnActive) return;
    if (!this.isPhoneValid) {
      showToast('手机号不符合格式')
      return;
    }
    // 验证码在下一个页面发送
    const params: LoginCodeRouteParams = { phone: this.phone };
    this.indexPathStack.pushPathByName('LoginCode', params);
  }

  @Builder
  contentBuilder() {
    Column() {
      Stack() {
        TextInput({ placeholder: '请输入手机号' }).inputStyles().onChange(this.handleInputChange.bind(this))
        if (this.isPhoneValid) {
          Image($r('app.media.success')).width(rvp(12)).height(rvp(8)).margin({ right: rvp(5) })
        }
      }.alignContent(Alignment.End)

      Divider().color('#C4EDCE')

      Row() {
        Image(this.isAgree ? $r('app.media.radio_active') : $r('app.media.radio'))
          .width(rvp(14))
          .height(rvp(14))
          .onClick(this.handleAgree.bind(this))
        Text() {
          Span('同意').fontSize(responsiveFontSize.sm).fontColor('#C1C1C1')
          Span('《用户协议》').fontSize(responsiveFontSize.sm).fontColor($r('app.color.primary'))
          Span('和').fontSize(responsiveFontSize.sm).fontColor('#C1C1C1')
          Span('《隐私政策》').fontSize(responsiveFontSize.sm).fontColor($r('app.color.primary'))
        }.margin({ left: rvp(6) })
      }.margin({ top: rvp(16) }).width('100%')

      Button('获取验证码')
        .margin({ top: rvp(40) })
        .backgroundColor(this.isBtnActive ? $r('app.color.primary') : '#F0F0F0')
        .fontSize(responsiveFontSize.sm)
        .fontColor(this.isBtnActive ? $r('app.color.white') : '#C1C1C1')
        .padding({ top: rvp(12), bottom: rvp(12), left: rvp(15), right: rvp(15) })
        .onClick(this.goLoginCode.bind(this))
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
