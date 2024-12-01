import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/letter_button.dart';
import 'package:flutter_application/navigation_buttons.dart'; // Importa los botones de navegación

class Abc extends StatelessWidget {
  static const String routeName = '/abc';

  const Abc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista del alfabeto en español
    final List<Map<String, String>> abcEspanol = [
      {'letter': 'A', 'pronunciation': 'a'},
      {'letter': 'B', 'pronunciation': 'be'},
      {'letter': 'C', 'pronunciation': 'ce'},
      {'letter': 'D', 'pronunciation': 'de'},
      {'letter': 'E', 'pronunciation': 'e'},
      {'letter': 'F', 'pronunciation': 'efe'},
      {'letter': 'G', 'pronunciation': 'ge'},
      {'letter': 'H', 'pronunciation': 'hache'},
      {'letter': 'I', 'pronunciation': 'i'},
      {'letter': 'J', 'pronunciation': 'jota'},
      {'letter': 'K', 'pronunciation': 'ka'},
      {'letter': 'L', 'pronunciation': 'ele'},
      {'letter': 'M', 'pronunciation': 'eme'},
      {'letter': 'N', 'pronunciation': 'ene'},
      {'letter': 'Ñ', 'pronunciation': 'eñe'},
      {'letter': 'O', 'pronunciation': 'o'},
      {'letter': 'P', 'pronunciation': 'pe'},
      {'letter': 'Q', 'pronunciation': 'cu'},
      {'letter': 'R', 'pronunciation': 'erre'},
      {'letter': 'S', 'pronunciation': 'ese'},
      {'letter': 'T', 'pronunciation': 'te'},
      {'letter': 'U', 'pronunciation': 'u'},
      {'letter': 'V', 'pronunciation': 've'},
      {'letter': 'W', 'pronunciation': 'doble ve'},
      {'letter': 'X', 'pronunciation': 'equis'},
      {'letter': 'Y', 'pronunciation': 'ye'},
      {'letter': 'Z', 'pronunciation': 'zeta'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alfabeto Español'),
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[900]!, Colors.blue[300]!],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: abcEspanol.length,
                itemBuilder: (context, index) {
                  return LetterButton(
                    letter: abcEspanol[index]['letter']!,
                    pronunciation: abcEspanol[index]['pronunciation']!,
                    onTap: () {
                      // Acciones al presionar un botón
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Letra: ${abcEspanol[index]['letter']}, Pronunciación: ${abcEspanol[index]['pronunciation']}',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            NavigationButtons(), // Botones de navegación
          ],
        ),
      ),
    );
  }
}
