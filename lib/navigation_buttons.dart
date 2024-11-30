import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildNavButton(context, Icons.home, '/main'),
          _buildNavButton(context, Icons.abc, '/abc'),
          _buildNavButton(context, Icons.chat, '/chat'),
          _buildNavButton(context, Icons.person, '/profile'),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, IconData icon, String route) {
    return ElevatedButton(
      onPressed: () {
        if (ModalRoute.of(context)?.settings.name != route) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      child: Icon(
        icon,
        size: 30,
        color: Colors.white, // Color de los íconos
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(15),
        minimumSize: Size(60, 60),
        shape: CircleBorder(),
        primary: Colors.blue[900], // Color de fondo del botón
        onPrimary: Colors.white, // Color de los íconos
      ),
    );
  }
}
