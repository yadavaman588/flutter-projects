import "package:flutter/material.dart";
import "package:flutter_application_1/gradientC.dart";

void main() {
  runApp(const MaterialApp(
      home: Scaffold(
    body: GradientC(
      l1: [Color.fromARGB(255, 20, 8, 46), Color.fromARGB(255, 20, 8, 46)],
    ),
  )));
}
