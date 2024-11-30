import 'package:flutter/material.dart';
import 'package:flutter_application/welcome_screen.dart';
import 'package:flutter_application/register_screen.dart';
import 'package:flutter_application/login_screen.dart';

class AppRoutes {
  // Nombres de las rutas como constantes
  static const String welcome = '/welcome';
  static const String register = '/register';
  static const String login = '/login';

  // Mapa de rutas principales
  static final Map<String, WidgetBuilder> routes = {
    welcome: (context) => WelcomeScreen(),
    register: (context) => RegisterScreen(),
    login: (context) => LoginScreen(),
  };

  // Generación dinámica de rutas con soporte para argumentos
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (routes.containsKey(settings.name)) {
      return MaterialPageRoute(
        builder: routes[settings.name]!,
        settings: settings,
      );
    }

    // Caso de rutas no encontradas
    return _errorRoute();
  }

  // Pantalla de error personalizada para rutas inválidas
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
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
                  // Regresar a la pantalla principal
                  Navigator.popUntil(_, (route) => route.isFirst);
                },
                child: const Text('Volver a inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
