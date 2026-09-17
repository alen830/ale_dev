import 'package:ale_dev/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Forminput extends StatelessWidget {
  const Forminput({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 7 Flutter',
      theme: ThemeData.light(),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // State Navigasi (0: Checkbox, 1: Switch, 2: Dropdown, 3: DatePicker, 4: TimePicker)
  int _selectedMenuIndex = 0;

  // State untuk masing-masing Input Form
  bool _isAgreed = false;
  bool _isDarkMode = false;
  String? _selectedCategory;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // Daftar Kategori Dropdown
  final List<String> _categories = [
    'Elektronik',
    'Pakaian',
    'Makanan',
    'Lainnya',
  ];

  // Map Nama Bulan Bahasa Indonesia untuk DatePicker
  final List<String> _months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  // Helper Format Tanggal (Contoh: 17 Agustus 1945)
  String _formatDate(DateTime date) {
    return "${date.day} ${_months[date.month - 1]} ${date.year}";
  }

  // Helper Format Waktu (Contoh: 07:30 AM)
  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final formattedHour = hour.toString().padLeft(2, '0');
    return "$formattedHour:$minute $period";
  }

  // Method Pilih Tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Method Pilih Waktu
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Mendapatkan Title AppBar berdasarkan menu yang dipilih
  String _getAppBarTitle() {
    switch (_selectedMenuIndex) {
      case 0:
        return 'Syarat & Ketentuan';
      case 1:
        return 'Mode Gelap';
      case 2:
        return 'Pilih Kategori Produk';
      case 3:
        return 'Pilih Tanggal Lahir';
      case 4:
        return 'Atur Pengingat';
      default:
        return 'Tugas 7 Form Input';
    }
  }

  // Widget Tampilan Form Konten Utama
  Widget _buildBodyContent() {
    switch (_selectedMenuIndex) {
      case 0:
        // Menu 1: Checkbox
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CheckboxListTile(
              title: const Text(
                'Saya menyetujui semua persyaratan yang berlaku',
              ),
              value: _isAgreed,
              onChanged: (bool? value) {
                setState(() {
                  _isAgreed = value ?? false;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              _isAgreed
                  ? 'Lanjutkan pendaftaran diperbolehkan'
                  : 'Anda belum bisa melanjutkan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _isAgreed ? Colors.green : Colors.red,
              ),
            ),
          ],
        );

      case 1:
        // Menu 2: Switch
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: const Text('Aktifkan Mode Gelap'),
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              _isDarkMode ? 'Mode Gelap Aktif' : 'Mode Terang Aktif',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        );

      case 2:
        // Menu 3: Dropdown
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              hint: const Text('Pilih Kategori'),
              value: _selectedCategory,
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              _selectedCategory != null
                  ? 'Anda memilih kategori: $_selectedCategory'
                  : 'Belum ada kategori yang dipilih',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );

      case 3:
        // Menu 4: DatePicker
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _selectDate(context),
              icon: const Icon(Icons.calendar_month),
              label: const Text('Pilih Tanggal Lahir'),
            ),
            const SizedBox(height: 20),
            Text(
              _selectedDate != null
                  ? 'Tanggal Lahir: ${_formatDate(_selectedDate!)}'
                  : 'Belum memilih tanggal lahir',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );

      case 4:
        // Menu 5: TimePicker
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _selectTime(context),
              icon: const Icon(Icons.access_time),
              label: const Text('Pilih Waktu Pengingat'),
            ),
            const SizedBox(height: 20),
            Text(
              _selectedTime != null
                  ? 'Pengingat diatur pukul: ${_formatTime(_selectedTime!)}'
                  : 'Belum mengatur pengingat',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pengaturan tema warna background secara dinamis berdasarkan Switch Mode Gelap
    final backgroundColor = _isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = _isDarkMode ? Colors.white : Colors.black;

    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(title: Text(_getAppBarTitle())),
        // Navigasi Drawer
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dashboard, size: 48, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'Menu Navigasi Form',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.check_box),
                title: const Text('Syarat & Ketentuan'),
                selected: _selectedMenuIndex == 0,
                onTap: () {
                  setState(() {
                    _selectedMenuIndex = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Mode Gelap'),
                selected: _selectedMenuIndex == 1,
                onTap: () {
                  setState(() {
                    _selectedMenuIndex = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Pilih Kategori Produk'),
                selected: _selectedMenuIndex == 2,
                onTap: () {
                  setState(() {
                    _selectedMenuIndex = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: const Text('Tanggal Lahir'),
                selected: _selectedMenuIndex == 3,
                onTap: () {
                  setState(() {
                    _selectedMenuIndex = 3;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.timer),
                title: const Text('Atur Pengingat'),
                selected: _selectedMenuIndex == 4,
                onTap: () {
                  setState(() {
                    _selectedMenuIndex = 4;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        // Body Utama Aplikasi
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: DefaultTextStyle(
                style: TextStyle(color: textColor),
                child: _buildBodyContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
