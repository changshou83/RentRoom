import { rvp } from '../utils/responsive';

@Component
export default struct Drawer {
  @Link show: boolean;
  @BuilderParam render: () => void;

  build() {
    Stack() {
      Column() {}
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.black'))
      .opacity(this.show ? 0.7 : 0)
      .animation({ duration: 200 })
      .onClick(() => {
        this.show = false;
      })

      Column() {
        this.render()
      }
      .backgroundColor('#F6F6F6')
      .width('100%')
      .height(this.show ? 'auto' : 0)
      .animation({ duration: 200 })
      .padding(rvp(15))
      .borderRadius({
        topLeft: rvp(10),
        topRight: rvp(10)
      })
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
    .zIndex(this.show ? 999 : -1)
    .animation({ duration: 200 })
    .alignContent(Alignment.BottomStart)
  }
}