import 'package:flutter/material.dart';

class WelcomeIcon extends StatelessWidget {
  const WelcomeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Icon(Icons.lock_outline, size: 80),
          SizedBox(height: 16),
          Text(
            "Welcome Back",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
