import { http } from '../utils/http';
import type { IHomeData, IRoomRecommendItem } from '../model/HomeData';

// 获取首页数据
export const getHomeDataApi = (): Promise<IHomeData> => {
  return http.get<IHomeData>('/home/info');
}

// 获取首页周边房源数据
export const getRoomRecommendListApi = (): Promise<IRoomRecommendItem[]> => {
  return http.get<IRoomRecommendItem[]>('/house/nearbyHouses')
}