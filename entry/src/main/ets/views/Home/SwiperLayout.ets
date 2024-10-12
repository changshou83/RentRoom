import { BannerListDataSource } from '../../model/BannerListDataSource';
import { IBannerItem } from '../../model/HomeData';
import { getWindowTopHeight } from '../../utils/responsive';
import { rvp } from '../../utils/responsive';

@Component
export default struct SwiperLayout {
  @ObjectLink bannerList: BannerListDataSource;

  build() {
    Swiper() {
      LazyForEach(this.bannerList, (banner: IBannerItem) => {
        Image(banner.imageURL)
          .width('100%')
          .height(rvp(175) + getWindowTopHeight())
          .objectFit(ImageFit.Fill)
      }, (banner: IBannerItem) => banner.id.toString())
    }
    .loop(true)
    .indicator(
      new DotIndicator()
        .color($r('app.color.indicator_color'))
        .selectedColor($r('app.color.indicator_active_color'))
    )
  }
}