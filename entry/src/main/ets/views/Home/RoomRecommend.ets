import { RoomRecommendDataSource } from '../../model/RoomRecommendDataSource'
import { getRoomRecommendListApi } from '../../api/home'

import { BORDER_RADIUS, PADDING } from '../../constants/size'
import { IRoomRecommendItem } from '../../model/HomeData';
import { ITagItem } from '../../model/HomeData';
import { rvp } from '../../utils/responsive';
import { RentRoomDetailRouteParams } from '../../model/RouteParams';

@Component
export default struct RoomRecommend {
  @Consume('indexPathStack') indexPathStack: NavPathStack;
  @State roomRecommendDataSource: RoomRecommendDataSource = new RoomRecommendDataSource([])

  aboutToAppear() {
    this.getRoomRecommendList();
  }

  async getRoomRecommendList() {
    const roomRecommendList = await getRoomRecommendListApi();
    this.roomRecommendDataSource = new RoomRecommendDataSource(roomRecommendList);
  }

  // 头部导航
  @Builder
  RoomNav() {
    Row() {
      Text() {
        Span('周边房源')
        Span('推荐').fontColor($r('app.color.primary'))
      }.fontSize(rvp(18))

      Row({ space: rvp(6) }) {
        Text('更多推荐').fontColor($r('app.color.gray_second')).fontSize(rvp(12))
        Image($r('app.media.arrow_right')).width(rvp(4)).height(rvp(8))
      }
      .onClick(() => {
        this.indexPathStack.pushPathByName('RentRoomList', null);
      })
    }
    .width('100%')
    .height(rvp(67))
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor($r('app.color.white'))
    .padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(23) })
  }

  @Builder
  RoomListItem(room: IRoomRecommendItem) {
    Stack() {
      Column() {
        Image(room.housePicture)
          .width('100%')
          .height(rvp(120))
          .objectFit(ImageFit.Fill)
          .borderRadius({ topLeft: BORDER_RADIUS, topRight: BORDER_RADIUS })

        Column() {
          Row() {
            Text() {
              Span(room.rentPriceListing).fontSize(rvp(16)).fontColor('#E03810')
              Span(room.rentPriceUnit).fontSize(rvp(14)).fontColor('#E03810')
            }.height(rvp(22))

            Text(room.rentArea + '㎡').fontSize(rvp(12)).fontColor($r('app.color.gray'))
          }.width('100%').justifyContent(FlexAlign.SpaceBetween)

          Text(room.houseTitle)
            .fontSize(rvp(14))
            .margin({ top: rvp(1) })
            .height(rvp(19))
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Row({ space: rvp(6) }) {
            ForEach(room.tags.slice(0, 2), (tag: ITagItem, index) => {
              Text(tag.name)
                .padding({ top: rvp(1), bottom: rvp(1), left: rvp(6), right: rvp(6) })
                .fontColor(index === 0 ? $r('app.color.white') : '#B3B3B3')
                .backgroundColor(index === 0 ? $r('app.color.primary') : $r('app.color.bg_gray'))
                .fontSize(rvp(12))
            }, (tag: ITagItem) => tag.name)
          }.width('100%').margin({ top: rvp(9) })
        }.padding(rvp(12)).alignItems(HorizontalAlign.Start).height(rvp(91))
      }.width('100%')
      // 预览图上层文字
      Image($r('app.media.room_text_bg')).width('100%').height(rvp(120))
      Row({ space: rvp(6) }) {
        Image($r('app.media.location')).width(rvp(12)).height(rvp(14))
        Text(room.address).fontSize(rvp(12)).fontColor($r('app.color.white'))
      }.margin({ left: rvp(8), top: rvp(99) })
    }.alignContent(Alignment.TopStart).backgroundColor($r('app.color.white'))
  }

  // 房源列表
  @Builder
  RoomList() {
    if (this.roomRecommendDataSource.roomRecommendList.length) {
      Grid() {
        LazyForEach(this.roomRecommendDataSource, (room: IRoomRecommendItem) => {
          GridItem() {
            this.RoomListItem(room)
          }
          .height(rvp(210))
          .onClick(() => {
            const params: RentRoomDetailRouteParams = { id: room.id };
            this.indexPathStack.pushPathByName('RentRoomDetail', params)
          })
        }, (room: IRoomRecommendItem) => room.id)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(rvp(8))
      .rowsGap(rvp(8))
      .width('100%')
      .padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(8), bottom: rvp(8) })
      .backgroundColor($r('app.color.bg_gray'))
      .borderRadius(BORDER_RADIUS)
    }
  }

  build() {
    Column() {
      this.RoomNav()
      this.RoomList()
    }.width('100%')
  }
}