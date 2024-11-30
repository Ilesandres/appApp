import 'package:flutter/material.dart';
import 'services/api_service.dart';

class TestConnectionScreen extends StatefulWidget {
  static const String routeName = '/test';

  @override
  _TestConnectionScreenState createState() => _TestConnectionScreenState();
}

class _TestConnectionScreenState extends State<TestConnectionScreen> {
  bool? connectionStatus;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  // Método para llamar a testConnection
  Future<void> _checkConnection() async {
    ApiService apiService = ApiService();
    bool result = await apiService.testConnection();
    setState(() {
      connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Connection"),
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
        child: Center(
          child: connectionStatus == null
              ? CircularProgressIndicator() // Muestra un indicador de carga mientras espera
              : connectionStatus!
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              SizedBox(height: 16),
              Text(
                "Conexión exitosa",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ) // Muestra si la conexión fue exitosa
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 60),
              SizedBox(height: 16),
              Text(
                "Error de conexión",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
