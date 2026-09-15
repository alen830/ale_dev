import 'package:ale_dev/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class BottomNav8 extends StatelessWidget {
  const BottomNav8({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas 8 Flutter',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Parent Widget yang mengelola BottomNavigationBar
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // List tampilan halaman yang diakses lewat tab
  final List<Widget> _pages = const [HomePage(), AboutPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar utama
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? 'Depan (Tugas 8)' : 'Tentang Aplikasi',
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      // Drawer HANYA aktif pada tab Home (indeks 0)
      drawer: _currentIndex == 0 ? const CustomDrawer() : null,

      // Menampilkan halaman sesuai tab yang dipilih
      body: _pages[_currentIndex],

      // Navigation Bar Bawah
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Tentang Aplikasi',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 1. TAB HOME (Tugas 7: Form Input & Drawer)
// ==========================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Form Input Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
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
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Data ${textFormatter(_nameController.text)} Berhasil Disimpan!',
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Simpan Data'),
            ),
          ],
        ),
      ),
    );
  }

  String textFormatter(String text) => text.trim();
}

// Widget Drawer khusus untuk Tab Home
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Pengguna Flutter'),
            accountEmail: Text('user@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Keluar'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. TAB TENTANG APLIKASI
// ==========================================
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.flutter_dash, size: 64, color: Colors.blue),
                SizedBox(height: 16),
                Text(
                  'Aplikasi Multi Tab',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Aplikasi ini dibuat untuk memenuhi Tugas 8 Flutter yang mendemonstrasikan integrasi BottomNavigationBar dengan konfigurasi Drawer dinamis.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue),
                ),
                Divider(height: 32),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.person_outline),
                  title: Text('Pembuat'),
                  subtitle: Text('Nama Peserta / Mahasiswa'),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.build_circle_outlined),
                  title: Text('Versi Aplikasi'),
                  subtitle: Text('v1.0.0'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
