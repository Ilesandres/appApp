import 'package:flutter/material.dart';

class LetterButton extends StatefulWidget {
  final String letter; // La letra que se muestra en el botón
  final String pronunciation; // La pronunciación que se muestra en el botón
  final VoidCallback? onTap; // Callback opcional para manejar toques

  const LetterButton({
    Key? key,
    required this.letter,
    required this.pronunciation,
    this.onTap,
  }) : super(key: key);

  @override
  _LetterButtonState createState() => _LetterButtonState();
}

class _LetterButtonState extends State<LetterButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isPressed
                ? [Colors.blue[600]!, Colors.blue[800]!]
                : [Colors.blue[400]!, Colors.blue[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: _isPressed
              ? []
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.letter,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.pronunciation,
                style: const TextStyle(
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
