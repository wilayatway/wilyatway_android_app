import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'dart:ui';
import 'surah_reader_screen.dart';
import 'parah_reader_screen.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  int selectedTab = 0;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<dynamic> listItems =
        selectedTab == 0 ? List.generate(114, (index) => index + 1) : List.generate(30, (index) => index + 1);

    List<dynamic> filteredList = listItems.where((item) {
      String name = selectedTab == 0 ? quran.getSurahName(item).toLowerCase() : 'Parah $item'.toLowerCase();
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Al-Qur'an",
                style: TextStyle(
                  color: Color.fromARGB(255, 7, 7, 7),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: ToggleButtons(
                      isSelected: [selectedTab == 0, selectedTab == 1],
                      onPressed: (index) {
                        setState(() {
                          selectedTab = index;
                          searchQuery = '';
                        });
                      },
                      borderRadius: BorderRadius.circular(30),
                      selectedColor: Colors.white,
                      color: Colors.black87,
                      fillColor: Colors.teal.withOpacity(0.8),
                      borderColor: Colors.transparent,
                      constraints: const BoxConstraints(minHeight: 36, minWidth: 80),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      children: const [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.menu_book, size: 16),
                            SizedBox(width: 6),
                            Text("Surah"),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.auto_stories, size: 16),
                            SizedBox(width: 6),
                            Text("Parah"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.png',
              fit: BoxFit.cover,
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: selectedTab == 0 ? 'Search Surah...' : 'Search Parah...',
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      final titleEnglish = selectedTab == 0 ? quran.getSurahName(item) : 'Parah $item';
                      final titleArabic = selectedTab == 0 ? quran.getSurahNameArabic(item) : 'جزء $item';
                      final verseCount = selectedTab == 0 ? quran.getVerseCount(item) : null;
                      final placeOfRevelation = selectedTab == 0 ? quran.getPlaceOfRevelation(item) : '';

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                titleArabic,
                                style: const TextStyle(
                                  fontSize: 20.5,
                                  fontFamily: 'MeQuran',
                                  color: Color.fromARGB(255, 22, 22, 22),
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                titleEnglish,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              selectedTab == 0 ? '$verseCount Ayahs, $placeOfRevelation' : 'Parah $item of 30',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          onTap: () {
                            if (selectedTab == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SurahReaderScreen(surahNumber: item),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParahReaderScreen(parahNumber: item),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
