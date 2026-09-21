import 'package:flutter/material.dart';

import '../helpers/database_helper.dart';
import '../models/user_model.dart';
import 'user_form_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<UserModel> _userList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  // Mengambil ulang data dari database
  Future<void> _refreshUsers() async {
    setState(() => _isLoading = true);
    final data = await DatabaseHelper.instance.getAllUsers();
    setState(() {
      _userList = data;
      _isLoading = false;
    });
  }

  // Dialog Konfirmasi Penghapusan Data
  Future<void> _showDeleteDialog(UserModel user) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text(
            'Apakah Anda yakin ingin menghapus "${user.name}" dari database?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                Navigator.of(context).pop();
                if (user.id != null) {
                  await DatabaseHelper.instance.deleteUser(user.id!);
                  _refreshUsers(); // Refresh tampilan instan
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Data berhasil dihapus!'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Buka Form Screen (Tambah atau Edit)
  Future<void> _navigateToForm([UserModel? user]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserFormScreen(user: user)),
    );

    if (result == true) {
      _refreshUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tugas 13: Manajemen User')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _userList.isEmpty
          ? const Center(child: Text('Belum ada data user.'))
          : ListView.builder(
              itemCount: _userList.length,
              itemBuilder: (context, index) {
                final user = _userList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.name[0].toUpperCase()),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol Edit
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _navigateToForm(user),
                        ),
                        // Tombol Delete
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteDialog(user),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
