import Home from './Home';
import See from './See';
import Service from './Service';
import Discover from './Discover';
import My from './My';

import { rvp } from '../utils/responsive';
import { responsiveFontSize } from '../utils/responsive';
import type { IColors } from '../model/ColorsData'
import RentRoomList from './RentRoom/RentRoomList';
import RentRoomDetail from './RentRoom/RentRoomDetail';
import { RouteParams } from '../model/RouteParams';
import LoginPhone from './Login/LoginPhone';
import LoginCodePage from './Login/LoginCode';
import BookRentRoomList from './RentRoom/BookRentRoomList';

@Entry
@Component
struct Index {
  @Provide('indexPathStack') indexPathStack: NavPathStack = new NavPathStack();
  @StorageLink('navBarFontColor') navBarFontColor: string = ''
  @StorageLink('navBarBgColor') navBarBgColor: string = ''
  // 当前 tab 高亮的下标
  @State currentIndex: number = 0;
  colors: IColors = []

  // 生成 tab 的函数
  @Builder TabBuilder(index: number, text: string, icon: Resource, activeIcon: Resource) {
    Column() {
      // 项目中常用的颜色、大小等会定义成常量，将来方便复用和统一调整。而不常用的大小颜色就不需要定义了，直接写死即可。
      Image(this.currentIndex === index ? activeIcon : icon).width(rvp(28))
      Text(text)
        .fontSize(responsiveFontSize.xs)
        .fontColor(this.currentIndex === index ? $r('app.color.black') : '#a0a0a0')
        .height(rvp(15))
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }

  @Builder
  PagesMap(name: string, params?: RouteParams) {
    if(name === 'RentRoomList') {
      NavDestination() {
        RentRoomList()
      }
      .hideTitleBar(true)
    } else if(name === 'RentRoomDetail' && params) {
      NavDestination() {
        RentRoomDetail({ roomId: params.id })
      }
      .hideTitleBar(true)
    } else if(name === 'LoginPhone') {
      NavDestination() {
        LoginPhone()
      }
      .hideTitleBar(true)
    } else if(name === 'LoginCode' && params) {
      NavDestination() {
        LoginCodePage({ phone: params.phone })
      }
      .hideTitleBar(true)
    } else if(name === 'BookRentRoomList') {
      NavDestination() {
        BookRentRoomList()
      }
      .hideTitleBar(true)
    }
  }

  build() {
    Navigation(this.indexPathStack) {
      Column() {
        Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
          TabContent() {
            Home()
          }.tabBar(this.TabBuilder(0, '首页', $r('app.media.tabbar_home'), $r('app.media.tabbar_home_active')))

          TabContent() {
            See()
          }.tabBar(this.TabBuilder(1, '想看', $r('app.media.tabbar_see'), $r('app.media.tabbar_see_active')))

          TabContent() {
            Service()
          }.tabBar(this.TabBuilder(2, '服务', $r('app.media.tabbar_service'), $r('app.media.tabbar_service_active')))

          TabContent() {
            Discover()
          }.tabBar(this.TabBuilder(3, '发现', $r('app.media.tabbar_discover'), $r('app.media.tabbar_discover_active')))

          TabContent() {
            My()
          }.tabBar(this.TabBuilder(4, '我的', $r('app.media.tabbar_my'), $r('app.media.tabbar_my_active')))
        }
        .vertical(false)
        .barMode(BarMode.Fixed)
        .onChange((index: number) => {
          // 将上个页面color存储起来
          this.colors[this.currentIndex] = {
            navBarBgColor: this.navBarBgColor,
            navBarFontColor: this.navBarFontColor
          }
          // 将当前页面的color赋值上去
          this.navBarFontColor = this.colors[index]?.navBarFontColor || 'rgb(255, 255, 255)'
          this.navBarBgColor = this.colors[index]?.navBarBgColor || 'rgba(255, 255, 255, 0)'

          this.currentIndex = index
        })
        .barHeight(rvp(50)) // 设置 tab 导航栏的高度，默认 56
        .scrollable(false)
        .width('100%')
        .height('100%')
        .backgroundColor($r('app.color.white'))
      }.height('100%')
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
    .navDestination(this.PagesMap)
  }
}

function LoginCode() {
  throw new Error('Function not implemented.');
}
