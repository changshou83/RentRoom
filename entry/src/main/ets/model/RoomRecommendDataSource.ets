import { IRoomRecommendItem } from "./HomeData";

export class RoomRecommendDataSource implements IDataSource {
  roomRecommendList: IRoomRecommendItem[] = []

  constructor(roomRecommendList: IRoomRecommendItem[]) {
    this.roomRecommendList = roomRecommendList;
  }

  getData(index: number) {
    return this.roomRecommendList[index];
  }

  totalCount() {
    return this.roomRecommendList.length;
  }

  registerDataChangeListener() {
  }

  unregisterDataChangeListener() {
  }
}