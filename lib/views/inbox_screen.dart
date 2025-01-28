import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // Sets the background color to white

      body: Center(
        child: Text(
          'Start a chat',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
