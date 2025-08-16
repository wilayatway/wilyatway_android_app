import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wilayat_way_apk/screens/pages/about_us_screen.dart';
import 'package:wilayat_way_apk/screens/pages/contact_us_screen.dart';
import 'package:wilayat_way_apk/screens/pages/darood/durood_screen.dart';
import 'package:wilayat_way_apk/screens/pages/quran/quran_screen.dart';
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/spiritual_content_screen.dart';
import 'package:wilayat_way_apk/screens/pages/videos/video_list_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wilayat_way_apk/screens/popups/darood_popup.dart'
    show DaroodPopup;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Show Darood popup when the screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DaroodPopup.show(context);
    });

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 400;
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg2.png"),
                fit: BoxFit.cover, // Full screen cover
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 0),
                        child: Column(
                          children: [
                            SizedBox(height: isSmall ? 20 : 40),
                            // Header Section
                            Padding(
                              padding: EdgeInsets.only(top: isSmall ? 10 : 20.0),
                              child: Column(
                                children: [
                                  Text(
                                    '𝕎𝕚𝕝𝕒𝕪𝕒𝕥 𝕎𝕒𝕪',
                                    style: TextStyle(
                                      fontSize: isSmall ? 28 : 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  SizedBox(height: isSmall ? 6 : 10),
                                  Text(
                                    'Welcome to Raah e Haq',
                                    style: TextStyle(
                                      fontSize: isSmall ? 16 : 24,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black87,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: isSmall ? 20 : 40),

                            // Grid Section (smaller cards)
                            Padding(
                              padding: EdgeInsets.only(
                                top: isSmall ? 40 : 80, // Add more top padding to push cards down
                                left: isSmall ? 4 : 30,
                                right: isSmall ? 4 : 30,
                                bottom: isSmall ? 10 : 30,
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 400, // max width for 2 cards per row
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      int crossAxisCount = 2; // always 2 cards per row
                                      final List<_DashboardCardData> cards = [
                                        _DashboardCardData(
                                          label: 'Spiritual Content',
                                          image: 'assets/icons/mosque.png',
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => SpiritualContentScreen(),
                                              ),
                                            );
                                          },
                                        ),
                                        _DashboardCardData(
                                          label: 'Quran',
                                          image: 'assets/icons/quran.png',
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (_) => QuranScreen()),
                                            );
                                          },
                                        ),
                                        _DashboardCardData(
                                          label: 'Spiritual Videos',
                                          image: 'assets/icons/yt.png',
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => VideoListScreen(),
                                              ),
                                            );
                                          },
                                        ),
                                        _DashboardCardData(
                                          label: 'Darood o Dua',
                                          image: 'assets/icons/task.png',
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (_) => DuroodScreen()),
                                            );
                                          },
                                        ),
                                      ];
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: crossAxisCount,
                                          crossAxisSpacing: isSmall ? 8 : 16,
                                          mainAxisSpacing: isSmall ? 8 : 16,
                                          childAspectRatio: 1.1,
                                        ),
                                        itemCount: cards.length,
                                        itemBuilder: (context, index) {
                                          final card = cards[index];
                                          return _DashboardCard(
                                            label: card.label,
                                            imagePath: card.image,
                                            onTap: card.onTap,
                                            isSmall: true,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Footer Section (Social Icons, About Us, Contact Us)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.instagram,
                                color: Colors.pink,
                                size: 32,
                              ),
                              onPressed: () => _launchURL(
                                'https://www.instagram.com/wilayat_way/?igsh=MTd2NXBhejkyejIyag%3D%3D#',
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.facebook,
                                color: Color.fromARGB(255, 38, 3, 192),
                                size: 32,
                              ),
                              onPressed: () => _launchURL(
                                'https://facebook.com/share/1Fb9DdST1D',
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.youtube,
                                color: Colors.red,
                                size: 32,
                              ),
                              onPressed: () => _launchURL(
                                'https://www.youtube.com/channel/UCWpfRwsX7biV6fn4KhCWIOg',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AboutUsScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                '📖 About Us',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 7, 32, 53),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                '|',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 7, 32, 53),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ContactUsScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                '📞 Contact Us',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 7, 32, 53),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => AboutUsScreen()),
                            );
                          },
                          child: const Text(
                            'Donatations',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 7, 32, 53),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class _DashboardCard extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onTap;
  final bool isSmall;
  const _DashboardCard(
      {required this.label, required this.imagePath, required this.onTap, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white.withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset(
                  imagePath,
                  height: isSmall ? 40 : 60,
                  color: const Color.fromARGB(255, 190, 162, 0),// Glossy gold color
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontSize: isSmall ? 13 : 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add this class at the end of the file:
class _DashboardCardData {
  final String label;
  final String image;
  final VoidCallback onTap;
  _DashboardCardData({required this.label, required this.image, required this.onTap});
}
