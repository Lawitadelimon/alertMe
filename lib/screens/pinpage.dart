import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp(deviceType: '',));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required String deviceType});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GeneratePinPage(),
    );
  }
}

class GeneratePinPage extends StatefulWidget {
  @override
  _GeneratePinPageState createState() => _GeneratePinPageState();
}

class _GeneratePinPageState extends State<GeneratePinPage> {
  String? pinGenerado;

  String generarPin() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString();
  }

  Future<void> generarYGuardarPin() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {

      // 
      print("Usuario no autenticado");
      return;
    }

    final pin = generarPin();

    await FirebaseFirestore.instance.collection('pairings').doc(pin).set({
      'uid': user.uid,
      'created_at': FieldValue.serverTimestamp(),
      'status': 'waiting',
    });

    setState(() {
      pinGenerado = pin;
    });

    print("PIN generado: $pin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Generador de PIN")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pinGenerado != null
                ? Text(
                    "Tu PIN es: $pinGenerado",
                    style: const TextStyle(fontSize: 28),
                  )
                : const Text("Presiona para generar un PIN"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generarYGuardarPin,
              child: const Text("Generar PIN"),
            ),
          ],
        ),
      ),
    );
  }
}