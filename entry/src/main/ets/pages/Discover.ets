import { getDiscoverDataApi } from '../api/discover'
import { getWindowTopHeight, rvp } from '../utils/responsive'
import { IBenefit, IDanMuItem, IPostZone } from '../model/DiscoverData'

import ScrollContainer, { IColor } from '../components/ScrollContainer'
import NavBar from '../views/Discover/NavBar'
import Bg from '../views/Discover/Bg'
import BannerScroll from '../views/Discover/BannerScroll'
import Ad from '../views/Discover/Ad'
import { PADDING } from '../constants/size'
import Welfare from '../views/Discover/Welfare'

@Component
export default struct Discover {
  @State danMuList1: IDanMuItem[] = []
  @State danMuList2: IDanMuItem[] = []
  @State postZone: IPostZone = {
    "mainPost": {
      "followerNum": 0,
      "title": '',
      "userAvatar": '',
      "userName": '',
      "postContent": '',
    },
    "contentBlockList": []
  }
  @State benefits: IBenefit[] = []

  aboutToAppear(): void {
    this.getDiscoverData()
  }

  async getDiscoverData() {
    const discoverData = await getDiscoverDataApi()
    this.danMuList1 = discoverData.danMuList1
    this.danMuList2 = discoverData.danMuList2
    this.postZone = discoverData.postZone
    this.benefits = discoverData.benefits
  }

  @Builder
  navBuilder($$: IColor) {
    NavBar({ bgColor: $$.bgColor })
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        Text('与100万用户发现生活').margin({ top: rvp(44), left: rvp(16) }).fontSize(rvp(14))
        Column({ space: rvp(16) }) {
          BannerScroll({ bannerList: this.danMuList1 })
          BannerScroll({ bannerList: this.danMuList2 })
        }.width('100%').margin({ top: rvp(20) })

        Column() {
          Ad({ postZone: this.postZone })
          Welfare({ benefits: this.benefits })
        }.padding({ top: getWindowTopHeight() })
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ top: getWindowTopHeight(), left: rvp(PADDING), right: rvp(PADDING) })
      .width('100%')
    }.alignContent(Alignment.TopStart)
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