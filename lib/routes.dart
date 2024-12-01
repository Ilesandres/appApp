import 'package:flutter/material.dart';
import 'package:flutter_application/welcome_screen.dart';
import 'package:flutter_application/register_screen.dart';
import 'package:flutter_application/login_screen.dart';
import 'package:flutter_application/main_screen.dart';
import 'package:flutter_application/abc.dart';
import 'package:flutter_application/chat.dart';
import 'package:flutter_application/profile.dart';
import 'package:flutter_application/services/user_service.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String register = '/register';
  static const String login = '/login';
  static const String main = '/main';
  static const String abc = '/abc';
  static const String chat = '/chat';
  static const String profile = '/profile';

  static final Map<String, WidgetBuilder> routes = {
    welcome: (context) => WelcomeScreen(),
    register: (context) => RegisterScreen(),
    login: (context) => LoginScreen(),
    main: (context) => MainScreen(),
    abc: (context) => Abc(),
    chat: (context) => Chat(),
    profile: (context) => Profile(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => FutureBuilder<User?>(
        future: UserService().getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
          } else {
            final user = snapshot.data;
            final isLoggedIn = user != null && user.email.isNotEmpty;

            if ((settings.name == main || settings.name == abc || settings.name == chat || settings.name == profile) && !isLoggedIn) {
              return LoginScreen();
            }
            if (routes.containsKey(settings.name)) {
              return routes[settings.name]!(context);
            }
            return _errorRoute(context);
          }
        },
      ),
    );
  }

  // Pantalla de error personalizada para rutas inválidas
  static Widget _errorRoute(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Error', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              'Página no encontrada',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Volver a inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
