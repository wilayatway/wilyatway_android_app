class Darood {
  final String title;
  final String arabic;
  final String roman;
  final String urdu;
  final String english;
  final String audioUrl;

  Darood({
    required this.title,
    required this.arabic,
    required this.roman,
    required this.urdu,
    required this.english,
    required this.audioUrl,
  });

  factory Darood.fromJson(Map<String, dynamic> json) {
    return Darood(
      title: json['title'],
      arabic: json['arabic'],
      roman: json['roman'],
      urdu: json['urdu'],
      english: json['english'],
      audioUrl: json['audio_url'],
    );
  }
}
