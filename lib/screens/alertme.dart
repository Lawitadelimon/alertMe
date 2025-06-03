import 'package:alertme/screens/Register_screen.dart';
import 'package:alertme/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_theme.dart'; // Asegúrate que esta ruta esté bien según tu estructura

class AlertMe extends StatefulWidget {
  const AlertMe({super.key});

  @override
  State<AlertMe> createState() => _AlertMeState();
}

class _AlertMeState extends State<AlertMe> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

 Future<void> _login() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    // Navegar al HomePage después de login exitoso
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          userName: FirebaseAuth.instance.currentUser?.displayName ?? 'Usuario',
        ),
      ),
    );
  } on FirebaseAuthException catch (e) {
    setState(() {
      errorMessage = e.message ?? 'Error desconocido';
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              radius: 40,
              child: Text(
                'AlertMe',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const Divider(height: 40),
            const Text(
              'Iniciar Sesión',
              style: AppTheme.titleText,
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Correo:', style: AppTheme.labelText),
                  ),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'correo@ejemplo.com',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Contraseña:', style: AppTheme.labelText),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: '******',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text('Registrarme'),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Continuar'),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage,
                  style: AppTheme.errorText,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
