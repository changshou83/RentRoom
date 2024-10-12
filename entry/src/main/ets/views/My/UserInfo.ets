import Avatar from '../../components/Avatar'

import { responsiveFontSize, rvp } from '../../utils/responsive'

@Component
export default struct UserInfo {
  @StorageProp('token') token: string = '';
  @Consume('indexPathStack') indexPathStack: NavPathStack;
  @State avatarSrc: string = ''

  goLoginPhone() {
    this.indexPathStack.pushPathByName('LoginPhone', null);
  }

  build() {
    Row({ space: rvp(10) }) {
      Avatar({ src: this.avatarSrc, avatarSize: rvp(60) }).onClick(this.goLoginPhone.bind(this))
      if(this.token === '') {
        Column({ space: rvp(4) }) {
            Text('登录/注册').fontSize(responsiveFontSize.lg).fontColor($r('app.color.white')).fontWeight(700)
            Text('点击登录注册').fontSize(responsiveFontSize.sm).fontColor($r('app.color.white'))
        }.alignItems(HorizontalAlign.Start).onClick(this.goLoginPhone.bind(this))
      } else {
        Text('已登录').fontSize(responsiveFontSize.lg).fontColor($r('app.color.white')).fontWeight(700)
      }
    }.margin({ top: rvp(11) }).width('100%')
  }
}