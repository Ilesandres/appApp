import 'package:flutter/material.dart';
import 'package:flutter_application/services/api_service.dart';
import 'navigation_buttons.dart';
import 'package:flutter_application/services/user_service.dart';

class Profile extends StatelessWidget {
  final ApiService _apiService = ApiService();

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
                  future: _apiService.fetchUserData(),
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
                userData['data']['profileImage'] ??
                    'https://pixabay.com/es/vectors/foto-de-perfil-en-blanco-973460/', scale:1.0,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            userData['data']['name'] ?? 'Nombre de Usuario',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          _buildProfileButton(
            icon: Icons.person,
            title: 'Nombre: ${userData['data']['name'] ?? 'N/A'}',
            onTap: () {},
          ),
          _buildProfileButton(
            icon: Icons.email,
            title: 'Correo: ${userData['user']['mail'] ?? 'N/A'}',
            onTap: () {},
          ),
          _buildProfileButton(
            icon: Icons.calendar_today,
            title: 'Fecha de unión: ${userData['data']['createdAt'] ?? 'N/A'}',
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
               UserService().removeUser();
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
