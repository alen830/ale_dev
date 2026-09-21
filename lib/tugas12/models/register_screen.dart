import 'package:ale_dev/tugas12/helpers/db_helpers.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingController untuk setiap input
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _nomorHpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _asalKotaController = TextEditingController();

  late Future<List<UserModel>> _userList;

  @override
  void initState() {
    super.initState();
    _refreshUserList();
  }

  // Mengambil ulang data dari database
  void _refreshUserList() {
    setState(() {
      _userList = DatabaseHelper.instance.getAllUsers();
    });
  }

  // Simpan data ke database
  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final newUser = UserModel(
        nama: _namaController.text,
        email: _emailController.text,
        nomorHp: _nomorHpController.text,
        password: _passwordController.text,
        asalKota: _asalKotaController.text,
      );

      await DatabaseHelper.instance.createUser(newUser);

      // Reset form input
      _namaController.clear();
      _emailController.clear();
      _nomorHpController.clear();
      _passwordController.clear();
      _asalKotaController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran Berhasil Disimpan!')),
      );

      // Perbarui tampilan list
      _refreshUserList();
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _nomorHpController.dispose();
    _passwordController.dispose();
    _asalKotaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendaftaran User (SQFLite)'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // FORM INPUT
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                    ),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Nama wajib diisi' : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'Email wajib diisi';
                      if (!val.contains('@')) return 'Format email tidak valid';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nomorHpController,
                    decoration: const InputDecoration(labelText: 'Nomor HP'),
                    keyboardType: TextInputType.phone,
                    validator: (val) => val == null || val.isEmpty
                        ? 'Nomor HP wajib diisi'
                        : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'Password wajib diisi';
                      if (val.length < 6) return 'Password minimal 6 karakter';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _asalKotaController,
                    decoration: const InputDecoration(labelText: 'Asal Kota'),
                    validator: (val) => val == null || val.isEmpty
                        ? 'Asal kota wajib diisi'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                    ),
                    child: const Text(
                      'Daftar & Simpan Local',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Divider(thickness: 2),
            const SizedBox(height: 8),

            const Text(
              'Daftar Peserta Terdaftar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // LISTVIEW REAL-TIME
            FutureBuilder<List<UserModel>>(
              future: _userList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Belum ada data peserta.'),
                    ),
                  );
                }

                final users = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(user.nama[0].toUpperCase()),
                        ),
                        title: Text(user.nama),
                        subtitle: Text('${user.email} | ${user.nomorHp}'),
                        trailing: Text(user.asalKota),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
