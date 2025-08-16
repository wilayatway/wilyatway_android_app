import 'dart:ui';
import 'package:flutter/material.dart';

class SpiritualGlossaryPage extends StatefulWidget {
  const SpiritualGlossaryPage({super.key});

  @override
  _SpiritualGlossaryPageState createState() => _SpiritualGlossaryPageState();
}

class _SpiritualGlossaryPageState extends State<SpiritualGlossaryPage> {
  // 0: Roman Urdu (default), 1: English, 2: Urdu
  int _selectedLang = 0;

  final List<Map<String, Map<String, String>>> glossary = [
    {
      "term": {
        "roman": "Muraqaba",
        "english": "Meditation",
        "urdu": "مراقبہ"
      },
      "definition": {
        "roman": "Sufi amal jismein dil ko Allah par mabni kiya jata hai.",
        "english": "Deep meditation in Sufi practice, focusing the heart on Allah.",
        "urdu": "صوفی عمل جس میں دل کو اللہ پر مرکوز کیا جاتا ہے۔"
      }
    },
    {
      "term": {
        "roman": "Kashf",
        "english": "Unveiling",
        "urdu": "کشف"
      },
      "definition": {
        "roman": "Posheeda roohani haqaiq ka zaahir hona.",
        "english": "Unveiling of hidden spiritual truths.",
        "urdu": "پوشیدہ روحانی حقائق کا ظاہر ہونا۔"
      }
    },
    {
      "term": {
        "roman": "Dhikr",
        "english": "Remembrance",
        "urdu": "ذکر"
      },
      "definition": {
        "roman": "Allah ke naam ki takraar se yaad.",
        "english": "Remembrance of Allah through repeated recitation of His names.",
        "urdu": "اللہ کے نام کی تکرار سے یاد۔"
      }
    },
    {
      "term": {
        "roman": "Fana",
        "english": "Annihilation",
        "urdu": "فنا"
      },
      "definition": {
        "roman": "Khud ko Allah mein fanaa kar dena.",
        "english": "Spiritual annihilation of the self in God.",
        "urdu": "خود کو اللہ میں فنا کر دینا۔"
      }
    },
    {
      "term": {
        "roman": "Baqa",
        "english": "Eternal Existence",
        "urdu": "بقا"
      },
      "definition": {
        "roman": "Fana ke baad Allah mein hamesha rehna.",
        "english": "Eternal existence in God after Fana.",
        "urdu": "فنا کے بعد اللہ میں ہمیشہ رہنا۔"
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.15),
        elevation: 0,
        title: Text(
          "Spiritual Glossary",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.transparent),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg2.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, kToolbarHeight + 8, 12, 12),
            child: Column(
              children: [
                // Language toggle
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LangTextButton(
                        label: 'Urdu',
                        selected: _selectedLang == 0,
                        onTap: () => setState(() => _selectedLang = 0),
                      ),
                      SizedBox(width: 18),
                      _LangTextButton(
                        label: 'English',
                        selected: _selectedLang == 1,
                        onTap: () => setState(() => _selectedLang = 1),
                      ),
                      SizedBox(width: 18),
                      _LangTextButton(
                        label: 'اردو',
                        selected: _selectedLang == 2,
                        onTap: () => setState(() => _selectedLang = 2),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: glossary.length,
                    itemBuilder: (context, index) {
                      final item = glossary[index];
                      String langKey = _selectedLang == 0
                          ? 'roman'
                          : _selectedLang == 1
                              ? 'english'
                              : 'urdu';
                      return Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 500,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item["term"]![langKey]!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                        textDirection: langKey == 'urdu' ? TextDirection.rtl : TextDirection.ltr,
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        item["definition"]![langKey]!,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white.withOpacity(0.9),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textDirection: langKey == 'urdu' ? TextDirection.rtl : TextDirection.ltr,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LangTextButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _LangTextButton({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2), // Add space below text and underline
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
                decoration: selected ? TextDecoration.underline : TextDecoration.none,
                decorationThickness: 2,
                decorationColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
