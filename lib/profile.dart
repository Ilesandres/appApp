import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'navigation_buttons.dart';

class Profile extends StatelessWidget {
  static const String routeName = '/profile';

  // Función para obtener los datos del usuario desde el backend
  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/get_user'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Convierte la respuesta JSON a un Map
    } else {
      throw Exception('Error al cargar los datos del usuario');
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: fetchUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Hubo un problema al cargar tu información. Por favor, intenta nuevamente.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final userData = snapshot.data!;
                      return _buildProfileContent(context, userData);
                    } else {
                      return Center(
                        child: Text(
                          'No se encontraron datos de usuario',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            NavigationButtons(),
          ],
        ),
      ),
    );
  }

  // Construye la interfaz de perfil con los datos del usuario
  Widget _buildProfileContent(BuildContext context, Map<String, dynamic> userData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 55,
              backgroundImage: NetworkImage(
                userData['profileImage'] ??
                    'https://img.freepik.com/psd-gratis/ilustracion-3d-avatar-o-perfil-humano_23-2150671126.jpg',
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            userData['name'] ?? 'Nombre de Usuario',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          _buildProfileButton(
            icon: Icons.person,
            title: 'Nombre: ${userData['name'] ?? 'N/A'}',
            onTap: () {},
          ),
          _buildProfileButton(
            icon: Icons.email,
            title: 'Correo: ${userData['mail'] ?? 'N/A'}',
            onTap: () {},
          ),
          _buildProfileButton(
            icon: Icons.calendar_today,
            title: 'Fecha de unión: ${userData['createdAt'] ?? 'N/A'}',
            onTap: () {},
          ),
          _buildProfileButton(
            icon: Icons.bar_chart,
            title: 'Estadísticas',
            onTap: () {
              // Navegar a la pantalla de estadísticas
            },
          ),
          _buildProfileButton(
            icon: Icons.emoji_events,
            title: 'Logros',
            onTap: () {
              // Navegar a la pantalla de logros
            },
          ),
          _buildProfileButton(
            icon: Icons.settings,
            title: 'Configuración del perfil',
            onTap: () {
              // Navegar a la pantalla de configuración del perfil
            },
          ),
          _buildProfileButton(
            icon: Icons.logout,
            title: 'Cerrar sesión',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
    );
  }

  // Construye el botón de perfil
  Widget _buildProfileButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[700],
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue[700]),
        onTap: onTap,
      ),
    );
  }
}
