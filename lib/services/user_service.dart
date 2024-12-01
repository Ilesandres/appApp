import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class User {
  final String email;
  final String dataToken;

  User({required this.email, required this.dataToken});

  // Convertir User a Map para guardarlo como JSON
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'dataToken': dataToken,
    };
  }

  // Crear un User desde un Map
  factory User.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('email') && map.containsKey('dataToken')) {
      return User(
        email: map['email'] ?? '',
        dataToken: map['dataToken'] ?? '',
      );
    } else {
      throw Exception('Datos del usuario incompletos en el mapa');
    }
  }

  @override
  String toString() {
    return 'User(email: $email, dataToken: $dataToken)';
  }
}

class UserService {
  // Método para guardar usuario localmente
  Future<bool> createUser(String email, String dataToken) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      User user = User(email: email, dataToken: dataToken);

      await prefs.setString('user', jsonEncode(user.toMap()));
      print('Usuario guardado localmente: ${user.email}');
      return true;
    } catch (e) {
      print('Error al guardar usuario: $e');
      return false;
    }
  }

  // Método para recuperar el usuario guardado
  Future<User?> getUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userData = prefs.getString('user');

      if (userData != null) {
        Map<String, dynamic> userMap = jsonDecode(userData);
        final user = User.fromMap(userMap);
        print('Usuario recuperado: $user');
        return user;
      }
      print('No se encontró usuario guardado');
      return null;
    } catch (e) {
      print('Error al recuperar usuario: $e');
      return null;
    }
  }

  // Método para eliminar al usuario (logout)
  Future<bool> removeUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
      print('Usuario eliminado');
      return true;
    } catch (e) {
      print('Error al eliminar usuario: $e');
      return false;
    }
  }
}
