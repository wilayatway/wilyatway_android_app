import 'package:flutter/material.dart';
import 'package:wilayat_way_apk/screens/pages/experiences/maamlaat_list_screen.dart'
    show MaamlaatListScreen;
import 'package:wilayat_way_apk/screens/pages/shajra_nasab_screen.dart'
    show ShajraNasabScreen;
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/asma%20ul%20husna/asma_ul_husna_screen.dart';
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/asma%20ul%20husna/asma_ul_nabi.dart';
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/kashf%20o%20ilqa/kashf_o_muraqaba_screen.dart';
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/murshid%20gallery/murshid-gallery-screen.dart';
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/spiritual_dream/spiritual_dreams.dart';
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/spiritual_glossory/spiritual_glossory.dart';
import 'package:wilayat_way_apk/screens/pages/task/wazifa/task_wazifa_screen.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class SpiritualContentScreen extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> spiritualSections = {
    // 'Last Used': [
    // ],
    'Spiritual Knowledge & Insights': [
      {'title': 'Ilm-e-Marifat', 'icon': Icons.self_improvement},
      {'title': 'Ilm-e-Tareeqat', 'icon': Icons.travel_explore},
      {'title': 'Ilm-ul-Wajood', 'icon': Icons.travel_explore},
      {'title': 'Irfani Tafseer', 'icon': Icons.menu_book},
      {'title': 'Secrets of Wilayah', 'icon': Icons.lock_open},
      {'title': 'Haalaat-e-Aarifeen', 'icon': Icons.people},
    ],
    'Practical Spirituality': [
      {'title': 'Spiritual Posts', 'icon': Icons.post_add},
      {'title': 'Muraqaba', 'icon': Icons.spa},
      {'title': 'Tazkiyah', 'icon': Icons.filter_vintage},
      {'title': 'Istikhara Guide', 'icon': Icons.help},
      {'title': 'Ruhani Ilaaj', 'icon': Icons.healing}
    ],
    'For Murideen' : [
      {'title': 'Tasks/Wazifa', 'icon': Icons.repeat},
      {'title': 'Spiritual-Experiance/Maamlat', 'icon': Icons.post_add},
    ],
    'End Times & Imam Mahdi (a.s.)': [
      {'title': 'Future Prediction', 'icon': FlutterIslamicIcons.islam},
      {
        'title': 'Army of Imam Mehdi (a.s.)',
        'icon': FlutterIslamicIcons.solidCommunity,
      },
      {'title': 'Wilayat Timeline', 'icon': Icons.timeline},
    ],
    'Murshid': [
      {'title': 'Tarruf e Murshid', 'icon': Icons.info},
      {'title': 'Malfoozat-e-Murshid', 'icon': Icons.format_quote},
      {'title': 'Murshid\'s Teachings', 'icon': Icons.book},
      {'title': 'Murshid Gallery', 'icon': Icons.photo_library},
      {'title': 'Shajra Pak', 'icon': Icons.account_tree},
    ],
        'Science and Tasawwuf': [
      {'title': 'Affirmations', 'icon': FlutterIslamicIcons.islam},
    ],
    'Extras & Resources': [
      {'title': 'Asma-ul-Husna', 'icon': FlutterIslamicIcons.allah},
      {'title': 'Asma-e-Nabi', 'icon': FlutterIslamicIcons.mohammad},
      {
        'title': 'Kashf o Muraqaba',
        'icon': FlutterIslamicIcons.solidPrayingPerson,
      },
      {'title': 'Ilham o Ilqa', 'icon': FlutterIslamicIcons.prayingPerson},

      {'title': 'Spiritual Dreams', 'icon': Icons.nights_stay},

      {'title': 'Irfani Books', 'icon': Icons.book},
      {'title': 'Spiritual Glossary', 'icon': Icons.menu_book_outlined},
    ],
  };

  SpiritualContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Spiritual Content'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
          ),
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(
                  top: kToolbarHeight + 24,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, sectionIdx) {
                      final section = spiritualSections.entries.elementAt(sectionIdx);
                      return _SectionWidget(
                        title: section.key,
                        items: section.value,
                        onTap: (item) => navigateToScreen(context, item['title']),
                      );
                    },
                    childCount: spiritualSections.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void navigateToScreen(BuildContext context, String title) {
    Widget screen;
    switch (title) {
      case 'Spiritual-Experiance/Maamlat':
        screen = MaamlaatListScreen();
        break;
      case 'Tasks/Wazifa':
        screen = TaskWazifaScreen();
        break;
      case 'Shajra':
        screen = ShajraNasabScreen();
        break;
      case 'Asma-ul-Husna':
        screen = AsmaUlHusnaScreen();
        break;
      case 'Asma-e-Nabi':
        screen = AsmaUlNabiScreen();
        break;
      case 'Kashf o Muraqaba':
        screen = KashfMuraqabaScreen();
        break;
      case 'Murshid Gallery':
        screen = MurshidGalleryPage();
        break;
      case 'Spiritual Glossary':
        screen = SpiritualGlossaryPage();
        break;
      case 'Spiritual Dreams':
        screen = SpiritualDreamsScreen();
        break;
      default:
        screen = PlaceholderScreen(title: title);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}

class _SectionWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final void Function(Map<String, dynamic>) onTap;
  const _SectionWidget({required this.title, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            color: Color.fromARGB(255, 246, 232, 211),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = (constraints.maxWidth / 120).floor().clamp(3, 6); // Minimum 3 in a row
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return _GridItem(
                  icon: item['icon'],
                  title: item['title'],
                  onTap: () => onTap(item),
                );
              },
            );
          },
        ),
        const SizedBox(height: 40),
        Divider(color: Colors.white24, thickness: 1),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _GridItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _GridItem({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 60,
            child: Icon(
              icon,
              size: 50,
              color: const Color.fromARGB(255, 33, 33, 33),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder screen (for non-implemented ones)
class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title screen is under development.',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
