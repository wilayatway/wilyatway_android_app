import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAvatarName extends StatelessWidget {
  const UserAvatarName({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const SizedBox.shrink();
  String displayName = user.displayName ?? '';
  if (displayName.isEmpty) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/user_details');
      },
      child: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            displayName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
