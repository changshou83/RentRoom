import BasicDataSource from "./BasicDataSource";
import { IOrderBy, IOrderType, IRentRoomItem } from "./RentRoomData_ts";

export interface ISortItem {
  id: number;
  icon: Resource;
  text: string;
  orderBy: IOrderBy | '';
  orderType: IOrderType;
}

export interface SortData {
  sortList: ISortItem[];
  sort: ISortItem;
}

export class RentRoomListDataSource extends BasicDataSource<IRentRoomItem> {}
