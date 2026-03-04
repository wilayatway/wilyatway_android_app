import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RuhaniIlajUploader extends StatefulWidget {
  const RuhaniIlajUploader({super.key});

  @override
  State<RuhaniIlajUploader> createState() => _RuhaniIlajUploaderState();
}

class _RuhaniIlajUploaderState extends State<RuhaniIlajUploader> {
  final TextEditingController _jsonController = TextEditingController();
  bool _loading = false;

  Future<void> _pushToFirestore() async {
    final text = _jsonController.text.trim();
    if (text.isEmpty) return _showSnack('Please paste JSON content first');

    setState(() => _loading = true);
    try {
      final Map<String, dynamic> data = jsonDecode(text);
      final collection = FirebaseFirestore.instance.collection('ruhani_ilaj');
      final docId = (data['id'] is String && (data['id'] as String).isNotEmpty)
          ? data['id'] as String
          : collection.doc().id;
      await collection.doc(docId).set(data);
      _showSnack('Pushed document: $docId');
      _jsonController.clear();
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
        title: const Text('Ruhani Ilaj Uploader (Admin)'),
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
                'Paste a single Ruhani Ilaj JSON and press Push.',
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
                  hintText: '{ "id": "hisar_e_akbar", "titleEn": "...", ... }',
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
                    final example = {
                      "id": "hisar_e_akbar",
                      "titleEn": "🛡️ Hisar-e-Akbar",
                      "titleUr": "🛡️ حصار اکبر",
                      "descriptionEn": "Nazr-e-Bad, Bala aur Jinnat se Hifazat ka Mujarrab Amal",
                      "descriptionUr": "نظرِ بد، بلا اور جنات سے حفاظت کا مجرب عمل",
                      "steps": [
                        {
                          "stepNumber": 1,
                          "titleEn": "Tayyari (Preparation)",
                          "titleUr": "تیاری",
                          "descriptionEn": "Paak saaf ho kar karein — wuzu mein hona behtar hai. Khade ho kar karna afzal hai, lekin baith kar bhi kar sakte hain.",
                          "descriptionUr": "پاک صاف ہو کر کریں — وضو میں ہونا بہتر ہے۔ کھڑے ہو کر کرنا افضل ہے، لیکن بیٹھ کر بھی کر سکتے ہیں۔",
                          "bulletPointsEn": null,
                          "bulletPointsUr": null
                        },
                        {
                          "stepNumber": 2,
                          "titleEn": "Ibtida (Start)",
                          "titleUr": "ابتدا",
                          "descriptionEn": "Bismillah parhein. 3 dafa Darood-e-Paak parhein.",
                          "descriptionUr": "بسم اللہ پڑھیں۔ 3 دفعہ درود پاک پڑھیں۔",
                          "bulletPointsEn": null,
                          "bulletPointsUr": null
                        }
                      ],
                      "tipEn": "Aakhir mein 3 baar arz karein: Ya Shaykh Syed Khawaja Mohammed Shah Makki Al Madad",
                      "tipUr": "آخر میں 3 بار عرض کریں: یا شیخ سید خواجہ محمد شاہ مکی المدد"
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
