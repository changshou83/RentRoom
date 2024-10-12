import { getRentRoomDetailApi } from "../../api/rentRoom";
import ScrollContainer, { IColor } from "../../components/ScrollContainer";
import { BORDER_RADIUS_S, PADDING } from "../../constants/size";
import { ITagList } from "../../model/HomeData";
import {
  IDiscountsItem,
  IDistanceInfo,
  IHouseholdList,
  IHousePictureList, IMetaInfoItem,
  IRentInfoList,
  IRentRoomDetail,
  IRentTerm,
  ISupportList} from "../../model/RentRoomData_ts";
import { globalEmitter } from "../../utils/emitter";
import { responsiveFontSize, rvp } from "../../utils/responsive";
import Book from "../../views/RentRoomDetail/Book";
import BookInfo from "../../views/RentRoomDetail/BookInfo";
import DiscountsList from "../../views/RentRoomDetail/DiscountsList";
import HouseholdItem from "../../views/RentRoomDetail/HouseholdItem";
import MetaInfo from "../../views/RentRoomDetail/MetaInfo";
import NavBar from "../../views/RentRoomDetail/NavBar";
import NavSwiper from "../../views/RentRoomDetail/NavSwiper";
import RentInfo from "../../views/RentRoomDetail/RentInfo";
import RentPrice from "../../views/RentRoomDetail/RentPrice";
import RentTerm from "../../views/RentRoomDetail/RentTerm";
import SupportList from "../../views/RentRoomDetail/SupportList";
import TagList from "../../views/RentRoomDetail/TagList";

@Entry
@Component
export default struct RentRoomDetail {
  @Consume('indexPathStack') indexPathStack: NavPathStack;
  @Prop roomId: string;
  @StorageProp('token') token: string = '';

  @State housePictureList: IHousePictureList = []
  @State room: Partial<IRentRoomDetail> = {
    rentPriceUnitListing: '',
    rentPriceUnit: ''
  }
  @State discountsList: IDiscountsItem[] = []
  @State metaInfoList: IMetaInfoItem[] = []
  @State distanceInfo: Partial<IDistanceInfo> = {}
  @State tagList: ITagList = []
  @State rentTerm: Partial<IRentTerm> = {}
  @State rentInfoList: IRentInfoList = []
  @State householdList: IHouseholdList = []
  @State supportList: ISupportList = []

  aboutToAppear() {
    this.getRentRoomDetail()
  }
  async getRentRoomDetail() {
    const result = await getRentRoomDetailApi(this.roomId)
    this.room = result;
    this.housePictureList = this.room.housePicture!;
    this.discountsList = this.room.discounts!;
    this.metaInfoList = this.room.metaInfo!;
    this.distanceInfo = this.room.distance_info!;
    this.tagList = this.room.tags!;
    this.rentTerm = this.room.rentTerm!;
    this.rentInfoList = this.room.rentInfo!;
    this.householdList = this.room.householdItem!;
    this.supportList = this.room.support!;
  }

  @Builder
  navBuilder($$: IColor) {
    NavBar({ title: this.room.houseTitle })
  }

  @Builder
  ReadMoreButton() {
    Button('查看全部内容')
      .type(ButtonType.Normal)
      .width('100%')
      .height(rvp(44))
      .fontSize(responsiveFontSize.sm)
      .fontColor('#ABA9AC')
      .margin({ top: rvp(25) })
      .backgroundColor($r('app.color.white'))
      .border({ width: 1, color: '#F5F5F5', radius: rvp(BORDER_RADIUS_S) })
  }

  @Builder contentBuilder() {
    NavSwiper({ housePictureList: this.housePictureList })
    Column() {
      RentPrice({ rentPriceUnitListing: this.room.rentPriceUnitListing, rentPriceUnit: this.room.rentPriceUnit })
      DiscountsList({ discountsList: this.discountsList })
      MetaInfo({ metaInfoList: this.metaInfoList, distanceInfo: this.distanceInfo })
      TagList({ tagList: this.tagList })
      RentTerm({ rentTerm: this.rentTerm })
      RentInfo({ rentInfoList: this.rentInfoList })
      HouseholdItem({ householdList: this.householdList })
      SupportList({ supportList: this.supportList })
      this.ReadMoreButton()
    }.padding({ left: rvp(PADDING), right: rvp(PADDING), bottom: rvp(50) }).backgroundColor($r('app.color.white'))
  }

  handleBook() {
    if (!this.token) {
      this.indexPathStack.pushPathByName('LoginPhone', null)
      return
    }
    globalEmitter.emit('openBookInfo')
  }

  build() {
    Stack() {
      ScrollContainer({
        navBuilder: this.navBuilder.bind(this),
        contentBuilder: () => {
          this.contentBuilder();
        },
        bgColor: '#FFFFFF',
        restoreBgColor: '#FFFFFF'
      })
      Book({ handleBook: this.handleBook.bind(this) })
      BookInfo({ roomId: this.roomId })
    }.width('100%').height('100%').alignContent(Alignment.Bottom)
  }
}