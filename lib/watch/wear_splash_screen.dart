import 'package:flutter/material.dart';

class WearSplashScreen extends StatelessWidget {
  const WearSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wear Splash Screen'),
      ),
      body: const Center(
        child: Text(
          'Bienvenido a la versión Wear!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
