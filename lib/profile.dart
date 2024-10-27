import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'navigation_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatelessWidget {
  static const String routeName = '/profile';

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.blue[900],
        elevation: 0,
      ),
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
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage('https://img.freepik.com/psd-gratis/ilustracion-3d-avatar-o-perfil-humano_23-2150671126.jpg'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'nenfar',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    _buildProfileButton(
                      icon: Icons.person,
                      title: 'Nombre',
                      onTap: () async {
                        final usernameController = TextEditingController();
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      labelText: 'Nuevo nombre',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        await FirebaseAuth.instance.currentUser!.updateProfile(displayName: usernameController.text);
                                        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
                                          'name': usernameController.text,
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Perfil actualizado correctamente')));
                                        Navigator.pop(context); // Cierra el modal
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al actualizar el perfil: $e')));
                                      }
                                    },
                                    child: Text('Guardar cambios'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    _buildProfileButton(
                      icon: Icons.calendar_today,
                      title: 'Fecha de unión: 10/10/2024',
                      onTap: () {},
                    ),
                    _buildProfileButton(
                      icon: Icons.bar_chart,
                      title: 'Estadísticas',
                      onTap: () {},
                    ),
                    _buildProfileButton(
                      icon: Icons.emoji_events,
                      title: 'Logros',
                      onTap: () {},
                    ),
                    _buildProfileButton(
                      icon: Icons.settings,
                      title: 'Configuración del perfil',
                      onTap: () {
                        Navigator.pushNamed(context, '/configurationProfile');
                      },
                    ),
                    _buildProfileButton(
                      icon: Icons.logout,
                      title: 'Cerrar sesión',
                      onTap: () async {
                        await logout(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            NavigationButtons(),
          ],
        ),
      ),
    );
  }

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
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue[700]),
        onTap: onTap,
      ),
    );
  }
}