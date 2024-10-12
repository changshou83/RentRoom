import { getBookRentRoomListApi } from '../../api/book'
import PageNavBar from '../../components/PageNavBar'
import ScrollContainer from '../../components/ScrollContainer'
import { PADDING } from '../../constants/size'
import { IBookRentRoomItem, IBookRentRoomList } from '../../model/BookRentRoomList'
import { rvp, responsiveFontSize } from '../../utils/responsive'

@Entry
@Component
export default struct BookRentRoomList {
  @State bookList: IBookRentRoomList = []

  aboutToAppear() {
    this.getBookRentRoomList()
  }

  async getBookRentRoomList() {
    this.bookList = await getBookRentRoomListApi()
  }

  @Builder NavBarRender() {
    PageNavBar({ title: '预约看房' })
  }

  @Builder ContentRender() {
    Row() {
    }.height(rvp(44))

    List({ space: rvp(16) }) {
      ForEach(this.bookList, (book: IBookRentRoomItem) => {
        ListItem() {
          Column({ space: rvp(4) }) {
            Row() {
              Text(book.date + '全天 随时可看').fontSize(responsiveFontSize.xs).fontColor($r('app.color.gray'))
            }
            Row({ space: rvp(8) }) {
              Image(book.img).width(rvp(120)).height(rvp(120)).objectFit(ImageFit.Fill).borderRadius(rvp(12))
              Column() {
                Column({ space: rvp(8) }) {
                  Text(book.title).maxLines(2).textOverflow({ overflow: TextOverflow.Ellipsis })
                  Text(book.subTitle).fontSize(responsiveFontSize.xs).fontColor($r('app.color.gray'))
                  Text(book.distanceInfo).fontSize(responsiveFontSize.xs).fontColor($r('app.color.gray'))
                }.alignItems(HorizontalAlign.Start).width('100%')
                Row() {
                  Text(book.rentPrice).fontColor('#E03810')
                  Text('去咨询').fontColor($r('app.color.primary')).fontSize(responsiveFontSize.sm)
                }.justifyContent(FlexAlign.SpaceBetween).width('100%')
              }.width(rvp(200)).height(rvp(120)).padding({ top: rvp(10), bottom: rvp(10) }).justifyContent(FlexAlign.SpaceBetween).alignItems(HorizontalAlign.Start)
            }
          }.alignItems(HorizontalAlign.Start).width('100%')
        }.width('100%')
      }, (book: IBookRentRoomItem) => book.id.toString())
    }.padding(rvp(PADDING))
  }

  build() {
    Column() {
      ScrollContainer({
        navBuilder: this.NavBarRender.bind(this),
        contentBuilder: this.ContentRender.bind(this),
      })
    }.height('100%')
  }
}