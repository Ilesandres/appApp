import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = "http://10.0.2.2:5000/"; // URL base actualizada según tu proyecto

  // Método genérico para manejar solicitudes HTTP GET
  Future<dynamic> getRequest(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
      return _handleResponse(response);
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
}
