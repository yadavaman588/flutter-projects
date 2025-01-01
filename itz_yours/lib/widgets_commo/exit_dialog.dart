import 'package:flutter/services.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/widgets_commo/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure want to exit"
            .text
            .fontFamily(bold)
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: redColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                textColor: whiteColor,
                title: "Yes"),
            ourButton(
                color: redColor,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                title: "No")
          ],
        )
      ],
    ).box.padding(const EdgeInsets.all(14)).color(lightGrey).roundedSM.make(),
  );
}
