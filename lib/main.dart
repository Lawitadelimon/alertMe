import 'package:alertme/utils/device_type_helper.dart' as DeviceTypeHelper;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'theme/app_theme.dart';
import 'screens/splash_screen.dart'; // splash genérico que decide según el tipo

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final deviceType = await DeviceTypeHelper.detectDeviceType();
  runApp(MyApp(deviceType: deviceType));
}

class MyApp extends StatelessWidget {
  final String deviceType;
  const MyApp({super.key, required this.deviceType});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertMe',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: SplashScreen(deviceType: deviceType), // 👈 solo una splash
    );
  }
}
