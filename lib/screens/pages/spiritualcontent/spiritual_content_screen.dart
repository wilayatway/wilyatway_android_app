import 'package:flutter/material.dart';
import 'package:wilayat_way_apk/screens/pages/experiences/maamlaat_list_screen.dart'
    show MaamlaatListScreen;
import 'package:wilayat_way_apk/screens/pages/shajra_nasab_screen.dart'
    show ShajraNasabScreen;
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/asma%20ul%20husna/asma_ul_husna_screen.dart';
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/asma%20ul%20husna/asma_ul_nabi.dart';
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/kashf%20o%20ilqa/kashf_o_muraqaba_screen.dart';
import 'package:wilayat_way_apk/screens/pages/task/wazifa/task_wazifa_screen.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class SpiritualContentScreen extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> spiritualSections = {
    // 'Last Used': [
    // ],
    // 'Spiritual Knowledge & Insights': [
    //   {'title': 'Ilm-e-Marifat', 'icon': Icons.self_improvement},
    //   {'title': 'Irfani Tafseer', 'icon': Icons.menu_book},
    //   {'title': 'Malfoozat-e-Murshid', 'icon': Icons.format_quote},
    //   {'title': 'Ilm-ul-Wajood', 'icon': Icons.travel_explore},
    //   {'title': 'Secrets of Wilayah', 'icon': Icons.lock_open},
    //   {'title': 'Haalaat-e-Aarifeen', 'icon': Icons.people},
    // ],
    // 'Practical Spirituality': [
    //   {'title': 'Spiritual Posts', 'icon': Icons.post_add},
    //   {'title': 'Tasks', 'icon': Icons.repeat},
    //   {'title': 'Ruhani Ilaaj', 'icon': Icons.healing},
    //   {'title': 'Muraqaba', 'icon': Icons.spa},
    //   {'title': 'Tazkiyah', 'icon': Icons.filter_vintage},
    //   {'title': 'Istikhara Guide', 'icon': Icons.help},
    //   {'title': 'Spiritual-Experiance/Maamlat', 'icon': Icons.post_add},
    //   {'title': 'Tasks/Wazifa', 'icon': Icons.repeat},
    // ],
    'End Times & Imam Mahdi (a.s.)': [
      {'title': 'Future Prediction', 'icon': FlutterIslamicIcons.islam},
      {
        'title': 'Army of Imam Mehdi (a.s.)',
        'icon': FlutterIslamicIcons.solidCommunity,
      },
      {'title': 'Wilayat Timeline', 'icon': Icons.timeline},
    ],
    'Extras & Resources': [
      {'title': 'Asma-ul-Husna', 'icon': FlutterIslamicIcons.allah},
      {'title': 'Asma-e-Nabi', 'icon': FlutterIslamicIcons.mohammad},
      {
        'title': 'Kashf o Muraqaba',
        'icon': FlutterIslamicIcons.solidPrayingPerson,
      },
      {'title': 'Ilham o Ilqa', 'icon': FlutterIslamicIcons.prayingPerson},
      {'title': 'Shajra', 'icon': Icons.account_tree},
      {'title': 'Spiritual Dreams', 'icon': Icons.nights_stay},
      {'title': 'Murshid Gallery', 'icon': Icons.photo_library},
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
          Container(
            padding: const EdgeInsets.only(
              top: kToolbarHeight + 24,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    spiritualSections.entries.map((section) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            section.key,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(255, 246, 232, 211),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: section.value.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 0.7,
                                ),
                            itemBuilder: (context, index) {
                              final item = section.value[index];
                              return GestureDetector(
                                onTap: () {
                                  navigateToScreen(context, item['title']);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 60,
                                      // height: 60,
                                      // decoration: BoxDecoration(
                                      //   color: const Color.fromARGB(255, 243, 231, 231).withOpacity(0.8),
                                      //   borderRadius: BorderRadius.circular(16),
                                      //   boxShadow: [
                                      //     BoxShadow(
                                      //       color: Colors.black26,
                                      //       blurRadius: 4,
                                      //       offset: Offset(2, 2),
                                      //     ),
                                      //   ],
                                      // ),
                                      child: Icon(
                                        item['icon'],
                                        size: 50,
                                        color: const Color.fromARGB(
                                          255,
                                          33,
                                          33,
                                          33,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item['title'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 50),
                        ],
                      );
                    }).toList(),
              ),
            ),
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
      default:
        screen = PlaceholderScreen(title: title);
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
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
