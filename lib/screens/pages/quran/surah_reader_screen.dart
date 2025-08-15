import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class SurahReaderScreen extends StatefulWidget {
  final int surahNumber;

  const SurahReaderScreen({super.key, required this.surahNumber});

  @override
  State<SurahReaderScreen> createState() => _SurahReaderScreenState();
}

class _SurahReaderScreenState extends State<SurahReaderScreen> {
  bool showTranslation = true;
  String selectedTranslation = 'English';
  double fontSize = 25;
  String selectedFont = 'AlQalam';

  final List<String> fontOptions = [
    'Hafs',
    'MeQuran',
    'AlQalam',
    'UthmanTN',
    'almarai',
  ];

  final Map<String, String> translationNames = {
    'English': 'EN',
    'Urdu': 'UR',
    'Roman': 'Roman',
  };

  @override
  Widget build(BuildContext context) {
    int verseCount = quran.getVerseCount(widget.surahNumber);
    String surahName = quran.getSurahName(widget.surahNumber);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(surahName),
        backgroundColor: Colors.black.withOpacity(0.3),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openSettingsPanel,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight + 24),
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: verseCount,
              itemBuilder: (context, index) {
                final verseNumber = index + 1;
                final verseText = quran.getVerse(
                  widget.surahNumber,
                  verseNumber,
                );
                final translation =
                    showTranslation ? _getTranslation(verseNumber) : '';
                final ayahNumber = _toQuranicVerseNumber(verseNumber);

                return Column(
                  children: [
                    Card(
                      color: Colors.white.withOpacity(0.85),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Text(
                                      verseText,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        fontFamily: selectedFont,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.teal.shade900,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      ayahNumber,
                                      style: TextStyle(
                                        fontSize: fontSize * 0.8,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'UthmanArabic',
                                        color: Colors.teal.shade900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (showTranslation) ...[
                              const SizedBox(height: 8),
                              Text(
                                translation,
                                style: TextStyle(
                                  fontSize: fontSize * 0.50,
                                  fontFamily: 'NotoNastaliqUrdu',
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 0),
                    //   child: Divider(
                    //     color: Colors.teal.shade200,
                    //     thickness: 1,
                    //     indent: 32,
                    //     endIndent: 32,
                    //   ),
                    // ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openSettingsPanel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Text Size',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            fontSize = (fontSize - 2).clamp(16, 40);
                          });
                        },
                      ),
                      Text(fontSize.toInt().toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            fontSize = (fontSize + 2).clamp(16, 40);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Font',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedFont,
                    onChanged: (value) {
                      setState(() {
                        selectedFont = value!;
                      });
                      Navigator.pop(context);
                    },
                    items:
                        fontOptions.map((font) {
                          return DropdownMenuItem(
                            value: font,
                            child: Text(font),
                          );
                        }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Translation',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedTranslation,
                    onChanged: (value) {
                      setState(() {
                        selectedTranslation = value!;
                      });
                      Navigator.pop(context);
                    },
                    items:
                        translationNames.keys.map((lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(translationNames[lang]!),
                          );
                        }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Show Translation',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: showTranslation,
                    onChanged: (val) {
                      setState(() {
                        showTranslation = val;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _getTranslation(int verseNumber) {
    switch (selectedTranslation) {
      case 'Urdu':
        return quran.getVerseTranslation(
          widget.surahNumber,
          verseNumber,
          translation: quran.Translation.urdu,
        );
      case 'Roman':
        return quran.getVerseTranslation(
          widget.surahNumber,
          verseNumber,
          translation: quran.Translation.enSaheeh,
        );
      case 'English':
      default:
        return quran.getVerseTranslation(
          widget.surahNumber,
          verseNumber,
          translation: quran.Translation.enSaheeh,
        );
    }
  }

  String _toQuranicVerseNumber(int number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number
        .toString()
        .split('')
        .map((d) => arabicDigits[int.parse(d)])
        .join();
  }
}
