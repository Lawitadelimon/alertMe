import 'package:alertme/watch/wear_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'alertMe.dart'; // login
import 'home_page.dart'; // Home phone
import '../tv/tv_splash_screen.dart'; // TV

class SplashScreen extends StatefulWidget {
  final String deviceType;
  const SplashScreen({super.key, required this.deviceType});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (widget.deviceType == 'phone') {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(userName: user.displayName ?? 'Usuario',
          deviceType: widget.deviceType,)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AlertMe()),
        );
      }
    } else if (widget.deviceType == 'wear') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WearSplashScreen()),
      );
    } else if (widget.deviceType == 'tv') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TVSplashScreen()),
      );
    } else {
      // fallback
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AlertMe()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Colors.green),
      ),
    );
  }
}
