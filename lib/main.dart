import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mi_primer_proyecto/firebase_options.dart';


import 'welcome_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'main_screen.dart';
import 'abc.dart';
import 'chat.dart';
import 'profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: AuthMiddleware(), 
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/abc': (context) => Abc(),
        '/chat': (context) => Chat(),
        '/home': (context) => WelcomeScreen(),
        '/profile': (context) => Profile(),
        MainScreen.routeName: (context) => MainScreen(), 
      },
    );
  }
}

class AuthMiddleware extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!snapshot.hasData) {
          return WelcomeScreen(); 
        }
        
        return MainScreen();
      },
    );
  }
}
