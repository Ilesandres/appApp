import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'navigation_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Profile extends StatelessWidget {
  static const String routeName = '/profile';

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://img.freepik.com/psd-gratis/ilustracion-3d-avatar-o-perfil-humano_23-2150671126.jpg'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'nenfar',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                      await logout();
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
          NavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
