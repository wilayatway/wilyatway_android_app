import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAvatarName extends StatelessWidget {
  const UserAvatarName({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const SizedBox.shrink();

    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        String displayName = user.displayName ?? '';
        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data();
          if (data != null && (data['name'] as String?) != null && (data['name'] as String).isNotEmpty) {
            displayName = data['name'];
          }
        }
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
      },
    );
  }
}
