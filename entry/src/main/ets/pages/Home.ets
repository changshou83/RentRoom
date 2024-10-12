import SearchBar from "../views/Home/SearchBar";
import SwiperLayout from "../views/Home/SwiperLayout";
import NavList from "../views/Home/NavList";
import TileList from "../views/Home/TileList";
import PlanList from "../views/Home/PlanList";
import Ad from "../views/Home/Ad";
import RoomRecommend from "../views/Home/RoomRecommend";
import ScrollContainer, { IColor } from "../components/ScrollContainer";

import { getHomeDataApi } from "../api/home";
import { PADDING } from "../constants/size"
import { IPlanItem, INavItem, ITileItem } from "../model/HomeData";
import { BannerListDataSource } from "../model/BannerListDataSource";
import { rvp } from "../utils/responsive";

@Component
export default struct Home {
  // 首页数据
  @State bannerList: BannerListDataSource = new BannerListDataSource();
  @State navList: INavItem[] = [];
  @State tileList: ITileItem[] = [];
  @State planList: IPlanItem[] = [];
  @State adPicture: string = '';

  // 组件生命周期
  aboutToAppear() {
    this.getHomeData()
  }

  async getHomeData() {
    const homeData = await getHomeDataApi()
    this.bannerList.setList(homeData.bannerList);
    this.navList = homeData.navList;
    this.tileList = homeData.tileList;
    this.planList = homeData.planList;
    this.adPicture = homeData.adPicture;
  }

  @Builder
  navBuilder($$: IColor) {
    SearchBar({ bgColor: $$.bgColor, fontColor: $$.fontColor })
  }

  @Builder
  contentBuilder() {
    SwiperLayout({ bannerList: this.bannerList })
    Column() {
      NavList({ navList: this.navList })
      TileList({ tileList: this.tileList })
      PlanList({ planList: this.planList })
      Ad({ adPicture: this.adPicture })
    }
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    RoomRecommend()
  }

  build() {
    ScrollContainer({
      navBuilder: this.navBuilder,
      contentBuilder: () => {
        this.contentBuilder()
      }
    })
  }
}