import { PADDING } from "../constants/size";
import { rvp } from "../utils/responsive";


@Component
export default struct PageNavBar {
  @Consume('indexPathStack') indexPathStack: NavPathStack;
  @Prop title: string;
  back = () => {
    this.indexPathStack.pop()
  }

  build() {
    Stack() {
      Text(this.title).fontSize(rvp(16)).width('100%').textAlign(TextAlign.Center)
      Image($r('app.media.back')).width(rvp(24)).height(rvp(24)).onClick(this.back)
    }.width('100%').height(rvp(44)).padding({ left: rvp(PADDING), right: rvp(PADDING) }).alignContent(Alignment.Start)
  }
}