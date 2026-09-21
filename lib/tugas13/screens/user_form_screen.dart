import 'package:flutter/material.dart';

import '../helpers/database_helper.dart';
import '../models/user_model.dart';

class UserFormScreen extends StatefulWidget {
  final UserModel? user; // Jika null = Tambah Data, jika diisi = Edit Data

  const UserFormScreen({super.key, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Populate form dengan data lama jika mode edit
    _nameController = TextEditingController(text: widget.user?.name ?? '');
    _emailController = TextEditingController(text: widget.user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final isEdit = widget.user != null;

      final user = UserModel(
        id: widget.user?.id, // Pertahankan ID jika mode edit
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );

      if (isEdit) {
        await DatabaseHelper.instance.updateUser(user);
      } else {
        await DatabaseHelper.instance.createUser(user);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEdit
                  ? 'Data berhasil diperbarui!'
                  : 'Data berhasil ditambahkan!',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // Kirim flag true untuk refresh list
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.user != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit User' : 'Tambah User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveUser,
                icon: const Icon(Icons.save),
                label: Text(isEdit ? 'Simpan Perubahan' : 'Simpan'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
