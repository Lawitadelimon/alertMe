import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const WatchApp());
}

class WatchApp extends StatelessWidget {
  const WatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertMe Watch',
      home: WatchHomePage(),
    );
  }
}

class WatchHomePage extends StatefulWidget {
  @override
  _WatchHomePageState createState() => _WatchHomePageState();
}

class _WatchHomePageState extends State<WatchHomePage> {
  final pinController = TextEditingController();
  Map<String, dynamic>? userData;
  String error = "";

  Future<void> buscarDatosPorPin() async {
    final pin = pinController.text.trim();
    if (pin.isEmpty) return;

    final pairingDoc =
        await FirebaseFirestore.instance.collection('pairings').doc(pin).get();

    if (!pairingDoc.exists) {
      setState(() => error = "PIN incorrecto");
      return;
    }

    final uid = pairingDoc['uid'];
    final userDoc = await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();

    if (userDoc.exists) {
      setState(() {
        userData = userDoc.data();
        error = "";
      });
    } else {
      setState(() => error = "Datos del usuario no encontrados");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smartwatch - AlertMe')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: userData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Edad: ${userData!['edad']}"),
                  Text("Tipo de sangre: ${userData!['tipo_sangre']}"),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: pinController,
                    decoration: const InputDecoration(labelText: 'Ingresa el PIN'),
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    onPressed: buscarDatosPorPin,
                    child: const Text("Vincular"),
                  ),
                  if (error.isNotEmpty) Text(error, style: const TextStyle(color: Colors.red)),
                ],
              ),
      ),
    );
  }
}