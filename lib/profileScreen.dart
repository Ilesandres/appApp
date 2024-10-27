import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile(); // Llama a la función para cargar el perfil al inicializar
  }

  // Cargar el nombre del usuario actual de Firebase Auth
  void _loadUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userProfile = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userProfile.exists && userProfile.data() != null) {
          setState(() {
            usernameController.text = userProfile['name'] ?? '';
          });
        } else {
          print('Documento de usuario no encontrado en Firestore');
        }
      }
    } catch (e) {
      print('Error al cargar el perfil del usuario: $e');
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Nombre de usuario',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Actualizar el nombre de usuario en Firebase Auth
                  await FirebaseAuth.instance.currentUser!.updateProfile(displayName: usernameController.text);

                  // Actualizar el nombre de usuario en Firestore
                  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
                    'name': usernameController.text,
                  });

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Perfil actualizado correctamente')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al actualizar el perfil: $e')));
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Guardar cambios',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
