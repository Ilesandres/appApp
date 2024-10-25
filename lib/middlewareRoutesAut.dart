import 'package:flutter/material.dart';

class AuthMiddleware {
  final Widget Function(BuildContext) builder;

  AuthMiddleware({required this.builder});

  Route<dynamic> handleRoute(RouteSettings settings) {
    // Verificar si el usuario está autenticado
    if (!AuthProvider.isLoggedIn) {
      return MaterialPageRoute(builder: (context) => LoginScreen());
    }

    return MaterialPageRoute(builder: builder);
  }
}