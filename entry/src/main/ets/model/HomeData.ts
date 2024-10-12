export interface IHomeData {
  "bannerList": IBannerItem[]
  "navList": INavItem[]
  "tileList": ITileItem[]
  "planList": IPlanItem[]
  "adPicture": string
}

// 计划列表类型
export interface IPlanItem {
  "id": number
  "imageURL": string
}

// 瓷片列表类型
export interface ITileItem {
  "id": number
  "imageURL": string
  "title": string
  "sub_title": string
}

// 导航列表类型
export interface INavItem {
  "id": number
  "title": string
  "imageURL": string
}

// 轮播图类型
export interface IBannerItem {
  "id": number
  "name": string
  "imageURL": string
}

// 推荐列表数据
export interface ITagItem {
  "name": string
}

export type ITagList = ITagItem[]

export interface IRoomRecommendItem {
  "id": string
  "housePicture": string
  "tags": ITagList
  "houseTitle": string
  "address": string
  "rentArea": string
  "rentPriceUnit": string
  "rentPriceListing": string
}

