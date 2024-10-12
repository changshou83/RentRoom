import ScrollContainer, { IColor } from '../components/ScrollContainer'
import { PADDING } from '../constants/size'
import { getWindowTopHeight, rvp } from '../utils/responsive'
import PlanList from '../views/My/PlanList'
import Bg from '../views/My/Bg'
import NavBar from '../views/My/NavBar'
import Order from '../views/My/Order'
import TimePlan from '../views/My/TimePlan'
import UserInfo from '../views/My/UserInfo'

@Component
export default struct My {
  @Builder
  navBuilder($$: IColor) {
    NavBar($$)
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        UserInfo()
        TimePlan()
        Order()
        PlanList()
      }.padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(44) + getWindowTopHeight() })
    }.width('100%').align(Alignment.TopStart)
  }

  build() {
    ScrollContainer({
      contentBuilder: () => {
        this.contentBuilder()
      },
      navBuilder: this.navBuilder,
    })
  }
}