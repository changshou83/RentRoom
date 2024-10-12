import { getWindowTopHeight, rvp } from '../../utils/responsive'

import PageNavBar from '../../components/PageNavBar'
import SearchFilter from '../../views/RentRoom/SearchFilter'
import WaterfallFlow from '../../views/RentRoom/WaterFallFlow'

@Entry
@Component
export default struct RentRoomList {
  @State isSearching: boolean = false;

  build() {
    Stack() {
      Column() {
        WaterfallFlow()
      }.margin({ top: getWindowTopHeight() + rvp(88) }).zIndex(this.isSearching ? 0 : 1)

      Column() {
        PageNavBar({ title: '租房列表' })
        SearchFilter({ isSearching: this.isSearching })
      }
      .height(this.isSearching ? '100%' : rvp(128))
      .padding({ top: getWindowTopHeight() }).zIndex(this.isSearching ? 1 : 0)
    }.height('100%').alignContent(Alignment.TopStart)
  }
}