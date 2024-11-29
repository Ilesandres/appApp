import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://127.0.0.1:5000';  // Cambia a tu URL y puerto si es diferente

  Future<List<dynamic>> getData() async {
    final response = await http.get(Uri.parse('$baseUrl/get_data'));


    if (response.statusCode == 200) {
      // Convierte el cuerpo de la respuesta en una lista de datos
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener datos');
    }
  }
   // método para iniciar sesión
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'mail': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['success'];
    } else {
      return false;
    }
  }
  Future<bool> testConnection() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/test'));
    return response.statusCode == 200;
  } catch (e) {
    print("Error de conexión: $e");
    return false;
  }
}

}




