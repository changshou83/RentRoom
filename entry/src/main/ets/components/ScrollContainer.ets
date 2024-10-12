import { window } from '@kit.ArkUI';
import { getWindowTopHeight, rvp } from "../utils/responsive";

export interface IColor {
  fontColor: string;
  bgColor: string;
}

@Component
export default struct ScrollContainer {
  scrollY: number = 0;

  @Builder defaultBuilder() {}
  @BuilderParam navBuilder: ($$: IColor) => void = this.defaultBuilder;
  @BuilderParam contentBuilder: () => void = this.defaultBuilder;

  @State bgColor: string = 'rgba(255,255,255,0)';
  @State fontColor: string = 'rgb(255,255,255)';
  restoreBgColor: string = 'rgba(255, 255, 255, 0)';
  restoreFontColor: string = 'rgb(255, 255, 255)';

  handleScroll(scrollX: number, scrollY: number) {
    this.scrollY = Math.max(0, this.scrollY + scrollY);
    this.calcColor();
    this.setWindowStatusColor();
  }

  calcColor() {
    // 滚动计算的 scrollY 的值到达顶部可能不是 0，给点误差
    if (this.scrollY > 10) {
      this.bgColor = 'rgba(255, 255, 255, 1)'
      this.fontColor = 'rgb(0, 0, 0)'
    } else {
      this.bgColor = this.restoreBgColor;
      this.fontColor = this.restoreFontColor;
    }
  }
  setWindowStatusColor = async () => {
    const windowClass = await window.getLastWindow(getContext())
    windowClass.setWindowSystemBarProperties({
      statusBarContentColor: this.fontColor,
      navigationBarContentColor: this.fontColor
    })
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          this.contentBuilder()
        }
        .align(Alignment.TopStart)
      }
      .height('100%')
      .padding({ bottom: rvp(10) })
      .backgroundColor($r('app.color.bg_gray_second'))
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
      .onDidScroll((xOffset: number, yOffset: number) => {
        this.handleScroll(xOffset, yOffset)
      })

      Column() {
        this.navBuilder({ bgColor: this.bgColor, fontColor: this.fontColor })
      }
      .backgroundColor(this.bgColor)
      .padding({ top: getWindowTopHeight() })
    }
    .height('100%')
    .alignContent(Alignment.TopStart)
  }
}