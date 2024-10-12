import { IRoomRecommendItem } from "./HomeData"

export type IPaymentType = "月付" | "季付" | "半年付" | "年付"

export type IOrderBy = "area" | "price"

export type IOrderType = "asc" | "desc"

export interface IGetRentRoomListParams {
  "page": number
  "limit": number
  "provinceCode"?: string
  "cityCode"?: string
  "districtCode"?: string
  "minRent"?: string
  "maxRent"?: string
  "paymentType"?: IPaymentType
  "orderBy"?: IOrderBy,
  "orderType"?: IOrderType,
}

export interface IGetRentRoomListResponse {
  records: IRentRoomItem[]
  total: number
}

export interface IActivity {
  "title": string
  "textColor": string
  "textBackGroundColor": string
  "#text": string
  "icon": string
}

export interface IRentRoomItem extends IRoomRecommendItem {
  "activity"?: IActivity
}

export interface IProvinceItem {
  code: string;
  name: string;
}

export interface ICityItem {
  "code": string
  "name": string
  "provinceCode": string
}

export interface IDistrictItem {
  "code": string
  "name": string
  "cityCode": string
  "provinceCode": string
}

export interface GetCityListParams {
  provinceCode: string
}

export interface GetDistrictListParams {
  cityCode: string
}

export interface IRentPriceItem {
  id: number;
  minRent: string;
  maxRent: string;
  text: string;
}

export interface LocationData {
  provinceList: IProvinceItem[];
  cityList: ICityItem[];
  districtList: IDistrictItem[];
  provinceCode: string;
  cityCode: string;
  districtCode: string;
  isSearch: boolean;
  searchProvinceCode: string;
  searchCityCode: string;
  searchDistrictCode: string;
  searchDistrictName: string;
}

export interface RentPriceData {
  rentPriceList: IRentPriceItem[];
  rentPrice: Partial<IRentPriceItem>;
  isSearch: boolean;
  searchRentPrice: Partial<IRentPriceItem>;
}

export interface PaymentTypeData {
  paymentTypeList: IPaymentType[],
  isSearch: boolean,
  paymentType: IPaymentType | '',
  searchPaymentType: IPaymentType | ''
}

export interface IHousePictureItem {
  "spaceName": string
  "picList": string[]
}

export type IHousePictureList = IHousePictureItem[]

export interface IDistanceInfo {
  "distance": string
  "line": string
  "name": string
}

export interface IRentTerm {
  "checkInTime": string
  "term": string
  "kitchen": string
  "lift": string
  "seeTime": string
  "year": string
  "renovation": string
  "grounding": string
  "heating": string
  "green": string
  "protection": string
  "house": string
}

export interface IMetaInfoItem {
  "name": string
  "desc": string
}

export type IMetaInfoList = IMetaInfoItem[]

export interface IDiscountsItem {
  "tagTxtBgAroundColor": string
  "image": string
  "txt": string
  "tagTxt": string
  "tagTxtColor": string
}

export type IDiscountsList = IDiscountsItem[]

export interface IHouseholdItemIcon {
  "icon": string
  "value":string
}

export interface IHouseholdItem {
  "name": string
  "itemList": IHouseholdItemIcon[]
}

export type IHouseholdList = IHouseholdItem[]

export interface ISupportItem {
  "image": string
  "title": string
  "subTitle": string
}

export type ISupportList = ISupportItem[]

export interface IRentInfoItem {
  "image": string
  "title": string
  "userTag": string
}

export type IRentInfoList = IRentInfoItem[]

export interface IRentRoomDetail extends Omit<IRentRoomItem, 'housePicture'> {
  "housePicture": IHousePictureList
  "rentPriceUnitListing": string
  "distance_info": IDistanceInfo
  "rentTerm": IRentTerm
  "metaInfo": IMetaInfoList
  "discounts": IDiscountsList
  "householdItem": IHouseholdList
  "support": ISupportList
  "rentInfo": IRentInfoList
}
