export interface IVipServiceItem {
  "name": string
  "content": number
}

export interface IHomeServiceItem {
  "icon": string
  "title": string
}

export interface IServiceActivity {
  "name": string
  "img": string
  "title": string
  "subTitle": string
}

export interface ICleaningServiceInfoItem {
  "img": string
  "title": string
  "subTitle": string
  "originalPrice": string
  "priceAfterDiscounts": string
}

export interface INewcomerZone {
  "img": string
}

export interface IServiceData {
  "vipServiceList": IVipServiceItem[]
  "homeServiceList": IHomeServiceItem[]
  "serviceActivity": IServiceActivity
  "newcomerZone": INewcomerZone
  "cleaningServiceInfo": ICleaningServiceInfoItem[]
}
