import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DaroodPopup {
  static Future<void> show(BuildContext context) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('daroods').get();
      if (snapshot.docs.isEmpty) return;

      final randomDoc = snapshot.docs[Random().nextInt(snapshot.docs.length)];
      final data = randomDoc.data();

      final arabic = data['arabic'] ?? '';
      final roman = data['roman'] ?? '';
      final urdu = data['urdu'] ?? '';
      final english = data['english'] ?? '';

      bool showRoman = false; // Moved outside StatefulBuilder

      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "بِسْمِ اللّٰہِ الرَّحْمٰنِ الرَّحِیْمِ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'UthmanArabic',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      if (!showRoman) ...[
                        Text(
                          arabic,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'UthmanArabic',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          urdu,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'AlviNastaleeq',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          english,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ] else ...[
                        Text(
                          roman,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          english,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {
                          setState(() => showRoman = !showRoman);
                        },
                        child: Text(
                          showRoman
                              ? 'Show in Arabic'
                              : 'Show in English',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("I'll Recite Later"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Done"),
                  ),
                ],
              );
            },
          );
        },
      );
    } catch (e) {
      debugPrint("Error fetching Darood: $e");
    }
  }
}
