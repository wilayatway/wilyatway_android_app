import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('User Details')),
        body: const Center(child: Text('No user logged in.')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User data not found.'));
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${data['name'] ?? ''}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Email: ${data['email'] ?? ''}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Phone: ${data['phone'] ?? ''}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Who Are You: ${data['whoAreYou'] ?? ''}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                Text('Gender: ${data['gender'] ?? ''}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 12),
                // Password removed for anonymous authentication
              ],
            ),
          );
        },
      ),
    );
  }
}
