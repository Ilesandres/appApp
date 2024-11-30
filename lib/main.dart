import 'package:flutter/material.dart';
import 'routes.dart'; // Importa tus rutas
import 'theme.dart'; // Importa tu tema

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Tema personalizado
      initialRoute: AppRoutes.welcome, // Ruta inicial definida
      onGenerateRoute: AppRoutes.onGenerateRoute, // Rutas dinámicas
    );
  }
}
