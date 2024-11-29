import 'package:flutter/material.dart';
import 'navigation_buttons.dart';

class Abc extends StatelessWidget {
  static const String routeName = '/abc';

  const Abc({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: Text('Alfabeto Español'),
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
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                  );
                },
              ),
            ),
            NavigationButtons(),
          ],
        ),
      ),
    );
  }
}

class LetterButton extends StatefulWidget {
  final String letter;
  final String pronunciation;

  const LetterButton({Key? key, required this.letter, required this.pronunciation}) : super(key: key);

  @override
  _LetterButtonState createState() => _LetterButtonState();
}

class _LetterButtonState extends State<LetterButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isPressed
                ? [Colors.blue[600]!, Colors.blue[800]!]
                : [Colors.blue[400]!, Colors.blue[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.letter,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                widget.pronunciation,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}