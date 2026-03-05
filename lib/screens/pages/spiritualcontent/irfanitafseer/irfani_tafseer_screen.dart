import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/irfani_model.dart';
import 'irfani_tafseer_detail_screen.dart';

class IrfaniTafseelScreen extends StatefulWidget {
  const IrfaniTafseelScreen({super.key});

  @override
  State<IrfaniTafseelScreen> createState() => _IrfaniTafseelScreenState();
}

class _IrfaniTafseelScreenState extends State<IrfaniTafseelScreen> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Irfani Tafseer'),
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
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Irfani Tafseer',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 246, 232, 211),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Mystical Interpretation of Quranic Wisdom',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 200, 180, 150),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Language Toggle
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color.fromARGB(255, 200, 140, 60),
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isEnglish = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isEnglish
                                        ? Color.fromARGB(255, 139, 69, 19)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'English',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isEnglish
                                          ? Color.fromARGB(255, 246, 232, 211)
                                          : Color.fromARGB(255, 200, 140, 60),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isEnglish = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: !isEnglish
                                        ? Color.fromARGB(255, 139, 69, 19)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'اردو',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: !isEnglish
                                          ? Color.fromARGB(255, 246, 232, 211)
                                          : Color.fromARGB(255, 200, 140, 60),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              // Firebase Stream
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('irfani_tafseer')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 200, 140, 60),
                          ),
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Text(
                            'No Irfani Tafseer content available',
                            style: TextStyle(
                              color: Color.fromARGB(255, 200, 140, 60),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  final topics = snapshot.data!.docs
                      .map((doc) =>
                          IrfaniTopic.fromMap(doc.data() as Map<String, dynamic>))
                      .toList();

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final topic = topics[index];
                          final title =
                              isEnglish ? topic.titleEn : topic.titleUr;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        IrfaniTafseelDetailScreen(
                                      topic: topic,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 139, 69, 19),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.book,
                                        color: Color.fromARGB(
                                            255, 246, 232, 211),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${topic.ayats.length} Ayats',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 120, 120, 120),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Color.fromARGB(255, 139, 69, 19),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: topics.length,
                      ),
                    ),
                  );
                },
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(height: MediaQuery.of(context).padding.bottom),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
