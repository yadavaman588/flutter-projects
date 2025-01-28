import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // Sets the background color to white

      body: Center(
        child: Text(
          'Signup First',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
