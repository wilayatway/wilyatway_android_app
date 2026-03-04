import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserAvatarName extends StatelessWidget {
  const UserAvatarName({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isFirebaseInitialized(),
      builder: (context, initSnapshot) {
        if (!initSnapshot.hasData || !initSnapshot.data!) {
          return const SizedBox.shrink();
        }

        try {
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
              // Fallback to email if name is empty
              if (displayName.isEmpty) {
                displayName = user.email ?? '';
              }
              if (displayName.isEmpty) return const SizedBox.shrink();
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/user_details');
                },
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        displayName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } catch (e) {
          debugPrint('Error in UserAvatarName: $e');
          return const SizedBox.shrink();
        }
      },
    );
  }

  Future<bool> _isFirebaseInitialized() async {
    try {
      // If Firebase has already been initialized, this list will be non-empty.
      if (Firebase.apps.isNotEmpty) return true;

      // Try to initialize the default app (without options). In this project
      // `main.dart` should already call `Firebase.initializeApp(...)` with
      // options; this call is a safe fallback for other entry points.
      await Firebase.initializeApp();
      return true;
    } catch (e) {
      debugPrint('Firebase init check error: $e');
      // Return whether any Firebase app exists.
      return Firebase.apps.isNotEmpty;
    }
  }
}