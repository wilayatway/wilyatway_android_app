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
              const SizedBox(height: 40),
              // Header Section
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Text(
                      '𝕎𝕚𝕝𝕒𝕪𝕒𝕥 𝕎𝕒𝕪',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Welcome to Raah e Haq',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Grid Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 30,
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio:
                        0.85, // Adjust for rectangular cards (wider than tall)
                    // shrinkWrap:
                    //     true, // Ensures GridView takes only the space it needs
                    children: [
                      buildCard(
                        context,
                        "Spiritual Content",
                        "assets/icons/mosque.png", // Update with correct path
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SpiritualContentScreen(),
                            ),
                          );
                        },
                      ),
                      buildCard(
                        context,
                        "Quran",
                        "assets/icons/quran.png", // Update with correct path
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => QuranScreen()),
                          );
                        },
                      ),
                      buildCard(
                        context,
                        "Spiritual Videos",
                        "assets/icons/yt.png",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VideoListScreen(),
                            ),
                          );
                        },
                      ),
                      buildCard(
                        context,
                        "Darood o Dua",
                        "assets/icons/task.png",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => DuroodScreen()),
                          );
                        },
                      ),
                    ],
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
                          onPressed:
                              () => _launchURL(
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
                          onPressed:
                              () => _launchURL(
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
                          onPressed:
                              () => _launchURL(
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
                    // r
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
      ),
    );
  }

  static Widget buildCard(
    BuildContext context,
    String label,
    String imagePath,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        // elevation: 2,
        color: Colors.white.withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                // height: 60, // Slightly larger icons to match the image
                color: const Color.fromARGB(255, 0, 0, 0), // Gold color as in the image
              ),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  // fontSize: 16, // Slightly larger text to match the image
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
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
