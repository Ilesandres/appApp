import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';


import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late ApiService apiService;

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService();
  });

  group('ApiService Tests', () {
    test('Método register retorna true para un registro exitoso', () async {
      // Configurar el mock para devolver una respuesta correcta
      when(mockClient.post(
        Uri.parse('http://localhost:5000/api/register'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
        jsonEncode({'message': 'usuario registrado'}),
        200,
      ));

      // reescribe el cliente en la instancia de ApiService
      apiService = ApiService();
      final success = await apiService.register('usuario', 'correo@test.com', 'password123');

      // Validar que el resultado sea correcto
      expect(success, true);
    });

    test('Método login retorna true para un login exitoso', () async {
      when(mockClient.post(
        Uri.parse('http://localhost:5000/api/login'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
        jsonEncode({'success': true, 'user': {'email': 'test@test.com', 'dataToken': '123'}}),
        200,
      ));

      apiService = ApiService();
      final success = await apiService.login('correo@test.com', 'password123');
      expect(success, true);
    });

    test('fetchUserData lanza una excepción si el usuario no está autenticado',
            () async {
          when(mockClient.get(
            Uri.parse('http://localhost:5000/api/getUser'),
            headers: anyNamed('headers'),
          )).thenAnswer((_) async => http.Response(
            jsonEncode({'error': 'Usuario no autenticado'}),
            401,
          ));

          expect(
                () async => await apiService.fetchUserData(),
            throwsException,
          );
        });
  });
}
