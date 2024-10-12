import { PADDING } from '../../constants/size'
import { rvp, responsiveFontSize } from '../../utils/responsive'

@Component
export default struct NavBar {
  @Consume('indexPathStack') indexPathStack: NavPathStack;
  @Prop title: string;

  build() {
    Row() {
      Row({ space: rvp(8) }) {
        Image($r('app.media.back')).width(rvp(24)).onClick(() => {
          this.indexPathStack.pop();
        })
        Text(this.title).fontSize(responsiveFontSize.sm)
      }

      Image($r('app.media.share')).width(rvp(20)).height(rvp(20)).fillColor($r('app.color.black'))
    }
    .width('100%')
    .height(rvp(44))
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .backgroundColor($r('app.color.white'))
  }
}