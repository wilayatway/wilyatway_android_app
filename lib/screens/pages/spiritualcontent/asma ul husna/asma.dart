class AsmaModel {
  final String arabic;
  final String roman;
  final String english;
  final String urdu;
  final String romanDesc;
  final String englishDesc;
  final String urduDesc;

  AsmaModel({
    required this.arabic,
    required this.roman,
    required this.english,
    required this.urdu,
    required this.romanDesc,
    required this.englishDesc,
    required this.urduDesc,
  });

  factory AsmaModel.fromJson(Map<String, dynamic> json) {
    return AsmaModel(
      arabic: json['arabic'] ?? '',
      roman: json['roman'] ?? '',
      english: json['english'] ?? '',
      urdu: json['urdu'] ?? '',
      romanDesc: json['romanDesc'] ?? '',
      englishDesc: json['englishDesc'] ?? '',
      urduDesc: json['urduDesc'] ?? '',
    );
  }
}
