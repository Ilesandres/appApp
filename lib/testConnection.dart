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
      ),
      body: Center(
        child: connectionStatus == null
            ? CircularProgressIndicator()  // Muestra un indicador de carga mientras espera
            : connectionStatus!
                ? Text("Conexión exitosa")  // Muestra si la conexión fue exitosa
                : Text("Error de conexión"),
      ),
    );
  }
}
