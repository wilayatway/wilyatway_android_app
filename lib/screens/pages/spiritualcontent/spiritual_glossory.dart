import 'dart:ui';
import 'package:flutter/material.dart';

class SpiritualGlossaryPage extends StatelessWidget {
  final List<Map<String, String>> glossary = [
    {
      "term": "Muraqaba",
      "definition":
          "Deep meditation in Sufi practice, focusing the heart on Allah.",
    },
    {"term": "Kashf", "definition": "Unveiling of hidden spiritual truths."},
    {
      "term": "Dhikr",
      "definition":
          "Remembrance of Allah through repeated recitation of His names.",
    },
    {
      "term": "Fana",
      "definition": "Spiritual annihilation of the self in God.",
    },
    {"term": "Baqa", "definition": "Eternal existence in God after Fana."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset("assets/images/bg2.png", fit: BoxFit.cover),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Spiritual Glossary",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 6,
                          color: Colors.black.withOpacity(0.6),
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  Expanded(
                    child: ListView.builder(
                      itemCount: glossary.length,
                      itemBuilder: (context, index) {
                        final item = glossary[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["term"]!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      item["definition"]!,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white.withOpacity(0.9),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
