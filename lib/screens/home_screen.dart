import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../models/language.dart';
import '../widgets/language_card.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lenguas Nativas del Putumayo'),
      ),
      body: FutureBuilder<List<Language>>(
        future: _firebaseService.getLanguages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar las lenguas'));
          }

          List<Language> languages = snapshot.data!;
          return ListView.builder(
            itemCount: languages.length,
            itemBuilder: (context, index) {
              return LanguageCard(language: languages[index]);
            },
          );
        },
      ),
    );
  }
}