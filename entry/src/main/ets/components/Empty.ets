import { rvp, responsiveFontSize } from '../utils/responsive';

@Component
export default struct Empty {
  @Prop title: string;

  build() {
    Column({ space: rvp(19) }) {
      Image($r('app.media.blank')).width(rvp(150)).height(rvp(140)).objectFit(ImageFit.Fill)
      Text(this.title).fontSize(responsiveFontSize.sm)
    }.width('100%')
  }
}