import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application/login_screen.dart';

void main() {
  group('Login Screen Tests', () {
    testWidgets('Renderiza los widgets principales', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );
      expect(find.byType(TextFormField), findsWidgets);
      expect(find.text('Iniciar Sesión'), findsOneWidget);
    });

    testWidgets('Permite ingresar texto en los campos', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.first, 'test@example.com');
      await tester.pump();

      expect(find.text('test@example.com'), findsOneWidget);

      await tester.enterText(textFields.last, 'password123');
      await tester.pump();
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('El botón de iniciar sesión responde al toque', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      final loginButton = find.text('Iniciar Sesión');


      expect(loginButton, findsOneWidget);


      await tester.tap(loginButton);
      await tester.pump();
    });
  });
}
