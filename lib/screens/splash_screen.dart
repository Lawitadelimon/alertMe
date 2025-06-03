import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'alertMe.dart'; // Login
import 'home_page.dart'; // Página de inicio después del login

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  Future<void> _navigateUser() async {
    await Future.delayed(const Duration(seconds: 2)); // animación splash

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Usuario autenticado → va a HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(userName: user.displayName ?? 'Usuario'),
        ),
      );
    } else {
      // No autenticado → va a AlertMe (login)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AlertMe()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 120),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.green),
          ],
        ),
      ),
    );
  }
}
