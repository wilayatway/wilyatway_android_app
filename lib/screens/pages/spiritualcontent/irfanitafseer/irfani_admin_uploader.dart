import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IrfaniAdminUploader extends StatefulWidget {
  const IrfaniAdminUploader({super.key});

  @override
  State<IrfaniAdminUploader> createState() => _IrfaniAdminUploaderState();
}

class _IrfaniAdminUploaderState extends State<IrfaniAdminUploader> {
  final TextEditingController _jsonController = TextEditingController();
  bool _loading = false;

  Future<void> _pushToFirestore() async {
    final text = _jsonController.text.trim();
    if (text.isEmpty) return _showSnack('Please paste JSON content first');

    setState(() => _loading = true);
    try {
      final Map<String, dynamic> data = jsonDecode(text);
      final collection = FirebaseFirestore.instance.collection('irfani_tafseer');
      final docId = (data['id'] is String && (data['id'] as String).isNotEmpty)
          ? data['id'] as String
          : collection.doc().id;
      await collection.doc(docId).set(data);
      _showSnack('Pushed document: $docId');
    } catch (e) {
      _showSnack('Error: ${e.toString()}');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    _jsonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Irfani Uploader (Admin)'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!kReleaseMode)
              const Text(
                'Paste a single document JSON following the FIREBASE_STRUCTURE.md template and press Push.',
                style: TextStyle(fontSize: 14),
              ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _jsonController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '{ "id": "surah_fatiha", "titleEn": "...", ... }',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _loading ? null : _pushToFirestore,
                  icon: _loading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.upload),
                  label: const Text('Push to Firestore'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {
                    // insert example template
                    final example = {
                      "id": "surah_fatiha",
                      "titleEn": "Surah Al-Fatiha - The Opening",
                      "titleUr": "سورہ الفاتحہ",
                      "introductionEn": [
                        {
                          "sectionTitle": "Introduction: The Meaning of The Opening",
                          "paragraphs": [
                            "Surah Fatiha ka matlab hai 'The Opening'...",
                            "Yeh opening asal me realms ki opening hai..."
                          ]
                        }
                      ],
                      "introductionUr": [],
                      "ayats": [
                        {
                          "ayatNumber": 1,
                          "ayatTextAr": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                          "transliterationEn": "Bismillaahir Rahmaanir Raheem",
                          "transliterationUr": "بسم اللہ الرحمن الرحیم",
                          "descriptionEn": "In the Name of Allah...",
                          "descriptionUr": "اللہ کے نام سے...",
                          "tafseelEn": "Yahan Rahman aur Raheem ka zikr...",
                          "tafseelUr": "یہاں رحمان اور رحیم کا ذکر..."
                        }
                      ]
                    };
                    _jsonController.text = const JsonEncoder.withIndent('  ').convert(example);
                  },
                  child: const Text('Insert Example'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
