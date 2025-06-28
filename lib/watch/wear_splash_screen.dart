import 'package:alertme/screens/pinpage.dart';
import 'package:alertme/watch/pinpage_wear.dart';
import 'package:flutter/material.dart';

class AlertmeScreen extends StatefulWidget {
  const AlertmeScreen({super.key});

  @override
  State<AlertmeScreen> createState() => _AlertmeScreenState();
}

class _AlertmeScreenState extends State<AlertmeScreen> {
  @override
  void initState() {
    super.initState();

    // Espera 3 segundos y luego navega a la pantalla HomepageScreen, reemplazando esta pantalla.
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WatchApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // Centra el contenido en el centro de la pantalla.
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset('assets/logo.png', fit: BoxFit.contain),
              ),
              const SizedBox(
                width: 20,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.green, // Color del spinner.
                  strokeWidth: 2, // Grosor de la línea.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
