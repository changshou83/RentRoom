import type { IPlanItem } from '../../model/HomeData';
import { rvp } from '../../utils/responsive';

@Component
export default struct PlanList {
  @Prop planList: IPlanItem[];

  build() {
    Row() {
      ForEach(this.planList, (plan: IPlanItem) => {
        Image(plan.imageURL)
          .width(rvp(78))
          .height(rvp(60))
          .objectFit(ImageFit.Fill)
      }, (plan: IPlanItem) => plan.id.toString())
    }
    .width('100%')
    .margin({ top: rvp(18) })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}