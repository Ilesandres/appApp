import 'package:flutter/material.dart';
import '../models/language.dart';

class LanguageCard extends StatelessWidget {
  final Language language;

  const LanguageCard({Key? key, required this.language}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(language.imageUrl),
        title: Text(language.name),
        subtitle: Text(language.description),
        onTap: () {
          // Navegar a la pantalla de detalles de la lengua
          Navigator.pushNamed(context, '/language/${language.id}');
        },
      ),
    );
  }
}