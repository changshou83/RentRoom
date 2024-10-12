export interface IDanMuItem {
  "avatar": string
  "content": string
}

export interface IMainPost {
  "followerNum": number
  "title": string
  "userAvatar": string
  "userName": string
  "postContent": string
}

export interface IContentBlockItem {
  img: string
}

export interface IPostZone {
  "mainPost": IMainPost
  "contentBlockList": IContentBlockItem[]
}

export interface IBenefit {
  "title": string
  "img": string
}

export interface IDiscoverData {
  "danMuList1": IDanMuItem[],
  "danMuList2": IDanMuItem[],
  "postZone": IPostZone,
  "benefits": IBenefit[]
}