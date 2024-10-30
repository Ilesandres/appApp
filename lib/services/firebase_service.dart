import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/language.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Language>> getLanguages() async {
    QuerySnapshot snapshot = await _db.collection('languages').get();
    return snapshot.docs.map((doc) {
      return Language(
        id: doc.id,
        name: doc['name'],
        description: doc['description'],
        audioUrl: doc['audioUrl'],
        imageUrl: doc['imageUrl'],
      );
    }).toList();
  }
}