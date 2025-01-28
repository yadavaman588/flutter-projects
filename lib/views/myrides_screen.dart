import 'package:flutter/material.dart';

class MyRidesScreen extends StatelessWidget {
  const MyRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // Sets the background color to white

      body: Center(
        child: Text(
          'There are no rides available',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
