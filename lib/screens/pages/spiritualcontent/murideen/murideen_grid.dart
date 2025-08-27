import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: unused_element
class _MurideenGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final void Function(Map<String, dynamic>) onTap;
  const _MurideenGrid({required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'For Murideen',
            style: TextStyle(
              fontSize: 22,
              color: Color.fromARGB(255, 246, 232, 211),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'You have to login or signup to access this section.',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
          const SizedBox(height: 40),
          Divider(color: Colors.white24, thickness: 1),
          const SizedBox(height: 10),
        ],
      );
    }
    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        bool isMureed = false;
        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data != null && data['isMureed'] == true) {
            isMureed = true;
          }
        }
        if (!isMureed) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'For Murideen',
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 246, 232, 211),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'This section is only for Murideen.',
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
              const SizedBox(height: 40),
              Divider(color: Colors.white24, thickness: 1),
              const SizedBox(height: 10),
            ],
          );
        }
        // Show grid if isMureed
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'For Murideen',
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 246, 232, 211),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = (constraints.maxWidth / 120).floor().clamp(
                  3,
                  6,
                );
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _GridItem(
                      icon: item['icon'],
                      title: item['title'],
                      onTap: () => onTap(item),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 40),
            Divider(color: Colors.white24, thickness: 1),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
class _GridItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _GridItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 60,
            child: Icon(
              icon,
              size: 50,
              color: const Color.fromARGB(255, 33, 33, 33),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
