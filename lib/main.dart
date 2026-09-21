import 'package:ale_dev/tugas11/services/preference_handler.dart';

import 'package:ale_dev/tugas13/screens/user_list_screen.dart';

import 'package:flutter/material.dart';

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
      title: ' Tugas 13',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const UserListScreen(),
    );
  }
}
