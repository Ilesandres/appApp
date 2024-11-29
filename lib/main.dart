import 'package:flutter/material.dart';

// Importa las pantallas que ya has creado
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'main_screen.dart';
import 'abc.dart';
import 'chat.dart';
import 'profile.dart';

void main() {
  runApp(LenguasVivasApp());
}

class LenguasVivasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RAICES',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // Ruta inicial: puede ser la de bienvenida o login
      initialRoute: WelcomeScreen.routeName, // Cambiar a '/login' si es necesario
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/abc':(context)=> Abc(),
        '/chat':(context)=>Chat(),
        '/profile':(context)=>Profile(),
        MainScreen.routeName: (context) => MainScreen(), // Añadir la pantalla principal
      },
    );
  }
}
