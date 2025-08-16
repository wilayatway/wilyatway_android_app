import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Durood {
  final int daroodNo;
  final String heading;
  final String arabic;
  final String romanEnglish;
  final String urdu;
  final String romanUrdu;

  Durood({
    required this.daroodNo,
    required this.heading,
    required this.arabic,
    required this.romanEnglish,
    required this.urdu,
    required this.romanUrdu,
  });

  factory Durood.fromJson(Map<String, dynamic> json) {
    return Durood(
      daroodNo: json['darood-no'],
      heading: json['heading'],
      arabic: json['arabic'],
      romanEnglish: json['roman-english'],
      urdu: json['urdu'],
      romanUrdu: json['roman-urdu'],
    );
  }
}

class DuroodScreen extends StatefulWidget {
  const DuroodScreen({super.key});

  @override
  _DuroodScreenState createState() => _DuroodScreenState();
}

class _DuroodScreenState extends State<DuroodScreen> {
  List<Durood> duroods = [];
  final ScrollController _scrollController = ScrollController();
  static const String _scrollKey = 'durood_scroll_position';

  @override
  void initState() {
    super.initState();
    loadDuroods();
    _restoreScrollPosition();
    _scrollController.addListener(_saveScrollPosition);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_saveScrollPosition);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadDuroods() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('daroods').orderBy('darood-no').get();
      setState(() {
        duroods = snapshot.docs.map((doc) => Durood.fromJson(doc.data() as Map<String, dynamic>)).toList();
      });
    } catch (e) {
      // Optionally show error
      debugPrint('Error fetching daroods: $e');
    }
  }

  Future<void> _restoreScrollPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final double? savedOffset = prefs.getDouble(_scrollKey);
    if (savedOffset != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(savedOffset);
        }
      });
    }
  }

  Future<void> _saveScrollPosition() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_scrollKey, _scrollController.offset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground Content
          Column(
            children: [
              // AppBar integrated with background
              Container(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    '100 Durood Sharif',
                    style: GoogleFonts.amiri(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                  ],
                ),
              ),
              // Durood List with Scrollbar
              Expanded(
                child: duroods.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Scrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        thickness: 6.0,
                        radius: const Radius.circular(10.0),
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: duroods.length,
                          itemBuilder: (context, index) {
                            final durood = duroods[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1.5,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          durood.heading,
                                          style: GoogleFonts.amiri(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          durood.arabic,
                                          style: GoogleFonts.notoNaskhArabic(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          durood.romanEnglish,
                                          style: GoogleFonts.amiri(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          durood.urdu,
                                          style: GoogleFonts.notoNaskhArabic(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          durood.romanUrdu,
                                          style: GoogleFonts.amiri(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        // Durood Number as Page Number
                                        Center(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0,
                                              vertical: 6.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            child: Text(
                                              'Durood ${durood.daroodNo}',
                                              style: GoogleFonts.amiri(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/bg2.png'),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.white.withOpacity(0.2),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      bottom: Divider.createBorderSide(context,
                          color: Colors.black.withOpacity(0.3)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Wilayat Way',
                        style: GoogleFonts.amiri(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Your Spiritual Journey',
                        style: GoogleFonts.amiri(
                          fontSize: 16,
                          color: Colors.black87,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildDrawerItem(
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to Home
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.book,
                  title: 'Durood List',
                  onTap: () {
                    Navigator.pop(context);
                    // Already on Durood Screen
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to Settings
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black, size: 24),
      title: Text(
        title,
        style: GoogleFonts.amiri(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
    );
  }
}