import 'package:cloud_firestore/cloud_firestore.dart';

class MaamlaatModel {
  final String id;
  final String name;
  final String maamlaat;
  final Timestamp date;
  final String status;
  final bool isPublic;

  final String? reply1;
  final String? reply1By;
  final Timestamp? reply1Date;

  final String? reply2;
  final String? reply2By;
  final Timestamp? reply2Date;

  final String? reply3;
  final String? reply3By;
  final Timestamp? reply3Date;

  MaamlaatModel({
    required this.id,
    required this.name,
    required this.maamlaat,
    required this.date,
    required this.status,
    required this.isPublic,
    this.reply1,
    this.reply1By,
    this.reply1Date,
    this.reply2,
    this.reply2By,
    this.reply2Date,
    this.reply3,
    this.reply3By,
    this.reply3Date,
  });

  /// From Firestore document
  factory MaamlaatModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return MaamlaatModel(
      id: doc.id,
      name: data['name'] ?? '',
      maamlaat: data['maamlaat'] ?? '',
      date: data['date'] ?? Timestamp.now(),
      status: data['status'] ?? 'unanswered',
      isPublic: data['public'] ?? true,
      reply1: data['reply1'],
      reply1By: data['reply1_by'],
      reply1Date: data['reply1_date'],
      reply2: data['reply2'],
      reply2By: data['reply2_by'],
      reply2Date: data['reply2_date'],
      reply3: data['reply3'],
      reply3By: data['reply3_by'],
      reply3Date: data['reply3_date'],
    );
  }

  /// To Firestore document
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'maamlaat': maamlaat,
      'date': date,
      'status': status,
      'public': isPublic,
      'reply1': reply1,
      'reply1_by': reply1By,
      'reply1_date': reply1Date,
      'reply2': reply2,
      'reply2_by': reply2By,
      'reply2_date': reply2Date,
      'reply3': reply3,
      'reply3_by': reply3By,
      'reply3_date': reply3Date,
    };
  }
}
