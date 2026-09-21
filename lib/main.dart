import 'package:flutter/material.dart';

import 'tugas11/services/preference_handler.dart';
import 'splash_screen.dart';

void main() async {
  // Memastikan binding Flutter siap sebelum async init
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi PreferenceHandler
  await PreferenceHandler.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Session Management App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
