import 'package:flutter/material.dart';

class TVSplashScreen extends StatelessWidget {
  const TVSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Splash Screen'),
      ),
      body: const Center(
        child: Text(
          'Bienvenido a la versión TV!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
