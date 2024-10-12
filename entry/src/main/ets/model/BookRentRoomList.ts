export interface IBookRentRoomItem {
  "id": number;
  "userId": number;
  "houseId": string;
  "date": string;
  "name": string;
  "comment": string;
  img?: string;
  title?: string;
  subTitle?: string;
  distanceInfo?: string;
  rentPrice?: string;
}

export type IBookRentRoomList = IBookRentRoomItem[]

export interface IBookInfo {
  "name": string
  "date": string
  "houseId": string
  "phone": string
  "comment": string
}