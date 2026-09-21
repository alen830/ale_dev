import 'package:flutter/material.dart';

import 'tugas11/services/preference_handler.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleLogin(BuildContext context) async {
    // Simpan status login menjadi true
    await PreferenceHandler.setLogin(true);

    if (!context.mounted) return;

    // Navigasi ke HomeScreen dan hapus LoginScreen dari backstack
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selamat Datang!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _handleLogin(context),
                icon: const Icon(Icons.login),
                label: const Text('Masuk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
