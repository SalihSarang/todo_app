import 'package:flutter/material.dart';

class UserIdWidget extends StatelessWidget {
  final String userId;
  const UserIdWidget({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 40, left: 16, right: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.yellow.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.yellow.shade200),
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User ID',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.amber,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            SelectableText(
              userId,
              style: TextStyle(
                fontSize: 12,
                color: Colors.amber.shade800,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
