class RuhaniIlajItem {
  final String id;
  final String titleEn;
  final String titleUr;
  final String descriptionEn;
  final String descriptionUr;
  final List<RuhaniStep> steps;
  final String? tipEn;
  final String? tipUr;

  RuhaniIlajItem({
    required this.id,
    required this.titleEn,
    required this.titleUr,
    required this.descriptionEn,
    required this.descriptionUr,
    required this.steps,
    this.tipEn,
    this.tipUr,
  });

  factory RuhaniIlajItem.fromMap(Map<String, dynamic> map) {
    return RuhaniIlajItem(
      id: map['id'] as String? ?? '',
      titleEn: map['titleEn'] as String? ?? '',
      titleUr: map['titleUr'] as String? ?? '',
      descriptionEn: map['descriptionEn'] as String? ?? '',
      descriptionUr: map['descriptionUr'] as String? ?? '',
      steps: (map['steps'] as List<dynamic>? ?? [])
          .map((e) => RuhaniStep.fromMap(e as Map<String, dynamic>))
          .toList(),
      tipEn: map['tipEn'] as String?,
      tipUr: map['tipUr'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titleEn': titleEn,
      'titleUr': titleUr,
      'descriptionEn': descriptionEn,
      'descriptionUr': descriptionUr,
      'steps': steps.map((e) => e.toMap()).toList(),
      'tipEn': tipEn,
      'tipUr': tipUr,
    };
  }
}

class RuhaniStep {
  final int stepNumber;
  final String titleEn;
  final String titleUr;
  final String descriptionEn;
  final String descriptionUr;
  final List<String>? bulletPointsEn;
  final List<String>? bulletPointsUr;

  RuhaniStep({
    required this.stepNumber,
    required this.titleEn,
    required this.titleUr,
    required this.descriptionEn,
    required this.descriptionUr,
    this.bulletPointsEn,
    this.bulletPointsUr,
  });

  factory RuhaniStep.fromMap(Map<String, dynamic> map) {
    return RuhaniStep(
      stepNumber: map['stepNumber'] as int? ?? 0,
      titleEn: map['titleEn'] as String? ?? '',
      titleUr: map['titleUr'] as String? ?? '',
      descriptionEn: map['descriptionEn'] as String? ?? '',
      descriptionUr: map['descriptionUr'] as String? ?? '',
      bulletPointsEn: (map['bulletPointsEn'] as List<dynamic>?)?.cast<String>(),
      bulletPointsUr: (map['bulletPointsUr'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stepNumber': stepNumber,
      'titleEn': titleEn,
      'titleUr': titleUr,
      'descriptionEn': descriptionEn,
      'descriptionUr': descriptionUr,
      'bulletPointsEn': bulletPointsEn,
      'bulletPointsUr': bulletPointsUr,
    };
  }
}
