import "package:flutter/material.dart";
import "package:flutter_application_1/diceRoller.dart";

class GradientC extends StatelessWidget {
  const GradientC({super.key, required this.l1});
  final List<Color> l1;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: l1,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: const Center(child: diceRoller()));
  }
}
