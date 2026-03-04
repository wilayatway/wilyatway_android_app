import 'package:flutter/material.dart';
import 'models/irfani_model.dart';

class IrfaniTafseelDetailScreen extends StatefulWidget {
  final IrfaniTopic topic;

  const IrfaniTafseelDetailScreen({
    super.key,
    required this.topic,
  });

  @override
  State<IrfaniTafseelDetailScreen> createState() =>
      _IrfaniTafseelDetailScreenState();
}

class _IrfaniTafseelDetailScreenState
    extends State<IrfaniTafseelDetailScreen>
    with TickerProviderStateMixin {
  bool isEnglish = true;
  final Set<int> expandedAyats = {};

  void toggleAyatExpansion(int ayatNumber) {
    setState(() {
      if (expandedAyats.contains(ayatNumber)) {
        expandedAyats.remove(ayatNumber);
      } else {
        expandedAyats.add(ayatNumber);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final topic = widget.topic;
    final title = isEnglish ? topic.titleEn : topic.titleUr;
    final introSections =
        isEnglish ? topic.introductionEn : topic.introductionUr;

    return Scaffold(
      backgroundColor: Colors.transparent,

      /// ✅ FIXED APPBAR
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF8B4513),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body: Stack(
        children: [

          /// 🔹 BACKGROUND IMAGE (RESTORED)
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 CONTENT
          CustomScrollView(
            slivers: [

              /// LANGUAGE TOGGLE
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => isEnglish = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              decoration: BoxDecoration(
                                color: isEnglish
                                    ? const Color(0xFF8B4513)
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(8),
                              ),
                              child: Text(
                                'English',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isEnglish
                                      ? Colors.white
                                      : const Color(0xFF8B4513),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => isEnglish = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              decoration: BoxDecoration(
                                color: !isEnglish
                                    ? const Color(0xFF8B4513)
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(8),
                              ),
                              child: Text(
                                'اردو',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: !isEnglish
                                      ? Colors.white
                                      : const Color(0xFF8B4513),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// INTRODUCTION
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final section = introSections[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            if (section.sectionTitle != null)
                              Padding(
                                padding:
                                    const EdgeInsets.only(
                                        bottom: 12),
                                child: Text(
                                  section.sectionTitle!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Color(0xFF8B4513),
                                  ),
                                ),
                              ),
                            ...section.paragraphs.map(
                              (p) => Padding(
                                padding:
                                    const EdgeInsets.only(
                                        bottom: 12),
                                child: Text(
                                  p,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    height: 1.7,
                                  ),
                                  textAlign:
                                      TextAlign.justify,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: introSections.length,
                ),
              ),

              /// AYATS HEADER
              const SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(16, 24, 16, 12),
                  child: Text(
                    'Ayats',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              /// AYATS
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final ayat = topic.ayats[index];
                    final isExpanded =
                        expandedAyats.contains(
                            ayat.ayatNumber);

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              Colors.white.withOpacity(0.95),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [

                            /// HEADER
                            ListTile(
                              onTap: () =>
                                  toggleAyatExpansion(
                                      ayat.ayatNumber),
                              title: Text(
                                ayat.ayatTextAr,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                isEnglish
                                    ? ayat
                                        .transliterationEn
                                    : ayat
                                        .transliterationUr,
                              ),
                              trailing: AnimatedRotation(
                                duration: const Duration(
                                    milliseconds: 300),
                                turns: isExpanded ? 0.5 : 0,
                                child: const Icon(
                                  Icons.expand_more,
                                  color: Color(0xFF8B4513),
                                ),
                              ),
                            ),

                            /// 🔥 SMOOTH EXPAND ANIMATION
                            AnimatedCrossFade(
                              firstChild:
                                  const SizedBox.shrink(),
                              secondChild: Padding(
                                padding:
                                    const EdgeInsets.all(
                                        16),
                                child: Container(
                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(
                                            0xFFF9F6F1),
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                                8),
                                  ),
                                  padding:
                                      const EdgeInsets
                                          .all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      const Text(
                                        'Description',
                                        style:
                                            TextStyle(
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                          color:
                                              Color(
                                                  0xFF8B4513),
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 8),
                                      Text(
                                        isEnglish
                                            ? ayat
                                                .descriptionEn
                                            : ayat
                                                .descriptionUr,
                                        textAlign:
                                            TextAlign
                                                .justify,
                                      ),
                                      const SizedBox(
                                          height: 16),
                                      const Text(
                                        'Complete Tafseer',
                                        style:
                                            TextStyle(
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                          color:
                                              Color(
                                                  0xFF8B4513),
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 8),
                                      Text(
                                        isEnglish
                                            ? ayat
                                                .tafseelEn
                                            : ayat
                                                .tafseelUr,
                                        textAlign:
                                            TextAlign
                                                .justify,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              crossFadeState:
                                  isExpanded
                                      ? CrossFadeState
                                          .showSecond
                                      : CrossFadeState
                                          .showFirst,
                              duration:
                                  const Duration(
                                      milliseconds:
                                          300),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: topic.ayats.length,
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}