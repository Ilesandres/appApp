import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application/services/user_service.dart';

class ApiService {
  final String baseUrl = "http://localhost:5000";

  // Método genérico para manejar solicitudes HTTP GET
  Future<http.Response> getRequest(String endpoint, {Map<String, String>? queryParameters, Map<String, String>? headers}) async {
    try {
      // Construye la URL con los parámetros de consulta (si existen)
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParameters);
      final response = await http.get(uri, headers: headers);
      return response; // Devuelve el objeto completo para manejarlo fuera.
    } catch (e) {
      throw Exception('Error en la solicitud GET: $e');
    }
  }


  // Método genérico para manejar solicitudes HTTP POST
  Future<dynamic> postRequest(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers ?? {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error en la solicitud POST: $e');
    }
  }

  // Método genérico para manejar solicitudes HTTP PUT
  Future<dynamic> putRequest(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers ?? {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error en la solicitud PUT: $e');
    }
  }

  // Método genérico para manejar solicitudes HTTP DELETE
  Future<dynamic> deleteRequest(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error en la solicitud DELETE: $e');
    }
  }

  // Manejo centralizado de respuestas HTTP
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        return response.body; // Devuelve texto si no es JSON
      }
    } else {
      throw Exception('Error en la respuesta: ${response.statusCode} - ${response.body}');
    }
  }


  // Método para registrar un nuevo usuario
  Future<bool> register(String username, String email, String password) async {
    try {
      final response = await postRequest('/api/register', {
        'username': username,
        'password': password,
        'email': email,
      });

      if (response['message'] == 'usuario registrado') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw Exception('Error en el registro: $e');
    }
  }

  // Método para manejar el login
  Future<bool> login(String email, String password) async {
    try {
      final response = await postRequest('/api/login', {
        'email': email,
        'password': password,
      });

      // Verificar la respuesta del backend
      if (response['success'] == true) {
        print("Login exitoso");
        print(response);

        await UserService().createUser(
          response['user']['email'],
          (response['user']['dataToken']).toString(),
        );

        return true;
      } else {
        print("Error en login: ${response['message']}");
        return false;
      }
    } catch (e) {
      throw Exception('Error en el inicio de sesión: $e');
    }
  }


  Future<Map<String, dynamic>> fetchUserData() async {
    // Recupera el usuario actual
    final user = await UserService().getUser();
    if (user == null) {
      throw Exception('No se pudo obtener el usuario actual');
    }

    print('Usuario actual: ${user.email}');

    // Realiza la solicitud GET al backend con los datos del usuario como parámetros de consulta
    final response = await getRequest(
      '/api/getUser',
      queryParameters: {
        'id': user!.dataToken,
        'email': user.email,
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      // Lanza una excepción con más detalles del error
      throw Exception(
        'Error al cargar los datos del usuario. Código: ${response.statusCode}, '
            'Mensaje: ${response}',
      );
    }
  }



}
