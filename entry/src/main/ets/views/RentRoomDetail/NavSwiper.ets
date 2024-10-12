import { rvp, responsiveFontSize, getWindowTopHeight } from '../../utils/responsive'

import BasicDataSource from '../../model/BasicDataSource'
import type { IHousePictureItem, IHousePictureList } from '../../model/RentRoomData_ts'
import { PADDING } from '../../constants/size';

interface HousePicture {
  url: string;
  currentTabIndex: number;
}

@Component
export default struct NavSwiper {
  @Link @Watch('handleHousePictureListChange') housePictureList: IHousePictureList
  @State housePictureListDataSource: BasicDataSource<HousePicture> = new BasicDataSource()
  @State currentTabIndex: number = 0
  @State isGoCurrentTabIndexImage: boolean = false

  scroller: Scroller = new Scroller()

  handleHousePictureListChange() {
    const list = this.housePictureList.reduce((p: HousePicture[], c: IHousePictureItem, index: number) => {
      return [...p, ...c.picList.map(pic => {
        const result: HousePicture = { url: pic, currentTabIndex: index };
        return result;
      })]
    }, [])
    this.housePictureListDataSource.pushDataList(list);
  }

  setCurrentTabIndex(index: number) {
    this.currentTabIndex = index;
    this.goCurrentTabIndexImage()
  }

  goCurrentTabIndexImage() {
    const index = this.housePictureListDataSource.data.findIndex(pic => {
      return pic.currentTabIndex === this.currentTabIndex
    })
    this.scroller.scrollTo({
      xOffset: rvp(318) * index + rvp(10) * (index - 1),
      yOffset: 0,
      animation: {
        duration: 500,
        curve: Curve.EaseIn
      }
    })
    this.isGoCurrentTabIndexImage = true;
    setTimeout(() => {
      this.isGoCurrentTabIndexImage = false;
    }, 500)
  }

  handleListScrollIndex(start: number) {
    if (this.isGoCurrentTabIndexImage) return;
    const pic = this.housePictureListDataSource.getData(start);
    if (pic) {
      this.currentTabIndex = pic.currentTabIndex;
    }
  }

  @Builder NavBar() {
    List({ space: rvp(16) }) {
      ForEach(this.housePictureList, (pic: IHousePictureItem, index: number) => {
        ListItem() {
          Column({ space: rvp(4) }) {
            Text(pic.spaceName + `(${pic.picList.length})`)
              .fontSize(responsiveFontSize.md)
              .fontColor(this.currentTabIndex === index ? $r('app.color.black') : $r('app.color.gray_second'))
            if (this.currentTabIndex === index) {
              Divider().width(rvp(16)).height(rvp(2)).color($r('app.color.primary'))
            }
          }
        }.onClick(this.setCurrentTabIndex.bind(this, index))
      }, (pic: IHousePictureItem) => pic.spaceName)
    }
    .width('100%')
    .scrollBar(BarState.Off)
    .listDirection(Axis.Horizontal)
  }

  @Builder PicList() {
    List({ space: rvp(10), scroller: this.scroller }) {
      LazyForEach(this.housePictureListDataSource, (pic: HousePicture) => {
        ListItem() {
          Image(pic.url).width(rvp(318)).height(rvp(192)).objectFit(ImageFit.Fill)
        }
      }, (pic: HousePicture) => pic.url)
    }.width('100%').listDirection(Axis.Horizontal).onScrollIndex(this.handleListScrollIndex.bind(this))
  }

  build() {
    Column({ space: rvp(16) }) {
      this.NavBar()
      this.PicList()
    }
    .width('100%')
    .padding({ left: rvp(PADDING), top: rvp(44 + 16) + getWindowTopHeight() })
    .backgroundColor($r('app.color.white'))
  }
}