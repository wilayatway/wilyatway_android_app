import 'package:flutter/material.dart';
import 'package:wilayat_way_apk/screens/pages/contact_us_screen.dart'
    show ContactUsScreen;

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  String selectedLanguage = 'Urdu';
  final List<String> languages = ['Urdu', 'English', 'اردو', 'हिंदी'];

  final Map<String, String> aboutUsContent = {
    'Urdu': '''Allah Tak Ka Safar... ✨❤️
Wilayat Way ka mission sirf maloomat dena nahi, balkay roohani tabdeeli lana hai.

Hum dilon ko Islam ke asal rooh se dobara jorna chahte hain — sirf zahiri ibaadat nahi, balkay roohani noor aur Allah ke ishq ke zariye. Aaj ke daur mein roohani taleem ya to gum ho chuki hai ya logon ne usay bhula diya hai. Hum chahte hain ke Tasawwuf aur Maarifat ki taleem ko dobara zinda kiya jaye — ye woh batini raasta hai jo Allah ki qurbat tak le jata hai. 🌙🕊️

Hum deen ki modern tahrifaat ko follow nahi karte — hum un buzurgon ke raaste par hain jo asal deen par qayam rahe: Sahaba Kiram, Auliya Allah, Sufiya-e-Kiram, aur wo tamam maqbool hastiyaan jinhein Allah ne apni Wilayat se nawaza.

Hamara maqsad na shohrat hai na followers — hamara sirf ek hi maqsad hai: Allah.
Zikr, fikr aur roohani taleemat ke zariye, hum chahtay hain ke talib-e-haq apni asal pehchaan ko samjhein aur us raaste par chalein jo unhein Allah ki huzoori tak le jaye. 🌸🕌💖

Humse sirf seekhne ke liye nahi — balkay jagne ke liye judaiye.
Aao mil kar chalein Wilayat Way par — Mohabbat ka raasta, Haq ka raasta, Allah tak ka raasta... ✨''',
    'English': '''
      Wilayat Way is a spiritual journey that helps you walk the path of truth.

      Way to the Divine... ✨❤️  
      At Wilayat Way, our mission is not just to inform — it's to transform.

      We aim to reconnect hearts with the true essence of Islam — not just the outward rituals, but the inner light of spirituality and divine love. In a time when spiritual knowledge is hidden or forgotten, we strive to revive the teachings of Tasawwuf and Maarifat — the inner path that leads to the closeness of Allah. 🌙🕊️

      We don't follow modern distortions of religion — we align ourselves with the pure path of the Awliya, the Sahaba Kiram, the noble Sufis, and all those beloved souls to whom Allah has granted His Wilayat (friendship).

      Our goal is not fame or following — our only goal is Allah.  
      Through Zikr (remembrance), reflection, and sacred teachings, we wish to guide seekers towards their true spiritual identity, helping them rediscover the path that leads to the Divine Presence. 🌸🕌💖

      Join us, not just to learn — but to awaken.  
      Let's walk together on the Wilayat Way — the Path of Love, the Path of Truth, the Path to Allah... ✨
      ''',
    'اردو': '''
      ولایت وے ایک روحانی سفر ہے جو آپ کو راہِ حق پر چلنے میں مدد دیتا ہے۔

      راہِ الی اللہ... ✨❤️  
      ہمارا مشن صرف معلومات دینا نہیں، بلکہ دلوں کو بدلنا ہے۔

      ہم دلوں کو اسلام کی اصل روح سے جوڑنا چاہتے ہیں — صرف ظاہری عبادات نہیں، بلکہ باطنی روشنی، روحانیت اور اللہ کی محبت سے۔ آج کے دور میں جب روحانی علم چھپ چکا ہے یا بھلا دیا گیا ہے، ہم تصوف اور معرفت کی تعلیمات کو زندہ کرنا چاہتے ہیں — وہ باطنی راستہ جو انسان کو اللہ کے قرب تک لے جاتا ہے۔ 🌙🕊️

      ہم دین کی جدید شکلوں کے پیروکار نہیں — ہم ان پاک ہستیوں کے راستے پر ہیں جو اللہ کے ولی ہیں: صحابہ کرام، اولیاء اللہ، صوفیائے کرام، اور وہ تمام محبوب بندے جنہیں اللہ نے اپنی ولایت سے نوازا۔

      ہماری طلب نہ شہرت ہے، نہ پیروی — ہماری واحد طلب اللہ ہے۔  
      ذکر، تفکر اور مقدس تعلیمات کے ذریعے ہم سچے طالبین کو ان کی روحانی پہچان کی طرف رہنمائی دینا چاہتے ہیں، تاکہ وہ اللہ کی قربت کا راستہ دوبارہ پا سکیں۔ 🌸🕌💖

      ہمارے ساتھ صرف سیکھنے کے لیے نہیں — بیدار ہونے کے لیے جڑیں۔  
      آئیے ولایت وے پر ساتھ چلیں — محبت کا راستہ، سچائی کا راستہ، اللہ کی طرف جانے والا راستہ... ✨
      ''',
    'हिंदी': ''' अल्लाह की ओर एक मार्ग... ✨❤️
Wilayat Way में हमारा उद्देश्य सिर्फ जानकारी देना नहीं, बल्कि आत्मा का परिवर्तन करना है।

हम दिलों को इस्लाम के सच्चे सार से फिर से जोड़ना चाहते हैं — केवल बाहरी इबादतों से नहीं, बल्कि रूहानियत और ईश्वरीय प्रेम की आंतरिक रौशनी से। आज के युग में यह रूहानी ज्ञान या तो छिपा दिया गया है या भुला दिया गया है, और हमारा प्रयास है कि तसव्वुफ़ और मारिफ़त की शिक्षाओं को पुनर्जीवित किया जाए — वह आंतरिक मार्ग जो अल्लाह की नज़दीकी तक ले जाता है। 🌙🕊️

हम किसी आधुनिक विकृति का अनुसरण नहीं करते — हम केवल औलिया अल्लाह, सहाबा किराम, सम्मानित सूफी संतों और उन तमाम प्रिय आत्माओं के रास्ते पर चलते हैं जिन्हें अल्लाह ने अपनी वलायत से नवाज़ा है।

हमारा लक्ष्य न तो प्रसिद्धि है, न ही अनुयायी — हमारा एकमात्र लक्ष्य है अल्लाह।
ज़िक्र (स्मरण), आत्म-चिंतन और पवित्र शिक्षाओं के माध्यम से हम साधकों को उनकी आत्मिक पहचान की ओर मार्गदर्शित करना चाहते हैं, ताकि वे उस मार्ग को पुनः खोज सकें जो उन्हें ईश्वरीय उपस्थिति की ओर ले जाता है। 🌸🕌💖

हमसे जुड़ें — केवल सीखने के लिए नहीं, बल्कि जागने के लिए।
आइए, मिलकर चलें Wilayat Way पर — प्रेम का रास्ता, सत्य का रास्ता, अल्लाह तक पहुंचने का रास्ता... ✨''',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color.fromARGB(168, 57, 52, 52)),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Fixed Header Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.7),
                            offset: const Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // "Change Language" Label
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, bottom: 6),
                        child: Text(
                          '🌐 Change Language',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Dropdown Style Container
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedLanguage,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 28,
                          isExpanded: true,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          dropdownColor: Colors.white,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLanguage = newValue!;
                            });
                          },
                          items:
                              languages.map<DropdownMenuItem<String>>((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Scrollable Content Section
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      // About Us Content
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          aboutUsContent[selectedLanguage] ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            fontFamily:
                                selectedLanguage == 'Urdu' ||
                                        selectedLanguage == 'Hindi'
                                    ? 'NotoNastaliqUrdu' // Use appropriate Urdu/Hindi font
                                    : null, // Use default for others
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Fixed Footer with Contact Us
              Container(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ContactUsScreen()),
                    );
                  },
                  child: const Text(
                    '📞 Contact Us',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 7, 32, 53),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
