import 'package:alertme/screens/device_search_page.dart';
import 'package:alertme/screens/emergency_contacts_page.dart';
import 'package:alertme/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart'; 
import 'personal_info_page.dart';


class HomePage extends StatelessWidget {
  final String userName;

  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, $userName'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: AppTheme.cardColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Resumen de Salud', style: AppTheme.titleText),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.favorite, color: Colors.red, size: 30),
                            SizedBox(height: 4),
                            Text('87 bpm', style: AppTheme.labelText),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.air, color: AppTheme.primaryColor, size: 30),
                            SizedBox(height: 4),
                            Text('Oxigenación: Buena', style: AppTheme.labelText),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text('Estado general: Estable', style: AppTheme.labelText),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PersonalInfoPage()),
                );
              },
              icon: const Icon(Icons.person),
              label: const Text('Informacion personal'),
            ),

            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmergencyContactsPage()),
                );
              },
              icon: const Icon(Icons.emergency),
              label: const Text('Contactos de emergencia'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DeviceSearchPage()),
                );
              },
              icon: const Icon(Icons.devices),
              label: const Text('Dispositivo'),
            ),
            
            const SizedBox(height: 30),
            const Divider(),
            const Text(
              'Estado del dispositivo: ❌ Desconectado',
              style: AppTheme.errorText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              'Última conexión: 1 junio 2025, 14:35',
              textAlign: TextAlign.center,
              style: AppTheme.labelText,
            ),
          ],
        ),
      ),
    );
  }
}
