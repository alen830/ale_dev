import 'package:ale_dev/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Validasi extends StatelessWidget {
  const Validasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulir Pendaftaran',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil data dari input text
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _noHpController.dispose();
    _kotaController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Memeriksa validasi form
    if (_formKey.currentState!.validate()) {
      // Tampilkan AlertDialog ringkasan data jika valid
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ringkasan Data'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Nama: ${_namaController.text}'),
                  Text('Email: ${_emailController.text}'),
                  Text(
                    'Nomor HP: ${_noHpController.text.isEmpty ? "-" : _noHpController.text}',
                  ),
                  Text('Kota Asal: ${_kotaController.text}'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Batal'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Lanjut'),
                onPressed: () {
                  // Tutup dialog
                  Navigator.of(context).pop();

                  // Pindah ke Halaman Konfirmasi
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmationPage(
                        nama: _namaController.text,
                        kota: _kotaController.text,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Pendaftaran'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Input Nama Lengkap (Wajib)
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama Lengkap wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Input Email (Wajib & Mengandung @)
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email wajib diisi';
                    }
                    if (!value.contains('@')) {
                      return 'Email harus mengandung karakter @';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Input Nomor HP (Opsional)
                TextFormField(
                  controller: _noHpController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Nomor HP (Opsional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Input Kota Asal (Data tambahan - Wajib)
                TextFormField(
                  controller: _kotaController,
                  decoration: const InputDecoration(
                    labelText: 'Kota Asal *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Kota Asal wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),

                // Tombol Daftar
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text('Daftar', style: TextStyle(fontSize: 16.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Halaman Konfirmasi
class ConfirmationPage extends StatelessWidget {
  final String nama;
  final String kota;

  const ConfirmationPage({super.key, required this.nama, required this.kota});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konfirmasi Pendaftaran')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 80.0,
              ),
              const SizedBox(height: 24.0),
              Text(
                'Terima kasih, $nama dari $kota telah mendaftar.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Kembali ke Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
