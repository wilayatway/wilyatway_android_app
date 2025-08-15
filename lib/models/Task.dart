class Task {
  final String fromDate;
  final String toDate;
  final String heading;
  final String shortDesc;
  final Map<String, String> description;
  final String imageUrl;
  final bool isActive;

  Task({
    required this.fromDate,
    required this.toDate,
    required this.heading,
    required this.shortDesc,
    required this.description,
    required this.imageUrl,
    required this.isActive,
  });

  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      fromDate: data['date_from'],
      toDate: data['date_to'],
      heading: data['heading'],
      shortDesc: data['short_desc'],
      description: Map<String, String>.from(data['description']),
      imageUrl: data['image_url'] ?? '',
      isActive: data['isActive'],
    );
  }
}
