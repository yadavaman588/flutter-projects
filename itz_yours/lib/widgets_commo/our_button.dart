import 'package:itz_yours/consts/consts.dart';

Widget ourButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(6),
      ),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
