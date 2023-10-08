import "package:flutter/material.dart";
import "dart:math";

class diceRoller extends StatefulWidget {
  const diceRoller({super.key});
  @override
  State<StatefulWidget> createState() {
    return _diceRollerState();
  }
}

class _diceRollerState extends State<diceRoller> {
  var adiceimage = "assets/images/dice-2.png";
  void click() {
    setState(() {
      var dice = Random().nextInt(5) + 1;

      adiceimage = "assets/images/dice-$dice.png";
      print(dice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(adiceimage, width: 150),
        const SizedBox(height: 20),
        TextButton(
            onPressed: click,
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 20)),
            child: const Text('roll the dice'))
      ],
    );
  }
}
