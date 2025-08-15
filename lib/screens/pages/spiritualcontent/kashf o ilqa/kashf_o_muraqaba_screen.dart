import 'package:flutter/material.dart';

class KashfMuraqabaScreen extends StatefulWidget {
  const KashfMuraqabaScreen({super.key});

  @override
  _KashfMuraqabaScreenState createState() => _KashfMuraqabaScreenState();
}

class _KashfMuraqabaScreenState extends State<KashfMuraqabaScreen> {
  String selectedLang = 'english';

  void showFullImage(String imageUrl) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: InteractiveViewer(child: Image.network(imageUrl)),
            ),
          ),
    );
  }

  Widget buildImageGrid(List<String> urls) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: urls.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final url = urls[index];
          return GestureDetector(
            onTap: () => showFullImage(url),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(url, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  Widget getContentWidget() {
    switch (selectedLang) {
      case 'urdu':
        return urduContent();
      case 'roman':
        return romanContent();
      case 'english':
      default:
        return englishContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg2.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          appBar: AppBar(
            title: const Text('Kashf o Muraqaba'),
            backgroundColor: Colors.teal.withOpacity(0.2),
          ),
          body: Column(
            children: [
              Container(
                color: Colors.white.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    langTab("urdu", "اردو"),
                    langTab("english", "English"),
                    langTab("roman", "Roman"),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white30),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: getContentWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget langTab(String langKey, String label) {
    final isSelected = selectedLang == langKey;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLang = langKey;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              decoration:
                  isSelected ? TextDecoration.overline : TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget englishContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text("📿 Murāqaba Guide (Spiritual Meditation Practice)"),
        text("\n🛁 Preparation"),
        text("- Wudu (Ablution): Stay in a state of purity."),
        text("- Tahajjud or Nafil: At least 2 rakats; ideally, 12 rakats."),
        text("- Durood/Salawat: Recite any salawat at least 11 times."),
        text(
          "- Remember Mursid: Recite Ya Khawja MOhammed Shah Makki Al Madad / Your Murshid Name at least 7 times.",
        ),

        text("\n🧠 Spiritual Intention (Niyyah)"),
        text("- Sit for the pleasure of Allah ﷻ."),
        text("- Seek nearness to Allah through your Sheikh."),

        text("\n🧎‍♂️ Sitting Posture"),
        buildImageGrid([
          "https://i.ibb.co/r2trYk9D/muraqaba-sitting-2.jpg",
          "https://i.ibb.co/3536PdGd/muraqaba-post.png",
          "https://i.ibb.co/wrJ1qhqN/download-1.jpg",
          "https://i.ibb.co/j9WPc14B/jihad-akbar-earthquake-inner-battle-750x422.jpg",
        ]),
        text("- Sit in calm, ideally facing Qiblah."),
        text("- Cross-legged or in tashahhud."),
        text("- Hands on thighs/knees."),

        text("\n🌟 Tasavvur-e-Sheikh"),
        buildImageGrid([
          "https://i.ibb.co/3wLg7kB/murshid-h2h.jpg",
          "https://i.ibb.co/b5V9LZfp/murshid-heartenlight.jpg",
          "https://i.ibb.co/zTvjLf8H/download.jpg",
        ]),
        text("- Visualize your Sheikh sitting in front."),
        text("- Light (Noor) flows from Sheikh’s chest to yours."),
        text("- Light from his forehead to yours."),

        text("\n✨ Breathing Technique:"),
        text("- Inhale: 'ALLAH' – Light rising to head."),
        text("- Exhale: 'HU' – Light descending into heart."),

        text("\n🚪 Entering Murāqaba:"),
        text("- Let go of thoughts."),
        text("- Focus: Breath, Sheikh, silence."),

        text("\n🌀 Realms Journey:"),
        buildImageGrid([
          "https://i.ibb.co/X1Bq9sC/roohparwaz.jpg",
          "https://i.ibb.co/0VG3HzLt/spiritual.jpg",
        ]),

        text("- Aalam-e-Lahoot: Unity with Divine."),
        text("- Aalam-e-Mithal: Imagery, visions."),
        buildImageGrid(["https://i.ibb.co/YF8stzwG/universe.jpg"]),
        text("- Aalam-e-Malakut: Angels, light."),
        text("- Aalam-e-Jabarut: Divine powers."),
        text("- Aalam-e-Lahoot: Unity with Divine."),

        text("\n🕜 Duration: Start 10–15 mins; increase to 30–60."),

        text("\n📝 Afterward:"),
        text("- Slowly Open your eyes."),
        text("- Reflect, write down experiences."),

        text("\n🌺 Close Session:"),
        text("- Durood again."),
        text("- Say: 'YA Khawaja Muhammad Shah Makki Madad' (7 times)."),
        text("- Make heartfelt du‘a to Allah ﷻ."),
      ],
    );
  }

  Widget romanContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text("📿 Muraqaba Guide (Roohani Riyazat)"),
        text("\n🛁 Tayari"),
        text("- Wuzu mein rehna zaroori hai."),
        text("- Tahajjud ya kam az kam 2 nafil (behtar 12 rakats)."),
        text("- Durood Shareef kam az kam 11 martaba."),
        text(
          "- Murshid ka tasavvur: 'Ya Khawja Muhammad Shah Makki Al Madad' ya apne Murshid ka naam 7 martaba.",
        ),

        text("\n🧠 Niyyat"),
        text("- Allah ki raza ke liye baithna."),
        text("- Murshid ke zariye Allah ka qurb hasil karna."),

        text("\n🧎‍♂️ Baithne ka Tareeqa"),
        buildImageGrid([
          "https://i.ibb.co/r2trYk9D/muraqaba-sitting-2.jpg",
          "https://i.ibb.co/3536PdGd/muraqaba-post.png",
          "https://i.ibb.co/wrJ1qhqN/download-1.jpg",
          "https://i.ibb.co/j9WPc14B/jihad-akbar-earthquake-inner-battle-750x422.jpg",
        ]),
        text("- Sukoon se Qibla rukh ho kar baithain."),
        text("- Tashahhud ya murgha tariqa."),
        text("- Haath raanon par rakhain."),

        text("\n🌟 Tasavvur-e-Sheikh"),
        buildImageGrid([
          "https://i.ibb.co/3wLg7kB/murshid-h2h.jpg",
          "https://i.ibb.co/b5V9LZfp/murshid-heartenlight.jpg",
          "https://i.ibb.co/zTvjLf8H/download.jpg",
        ]),
        text("- Apne Sheikh ko samne tasavvur karain."),
        text("- Noor Sheikh ke seene se aap ke seene mein aata hai."),
        text("- Noor Sheikh ke mathe se aap ke mathe mein aata hai."),

        text("\n✨ Saans ka Tareeqa"),
        text("- Saans lete waqt: 'ALLAH' – noor sir tak."),
        text("- Saans chorte waqt: 'HU' – noor dil mein."),

        text("\n🚪 Muraqaba mein Dakhal"),
        text("- Fikr se nijaat."),
        text("- Bas saans, Sheikh aur khamoshi par tawajju."),

        text("\n🌀 Aalam ka Safar"),
        buildImageGrid([
          "https://i.ibb.co/X1Bq9sC/roohparwaz.jpg",
          "https://i.ibb.co/0VG3HzLt/spiritual.jpg",
        ]),
        text("- Aalam-e-Lahoot: Allah se wusool."),
        text("- Aalam-e-Mithal: Tasaveer aur manazir."),
        buildImageGrid(["https://i.ibb.co/YF8stzwG/universe.jpg"]),
        text("- Aalam-e-Malakut: Farishte aur noor."),
        text("- Aalam-e-Jabarut: Rabbani quwatein."),

        text("\n🕜 Waqt"),
        text(
          "- 10-15 minute se shuru karain; badhakar 30–60 minute tak le jayein.",
        ),

        text("\n📝 Baad mein"),
        text("- Aankhain ahista kholain."),
        text("- Jo kuch mehsoos kiya likh lain."),

        text("\n🌺 Khatma"),
        text("- Phir se durood Shareef."),
        text("- 7 martaba: 'YA Khawaja Muhammad Shah Makki Madad'."),
        text("- Allah se dil se dua karain."),
      ],
    );
  }

  Widget urduContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text("📿 مراقبہ گائیڈ (روحانی ریاضت)"),
        text("\n🛁 تیاری"),
        text("- وضو میں رہنا ضروری ہے۔"),
        text("- تہجد یا کم از کم ۲ نفل (بہتر ۱۲ رکعتیں)"),
        text("- درود شریف کم از کم ۱۱ مرتبہ۔"),
        text(
          "- مرشد کا تصور: 'یا خواجہ محمد شاہ مکی مدد' یا اپنے مرشد کا نام ۷ مرتبہ۔",
        ),

        text("\n🧠 نیت"),
        text("- اللہ کی رضا کے لیے بیٹھنا۔"),
        text("- مرشد کے ذریعے اللہ کا قرب حاصل کرنا۔"),

        text("\n🧎‍♂️ بیٹھنے کا طریقہ"),
        buildImageGrid([
          "https://i.ibb.co/r2trYk9D/muraqaba-sitting-2.jpg",
          "https://i.ibb.co/3536PdGd/muraqaba-post.png",
          "https://i.ibb.co/wrJ1qhqN/download-1.jpg",
          "https://i.ibb.co/j9WPc14B/jihad-akbar-earthquake-inner-battle-750x422.jpg",
        ]),
        text("- سکون سے، قبلہ رخ بیٹھیں۔"),
        text("- تشہد یا مرغہ طرز پر۔"),
        text("- ہاتھ رانوں پر رکھیں۔"),

        text("\n🌟 تصورِ شیخ"),
        buildImageGrid([
          "https://i.ibb.co/3wLg7kB/murshid-h2h.jpg",
          "https://i.ibb.co/b5V9LZfp/murshid-heartenlight.jpg",
          "https://i.ibb.co/zTvjLf8H/download.jpg",
        ]),
        text("- اپنے شیخ کو سامنے تصور کریں۔"),
        text("- نور شیخ کے سینے سے آپ کے سینے میں آتا ہے۔"),
        text("- نور شیخ کے ماتھے سے آپ کے ماتھے میں۔"),

        text("\n✨ سانس کی مشق"),
        text("- سانس لیتے وقت: 'اللہ' – نور سر تک۔"),
        text("- سانس چھوڑتے وقت: 'ہُو' – نور دل میں۔"),

        text("\n🚪 مراقبہ میں داخلہ"),
        text("- خیالات سے نجات۔"),
        text("- توجہ: سانس، شیخ، خاموشی۔"),

        text("\n🌀 عوالم کا سفر"),
        buildImageGrid([
          "https://i.ibb.co/X1Bq9sC/roohparwaz.jpg",
          "https://i.ibb.co/0VG3HzLt/spiritual.jpg",
        ]),
        text("- عالمِ لاہوت: اللہ سے وصال۔"),
        text("- عالمِ مثال: تصویریں، مناظر۔"),
        buildImageGrid(["https://i.ibb.co/YF8stzwG/universe.jpg"]),
        text("- عالمِ ملکوت: فرشتے، نورانی مخلوق۔"),
        text("- عالمِ جبروت: ربانی طاقتیں۔"),

        text("\n🕜 مدت"),
        text("- ابتدا میں 10-15 منٹ؛ پھر بڑھا کر 30–60 منٹ۔"),

        text("\n📝 بعد ازاں"),
        text("- آہستہ سے آنکھیں کھولیں۔"),
        text("- مشاہدات کو تحریر کریں۔"),

        text("\n🌺 اختتام"),
        text("- درود پاک دوبارہ پڑھیں۔"),
        text("- ۷ بار: 'یا خواجہ محمد شاہ مکی مدد'۔"),
        text("- دل سے دعا کریں۔"),
      ],
    );
  }

  Widget text(String data) => Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Text(
      data,
      style: const TextStyle(color: Colors.black87, fontSize: 16, height: 1.5),
      textAlign: TextAlign.justify,
    ),
  );
}
