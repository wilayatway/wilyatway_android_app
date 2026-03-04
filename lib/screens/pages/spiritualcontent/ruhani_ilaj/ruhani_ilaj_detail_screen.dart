import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/ruhani_ilaj_model.dart';

class RuhaniIlajDetailScreen extends StatefulWidget {
  final RuhaniIlajItem item;

  const RuhaniIlajDetailScreen({super.key, required this.item});

  @override
  State<RuhaniIlajDetailScreen> createState() => _RuhaniIlajDetailScreenState();
}

class _RuhaniIlajDetailScreenState extends State<RuhaniIlajDetailScreen> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final title = isEnglish ? item.titleEn : item.titleUr;
    final description = isEnglish ? item.descriptionEn : item.descriptionUr;

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
          ),
          CustomScrollView(
            slivers: [
              // Language Toggle
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white.withOpacity(0.95),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isEnglish = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isEnglish
                                      ? Colors.brown.shade700
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  isEnglish
                                      ? null
                                      : Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                            ),
                            child: Text(
                              'English',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    isEnglish
                                        ? Colors.white
                                        : Colors.grey.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isEnglish = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  !isEnglish
                                      ? Colors.brown.shade700
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  !isEnglish
                                      ? null
                                      : Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                'اردو',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      !isEnglish
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Description
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      isEnglish ? description : description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.8,
                        wordSpacing: 0.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              // Steps Header
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    isEnglish
                        ? '📿 Tareeqa (Step-by-Step)'
                        : '📿 طریقہ (مرحلہ بہ مرحلہ)',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              // Steps List in Single Container
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...item.steps.map((step) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Step Header
                              Row(
                                children: [
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      isEnglish ? step.titleEn : step.titleUr,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Description
                              Text(
                                isEnglish
                                    ? step.descriptionEn
                                    : step.descriptionUr,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              // Bullet Points
                              if ((isEnglish
                                      ? step.bulletPointsEn
                                      : step.bulletPointsUr) !=
                                  null) ...[
                                const SizedBox(height: 12),
                                ...(isEnglish
                                        ? step.bulletPointsEn
                                        : step.bulletPointsUr)!
                                    .map(
                                      (point) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              '• ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.brown,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                point,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black87,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    ,
                              ],
                              // Divider between steps (except last one)
                              if (step.stepNumber < item.steps.length)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              // Tip Section
              if (isEnglish ? item.tipEn != null : item.tipUr != null)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber.shade300),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isEnglish ? '🌸 Special Tip' : '🌸 Khaas Tip',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isEnglish ? (item.tipEn ?? '') : (item.tipUr ?? ''),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              // Bottom Padding
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
