import 'package:flutter/material.dart';

class OtherLoginMethods extends StatelessWidget {
  const OtherLoginMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Or continue with"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/google_icon.png',
                  height: 35,
                  width: 50,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
