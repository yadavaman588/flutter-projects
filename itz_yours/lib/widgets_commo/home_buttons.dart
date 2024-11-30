import 'package:itz_yours/consts/consts.dart';

Widget homeButtons(
    {required width,
    required height,
    required icon,
    onPress,
    required String title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon, width: 26),
      10.heightBox,
      title.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.rounded.size(width, height).shadowSm.white.make();
}
