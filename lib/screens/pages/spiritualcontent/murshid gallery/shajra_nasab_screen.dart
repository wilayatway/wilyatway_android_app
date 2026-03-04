import 'package:flutter/material.dart';

class ShajraNasabScreen extends StatefulWidget {
  const ShajraNasabScreen({super.key});

  @override
  State<ShajraNasabScreen> createState() => _ShajraNasabScreenState();
}

class _ShajraNasabScreenState extends State<ShajraNasabScreen> {
  int selectedIndex = 0;

  final List<String> _languages = ['English', 'Urdu', 'Hindi'];

  final List<String> _lineageEnglish = [
    "Sayyiduna Muhammad Rasool Allah ﷺ",
    "Imam Ali (علیہ السلام)",
    "Imam Hasan (علیہ السلام)",
    "Imam Hussain (علیہ السلام)",
    "Imam Sajjad (علیہ السلام)",
    "Imam Baqar (علیہ السلام)",
    "Imam Jafar Sadiq (علیہ السلام)",
    "Imam Musa Kazim (علیہ السلام)",
    "Imam Ali Raza (علیہ السلام)",
    "Imam Ali Taqi (علیہ السلام)",
    "Imam Ali Naqi (علیہ السلام)",
    "Imam Ali Haadi (علیہ السلام)",
    "Ismail Harifa (رحمة الله عليه)",
    "Syed Aqeel (رحمة الله عليه)",
    "Syed Haroon (رحمة الله عليه)",
    "Syed Hamza (رحمة الله عليه)",
    "Syed Jafar (رحمة الله عليه)",
    "Syed Zaid (رحمة الله عليه)",
    "Syed Qasim (رحمة الله عليه)",
    "Syed Ibrahim Jawwadi (رحمة الله عليه)",
    "Syed Muhammad Shuja’i (رحمة الله عليه)",
    "Syed Muhammad Shah Makki (رحمة الله عليه)",
    "Syed Sadr-ud-Deen Shah Rizvi (رحمة الله عليه)",
    "Syed Ghulam Shah Rizvi (رحمة الله عليه)",
    "Syed Muhammad Shah Rizvi (رحمة الله عليه)",
    "Syed Ali Ahmad Shah Rizvi (رحمة الله عليه)",
    "Syed Ahsan Ahmad Shah Rizvi (رحمة الله عليه)",
    "Syed Tawfiq Ahmad Shah Rizvi (رحمة الله عليه)",
    "Syed Faraz Rizvi — Al-Mubārak",
  ];

  final List<String> _lineageUrdu = [
    "سیدنا محمد رسول اللہ ﷺ",
    "امام علی (علیہ السلام)",
    "امام حسن (علیہ السلام)",
    "امام حسین (علیہ السلام)",
    "امام سجاد (علیہ السلام)",
    "امام باقر (علیہ السلام)",
    "امام جعفر صادق (علیہ السلام)",
    "امام موسیٰ کاظم (علیہ السلام)",
    "امام علی رضا (علیہ السلام)",
    "امام علی تقی (علیہ السلام)",
    "امام علی نقی (علیہ السلام)",
    "امام علی ہادی (علیہ السلام)",
    "اسماعیل حریفا (رحمة الله عليه)",
    "سید عقیل (رحمة الله عليه)",
    "سید ہارون (رحمة الله عليه)",
    "سید حمزہ (رحمة الله عليه)",
    "سید جعفر (رحمة الله عليه)",
    "سید زید (رحمة الله عليه)",
    "سید قاسم (رحمة الله عليه)",
    "سید ابراہیم جوادی (رحمة الله عليه)",
    "سید محمد شجاعی (رحمة الله عليه)",
    "سید محمد شاہ مکی (رحمة الله عليه)",
    "سید صدرالدین شاہ رضوی (رحمة الله عليه)",
    "سید غلام شاہ رضوی (رحمة الله عليه)",
    "سید محمد شاہ رضوی (رحمة الله عليه)",
    "سید علی احمد شاہ رضوی (رحمة الله عليه)",
    "سید احسن احمد شاہ رضوی (رحمة الله عليه)",
    "سید توفیق احمد شاہ رضوی (رحمة الله عليه)",
    "سید فراز رضوی — المبارک",
  ];

  final List<String> _lineageHindi = [
    "सैयदुना मोहम्मद रसूल अल्लाह ﷺ",
    "इमाम अली (अलैहिस्सलाम)",
    "इमाम हसन (अलैहिस्सलाम)",
    "इमाम हुसैन (अलैहिस्सलाम)",
    "इमाम सज्जाद (अलैहिस्सलाम)",
    "इमाम बाक़िर (अलैहिस्सलाम)",
    "इमाम जाफ़र सादिक़ (अलैहिस्सलाम)",
    "इमाम मूसा काज़िम (अलैहिस्सलाम)",
    "इमाम अली रज़ा (अलैहिस्सलाम)",
    "इमाम अली ताक़ी (अलैहिस्सलाम)",
    "इमाम अली नक़ी (अलैहिस्सलाम)",
    "इमाम अली हादी (अलैहिस्सलाम)",
    "इस्माईल हरीफ़ा (रहमतुल्लाहि अलैह)",
    "सैयद अकील (रहमतुल्लाहि अलैह)",
    "सैयद हारून (रहमतुल्लाहि अलैह)",
    "सैयद हम्ज़ा (रहमतुल्लाहि अलैह)",
    "सैयद जाफ़र (रहमतुल्लाहि अलैह)",
    "सैयद ज़ैद (रहमतुल्लाहि अलैह)",
    "सैयद क़ासिम (रहमतुल्लाहि अलैह)",
    "सैयद इब्राहीम जाव्वादी (रहमतुल्लाहि अलैह)",
    "सैयद मुहम्मद शुजाई (रहमतुल्लाहि अलैह)",
    "सैयद मुहम्मद शाह मक्की (रहमतुल्लाहि अलैह)",
    "सैयद सदरुद्दीन शाह रिज़वी (रहमतुल्लाहि अलैह)",
    "सैयद ग़ुलाम शाह रिज़वी (रहमतुल्लाहि अलैह)",
    "सैयद मुहम्मद शाह रिज़वी (रहमतुल्लाहि अलैह)",
    "सैयद अली अहमद शाह रिज़वी (रहमतुल्लाहि अलैह)",
    "सैयद अहसन अहमद शाह रिज़वी (रहमतुल्लाहि अलैह)",
    "सैयद तौफ़ीक़ अहमद शाह रिज़वी (रहमतुल्लाहि अलैह)",
    "सैयद फ़राज़ रिज़वी — अल-मुबारक",
  ];

  List<String> get currentLineage {
    switch (selectedIndex) {
      case 1:
        return _lineageUrdu;
      case 2:
        return _lineageHindi;
      default:
        return _lineageEnglish;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Shajrah of Our Murshid"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                isSelected: List.generate(
                  _languages.length,
                  (index) => selectedIndex == index,
                ),
                onPressed: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                selectedColor: Colors.white,
                fillColor: const Color.fromARGB(255, 115, 117, 118),
                color: Colors.black,
                borderColor: Colors.transparent,
                constraints: const BoxConstraints(minHeight: 40, minWidth: 90),
                children:
                    _languages
                        .map(
                          (lang) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              lang,
                              style: const TextStyle(
                                fontFamily: 'AlviNastaleeq',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Light Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                const Text(
                  "‎بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيم",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'UthmanArabic',
                    fontSize: 22,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "اللَّهُمَّ صَلِّ عَلَىٰ مُحَمَّدٍ وَعَلَىٰ آلِ مُحَمَّدٍ وَسَلِّمْ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'UthmanArabic',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),

                // Dynamic Lineage in English
                for (var name in currentLineage) ...[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'UthmanArabic',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 22,
                    color: Colors.brown,
                  ),
                  const SizedBox(height: 16),
                ],

                // Closing Du'a in English for main content
                const SizedBox(height: 24),
                const Text(
                  "Ala Allah ta’ala dhurriyatahum da’iman wa barakatihim wa anfusahum al-qudusiya biharama min la nabi ba’dahu bihurmat sirr surah Al-Fatiha.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 32),

                // Urdo Panel for Arabic Text
                if (selectedIndex == 1) ...[
                  // Example: Language selected as Urdu
                  const Text(
                    "على الله تعالى ذريتهم دائماً وبركاتهم وأنفسهم القدسية بحرمة من لا نبي بعده بحرمة سر سورة الفاتحة.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'UthmanArabic',
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
