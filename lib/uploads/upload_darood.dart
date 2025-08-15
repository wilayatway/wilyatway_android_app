import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadDaroodJsonToFirestore() async {

  final String jsonString = await rootBundle.loadString('assets/collection/maamlaat.json');

  final List<dynamic> daroodList = json.decode(jsonString);

  final CollectionReference daroodCollection = FirebaseFirestore.instance
      .collection('maamlaat');

  for (final darood in daroodList) {
    await daroodCollection.add(darood);
  }

  print('✅ maamlaat data uploaded successfully!');
}
