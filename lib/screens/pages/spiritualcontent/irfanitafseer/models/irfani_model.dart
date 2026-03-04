class IrfaniTopic {
  final String id;
  final String titleEn;
  final String titleUr;
  final List<ContentSection> introductionEn;
  final List<ContentSection> introductionUr;
  final List<AyatDetail> ayats;

  IrfaniTopic({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    required this.introductionEn,
    required this.introductionUr,
    required this.ayats,
  });

  factory IrfaniTopic.fromMap(Map<String, dynamic> map) {
    return IrfaniTopic(
      id: map['id'] ?? '',
      titleEn: map['titleEn'] ?? '',
      titleUr: map['titleUr'] ?? '',
      introductionEn: (map['introductionEn'] as List<dynamic>?)
              ?.map((item) =>
                  ContentSection.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      introductionUr: (map['introductionUr'] as List<dynamic>?)
              ?.map((item) =>
                  ContentSection.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      ayats: (map['ayats'] as List<dynamic>?)
              ?.map((item) => AyatDetail.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titleEn': titleEn,
      'titleUr': titleUr,
      'introductionEn':
          introductionEn.map((section) => section.toMap()).toList(),
      'introductionUr':
          introductionUr.map((section) => section.toMap()).toList(),
      'ayats': ayats.map((ayat) => ayat.toMap()).toList(),
    };
  }
}

/// Section of introductory content with optional heading and paragraphs.
class ContentSection {
  final String? sectionTitle;
  final List<String> paragraphs;

  ContentSection({
    this.sectionTitle,
    required this.paragraphs,
  });

  factory ContentSection.fromMap(Map<String, dynamic> map) {
    return ContentSection(
      sectionTitle: map['sectionTitle'],
      paragraphs: (map['paragraphs'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sectionTitle': sectionTitle,
      'paragraphs': paragraphs,
    };
  }
}

/// Details for an individual ayat / verse.
class AyatDetail {
  final int ayatNumber;
  final String ayatTextAr;
  final String transliterationEn;
  final String transliterationUr;
  final String descriptionEn;
  final String descriptionUr;
  final String tafseelEn;
  final String tafseelUr;

  AyatDetail({
    required this.ayatNumber,
    required this.ayatTextAr,
    required this.transliterationEn,
    required this.transliterationUr,
    required this.descriptionEn,
    required this.descriptionUr,
    required this.tafseelEn,
    required this.tafseelUr,
  });

  factory AyatDetail.fromMap(Map<String, dynamic> map) {
    return AyatDetail(
      ayatNumber: map['ayatNumber'] ?? 0,
      ayatTextAr: map['ayatTextAr'] ?? '',
      transliterationEn: map['transliterationEn'] ?? '',
      transliterationUr: map['transliterationUr'] ?? '',
      descriptionEn: map['descriptionEn'] ?? '',
      descriptionUr: map['descriptionUr'] ?? '',
      tafseelEn: map['tafseelEn'] ?? '',
      tafseelUr: map['tafseelUr'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ayatNumber': ayatNumber,
      'ayatTextAr': ayatTextAr,
      'transliterationEn': transliterationEn,
      'transliterationUr': transliterationUr,
      'descriptionEn': descriptionEn,
      'descriptionUr': descriptionUr,
      'tafseelEn': tafseelEn,
      'tafseelUr': tafseelUr,
    };
  }
  }