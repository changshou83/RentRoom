import { http } from '../utils/http';
import type {
  GetCityListParams,
  GetDistrictListParams,
  ICityItem,
  IDistrictItem,
  IGetRentRoomListParams,
  IGetRentRoomListResponse,
  IProvinceItem,
  IRentRoomDetail
} from '../model/RentRoomData_ts';

// 获取租房列表数据
export const getRentRoomListApi = (params: IGetRentRoomListParams): Promise<IGetRentRoomListResponse> => {
  return http.get<IGetRentRoomListResponse>('/house/search', params)
}

// 获取省份数据
export const getProvinceListApi = (): Promise<IProvinceItem[]> => {
  return http.get<IProvinceItem[]>('/province')
}

// 获取城市数据
export const getCityListApi = (provinceCode: string): Promise<ICityItem[]> => {
  const params: GetCityListParams = { provinceCode }
  return http.get<ICityItem[]>('/city', params)
}

// 获取区县数据
export const getDistrictListApi = (cityCode: string): Promise<IDistrictItem[]> => {
  const params: GetDistrictListParams = { cityCode }
  return http.get<IDistrictItem[]>('/area', params)
}

// 获取租房详情数据
export const getRentRoomDetailApi = (id: string): Promise<IRentRoomDetail> => {
  return http.get<IRentRoomDetail>('/house/detail', { id })
}
