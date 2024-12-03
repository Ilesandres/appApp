import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application/register_screen.dart';

void main() {
  group('RegisterScreen Widget Tests', () {
    testWidgets('Verifica que los campos de texto y el botón están presentes',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: RegisterScreen(),
            ),
          );

          expect(find.text('Nombre'), findsOneWidget);
          expect(find.text('Correo Electrónico'), findsOneWidget);
          expect(find.text('Contraseña'), findsOneWidget);


          expect(find.text('Registrarse'), findsOneWidget);
        });

    testWidgets('Verifica el formulario y validaciones',
            (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: RegisterScreen(),
            ),
          );

          await tester.tap(find.text('Registrarse'));
          await tester.pump();

          expect(find.text('Por favor ingrese su nombre'), findsOneWidget);
          expect(find.text('Por favor ingrese su correo electrónico'),
              findsOneWidget);
          expect(find.text('Por favor ingrese su contraseña'), findsOneWidget);

          await tester.enterText(
              find.byType(TextFormField).at(1), 'correo_no_valido');
          await tester.enterText(
              find.byType(TextFormField).at(2), '123');
          await tester.tap(find.text('Registrarse'));
          await tester.pump();


          expect(
              find.text('Por favor ingrese un correo electrónico válido'),
              findsOneWidget);
          expect(find.text('La contraseña debe tener al menos 6 caracteres'),
              findsOneWidget);
        });
  });
}
