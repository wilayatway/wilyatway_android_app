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
    "Ismail Harifa (رضي الله عنه)",
    "Syed Aqeel (رضي الله عنه)",
    "Syed Haroon (رضي الله عنه)",
    "Syed Hamza (رضي الله عنه)",
    "Syed Jafar (رضي الله عنه)",
    "Syed Zaid (رضي الله عنه)",
    "Syed Qasim (رضي الله عنه)",
    "Syed Ibrahim Jawwadi (رضي الله عنه)",
    "Syed Muhammad Shuja’i (رضي الله عنه)",
    "Syed Muhammad Shah Makki (رضي الله عنه)",
    "Syed Sadr-ud-Deen Shah Rizvi (رضي الله عنه)",
    "Syed Ghulam Shah Rizvi (رضي الله عنه)",
    "Syed Muhammad Shah Rizvi (رضي الله عنه)",
    "Syed Ali Ahmad Shah Rizvi (رضي الله عنه)",
    "Syed Ahsan Ahmad Shah Rizvi (رضي الله عنه)",
    "Syed Tawfiq Ahmad Shah Rizvi (رضي الله عنه)",
    "Syed Yasir Raza (رضي الله عنه)",
    "Syed Saif Raza (رضي الله عنه)",
    "Syed Ali Ahmad Rizvi (رضي الله عنه)",
    "Syed Faraz Rizvi — Al‑Mubārak",
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
    "اسماعیل حریفا (رضی اللہ عنہ)",
    "سید عقیل (رضی اللہ عنہ)",
    "سید ہارون (رضی اللہ عنہ)",
    "سید حمزہ (رضی اللہ عنہ)",
    "سید جعفر (رضی اللہ عنہ)",
    "سید زید (رضی اللہ عنہ)",
    "سید قاسم (رضی اللہ عنہ)",
    "سید ابراہیم جوادی (رضی اللہ عنہ)",
    "سید محمد شجاعی (رضی اللہ عنہ)",
    "سید محمد شاہ مکی (رضی اللہ عنہ)",
    "سید صدرالدین شاہ رضوی (رضی اللہ عنہ)",
    "سید غلام شاہ رضوی (رضی اللہ عنہ)",
    "سید محمد شاہ رضوی (رضی اللہ عنہ)",
    "سید علی احمد شاہ رضوی (رضی اللہ عنہ)",
    "سید احسن احمد شاہ رضوی (رضی اللہ عنہ)",
    "سید توفیق احمد شاہ رضوی (رضی اللہ عنہ)",
    "سید یاسر رضا (رضی اللہ عنہ)",
    "سید سیف رضا (رضی اللہ عنہ)",
    "سید علی احمد رضوی (رضی اللہ عنہ)",
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
    "इस्माईल हरीफ़ा (रज़ियल्लाहु अन्हु)",
    "सैयद अकील (रज़ियल्लाहु अन्हु)",
    "सैयद हारून (रज़ियल्लाहु अन्हु)",
    "सैयद हम्ज़ा (रज़ियल्लाहु अन्हु)",
    "सैयद जाफ़र (रज़ियल्लाहु अन्हु)",
    "सैयद ज़ैद (रज़ियल्लाहु अन्हु)",
    "सैयद क़ासिम (रज़ियल्लाहु अन्हु)",
    "सैयद इब्राहीम जाव्वादी (रज़ियल्लाहु अन्हु)",
    "सैयद मुहम्मद शुजाई (रज़ियल्लाहु अन्हु)",
    "सैयद मुहम्मद शाह मक्की (रज़ियल्लाहु अन्हु)",
    "सैयद सदरुद्दीन शाह रिज़वी (रज़ियल्लाहु अन्हु)",
    "सैयद ग़ुलाम शाह रिज़वी (रज़ियल्लाहु अन्हु)",
    "सैयद मुहम्मद शाह रिज़वी (रज़ियल्लाहु अन्हु)",
    "सैयद अली अहमद शाह रिज़वी (रज़ियल्लाहु अन्हु)",
    "सैयद अहसन अहमद शाह रिज़वी (रज़ियल्लाहु अन्हु)",
    "सैयद तौफ़ीक़ अहमद शाह रिज़वी (रज़ियल्लाहु अन्हु)",
    "सैयद यासिर रज़ा (रज़ियल्लाहु अन्हु)",
    "सैयद सैफ रज़ा (रज़ियल्लाहु अन्हु)",
    "सैयद अली अहमद रिज़वी (रज़ियल्लाहु अन्हु)",
    "सैयद फ़राज़ रिज़वी — अल-मुबा​रक",
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
