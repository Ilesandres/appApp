import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'services/api_service.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isObscure = true;

//funcion para llamar al ApiService y obener datos
  Future<void> fetchData() async {
    try{
      List<dynamic> data = await ApiService().getData();
    }catch (e){
      print('Error al obtener datos: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al obtener datos: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[900]!, Colors.blue[300]!],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Image.network(
                      'https://tse2.mm.bing.net/th?id=OIG3.LoNbQX2sRwljKQrOkvNY&pid=ImgGn',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Bienvenido a RAICES',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Correo Electrónico',
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) => _email = value ?? '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su correo electrónico';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Por favor ingrese un correo electrónico válido';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          obscureText: _isObscure,
                          onSaved: (value) => _password = value ?? '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su contraseña';
                            }
                            if (value.length < 8) {
                              return 'La contraseña debe tener al menos 8 caracteres';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () async{
                            if (_formKey.currentState?.validate() == true) {
                              _formKey.currentState?.save();
                             // Llama al servicio API para enviar los datos
                              ApiService apiService = ApiService();
                              bool success = await apiService.login(_email, _password);
                                if(success){
                                   ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Iniciando sesión...'))
                                   );
                                  Navigator.pushNamed(context, '/main');
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error al iniciar sesión...'))
                                  );
                                }
                               }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.blue[900], backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Iniciar Sesión',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            '¿No tienes una cuenta? Regístrate',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}