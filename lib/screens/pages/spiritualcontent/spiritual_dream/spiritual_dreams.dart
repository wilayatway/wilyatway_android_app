import 'package:flutter/material.dart';

class SpiritualDreamsScreen extends StatefulWidget {
  const SpiritualDreamsScreen({super.key});

  @override
  State<SpiritualDreamsScreen> createState() => _SpiritualDreamsScreenState();
}

class _SpiritualDreamsScreenState extends State<SpiritualDreamsScreen> {
  int _selectedLang = 0; // 0: Roman Urdu, 1: English, 2: Urdu

  final List<Map<String, Map<String, String>>> dreamTypesMulti = [
    {
      'title': {
        'roman': 'Rahnuma Khawab',
        'english': 'Guidance Dreams',
        'urdu': 'رہنما خواب'
      },
      'description': {
        'roman': 'Aise khawab jo zindagi ke sawalon ka jawab ya rehnumai faraham karte hain.',
        'english': 'Dreams that provide direction or answers to life questions.',
        'urdu': 'ایسے خواب جو زندگی کے سوالوں کا جواب یا رہنمائی فراہم کرتے ہیں۔'
      }
    },
    {
      'title': {
        'roman': 'Tanzeer Khawab',
        'english': 'Warning Dreams',
        'urdu': 'تنذیر خواب'
      },
      'description': {
        'roman': 'Aise khawab jo kisi khatre ya ghalati ki taraf mutwajjeh karte hain.',
        'english': 'Dreams that alert you to potential dangers or mistakes.',
        'urdu': 'ایسے خواب جو کسی خطرے یا غلطی کی طرف متوجہ کرتے ہیں۔'
      }
    },
    {
      'title': {
        'roman': 'Honsla Afzai Khawab',
        'english': 'Inspirational Dreams',
        'urdu': 'حوصلہ افزائی خواب'
      },
      'description': {
        'roman': 'Aise khawab jo rooh ko buland karen aur achay amal ki taraf raghbat dilayen.',
        'english': 'Dreams that uplift your spirit and encourage positive action.',
        'urdu': 'ایسے خواب جو روح کو بلند کریں اور اچھے عمل کی طرف رغبت دلائیں۔'
      }
    },
    {
      'title': {
        'roman': 'Paighambari Khawab',
        'english': 'Prophetic Dreams',
        'urdu': 'پیغمبری خواب'
      },
      'description': {
        'roman': 'Aise khawab jo mustaqbil ke waqiat ya roohani ahwaal ki khabar detay hain.',
        'english': 'Dreams that foretell future events or spiritual happenings.',
        'urdu': 'ایسے خواب جو مستقبل کے واقعات یا روحانی احوال کی خبر دیتے ہیں۔'
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    String langKey = _selectedLang == 0 ? 'roman' : _selectedLang == 1 ? 'english' : 'urdu';
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Spiritual Dreams'),
        backgroundColor: Colors.deepPurple.shade700.withOpacity(0.15),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, kToolbarHeight + 8, 0, 0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Language toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LangTextButton(
                        label: 'Urdu',
                        selected: _selectedLang == 0,
                        onTap: () => setState(() => _selectedLang = 0),
                      ),
                      const SizedBox(width: 18),
                      _LangTextButton(
                        label: 'English',
                        selected: _selectedLang == 1,
                        onTap: () => setState(() => _selectedLang = 1),
                      ),
                      const SizedBox(width: 18),
                      _LangTextButton(
                        label: 'اردو',
                        selected: _selectedLang == 2,
                        onTap: () => setState(() => _selectedLang = 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    langKey == 'roman'
                        ? 'Roohani Khawab'
                        : langKey == 'english'
                            ? 'Spiritual Dreams'
                            : 'روحانی خواب',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textDirection: langKey == 'urdu' ? TextDirection.rtl : TextDirection.ltr,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      langKey == 'roman'
                          ? 'Roohani khawab mukhtalif riwayaat mein ahmiyat rakhte hain. Yeh khawab hidayat, ilham ya paigham la sakte hain. Sufi riwayat mein, khawab roohani idraak aur niji taraqqi ka zariya ho sakte hain. Agar aap ne roohani khawab dekha hai, us par ghour karein aur kisi moatabar rehnuma se mashwara lein.'
                          : langKey == 'english'
                              ? 'Spiritual dreams are considered significant in many traditions. They may contain guidance, inspiration, or messages from the Divine. In Sufi tradition, dreams can be a means of spiritual insight and personal growth. If you have experienced a spiritual dream, reflect on its meaning and seek guidance from a knowledgeable mentor.'
                              : 'روحانی خواب مختلف روایات میں اہمیت رکھتے ہیں۔ یہ خواب ہدایت، الہام یا پیغام لا سکتے ہیں۔ صوفی روایت میں، خواب روحانی ادراک اور ذاتی ترقی کا ذریعہ ہو سکتے ہیں۔ اگر آپ نے روحانی خواب دیکھا ہے، اس پر غور کریں اور کسی معتبر رہنما سے مشورہ لیں۔',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textDirection: langKey == 'urdu' ? TextDirection.rtl : TextDirection.ltr,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    langKey == 'roman'
                        ? 'Roohani Khawabon Ki Aqsam:'
                        : langKey == 'english'
                            ? 'Common Types of Spiritual Dreams:'
                            : 'روحانی خوابوں کی اقسام:',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textDirection: langKey == 'urdu' ? TextDirection.rtl : TextDirection.ltr,
                  ),
                  const SizedBox(height: 12),
                  ...dreamTypesMulti.map((dream) => _DreamTypeCard(
                        title: dream['title']![langKey]!,
                        description: dream['description']![langKey]!,
                        isUrdu: langKey == 'urdu',
                      )),
                  const SizedBox(height: 32),
                  Text(
                    langKey == 'roman'
                        ? 'Apne khawabon par ghour karein aur unhein likh lein. Aksar un ka matlab waqt ke sath wazeh hota hai.'
                        : langKey == 'english'
                            ? 'Reflect on your dreams and write them down. Sometimes, their meaning becomes clear over time.'
                            : 'اپنے خوابوں پر غور کریں اور انہیں لکھ لیں۔ اکثر ان کا مطلب وقت کے ساتھ واضح ہوتا ہے۔',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textDirection: langKey == 'urdu' ? TextDirection.rtl : TextDirection.ltr,
                  ),
                ],
              ),
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
            padding: const EdgeInsets.only(bottom: 2),
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

class _DreamTypeCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isUrdu;
  const _DreamTypeCard({required this.title, required this.description, this.isUrdu = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
            textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
            textDirection: isUrdu ? TextDirection.rtl : TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}
