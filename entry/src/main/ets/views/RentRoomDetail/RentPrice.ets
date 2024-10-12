import { rvp, responsiveFontSize } from '../../utils/responsive'

@Component
export default struct RentPrice {
  @Prop rentPriceUnitListing: string
  @Prop rentPriceUnit: string

  build() {
    Row() {
      Row({ space: rvp(2) }) {
        Text('￥').fontSize(responsiveFontSize.md).fontWeight(700)
        Text(this.rentPriceUnitListing).fontSize(rvp(26)).fontWeight(700).height(rvp(26))
        Text(this.rentPriceUnit).fontSize(responsiveFontSize.md)
      }.alignItems(VerticalAlign.Bottom)

      Row({ space: rvp(8) }) {
        Text('租金试算').fontSize(responsiveFontSize.sm).fontColor($r('app.color.gray'))
        Image($r('app.media.arrow_right')).width(rvp(4)).fillColor($r('app.color.gray'))
      }
    }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({ top: rvp(15) })
  }
}