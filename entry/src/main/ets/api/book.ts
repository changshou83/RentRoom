import { http } from '../utils/http'
import type { IBookInfo, IBookRentRoomList } from '../model/BookRentRoomList'

// 预约看房
export const bookRentRoomApi = (bookInfo: IBookInfo): Promise<void> => {
  return http.post<void>('/auth/house/reservation', bookInfo)
}

// 获取预约租房列表
export const getBookRentRoomListApi = (): Promise<IBookRentRoomList> => {
  return http.get<IBookRentRoomList>('/auth/house/history')
}
