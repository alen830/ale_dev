import 'package:ale_dev/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Dropdown extends StatelessWidget {
  const Dropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Dropdown & Radio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FormDropdownRadioPage(),
    );
  }
}

class FormDropdownRadioPage extends StatefulWidget {
  const FormDropdownRadioPage({super.key});

  @override
  State<FormDropdownRadioPage> createState() => _FormDropdownRadioPageState();
}

class _FormDropdownRadioPageState extends State<FormDropdownRadioPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();

  // Variable untuk menyimpan nilai Dropdown
  String? _selectedPekerjaan;
  final List<String> _listPekerjaan = [
    'Pelajar / Mahasiswa',
    'Karyawan Swasta',
    'PNS / BUMN',
    'Wiraswasta',
    'Lainnya',
  ];

  // Variable untuk menyimpan nilai Radio Button
  String? _jenisKelamin;

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Ringkasan Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: ${_namaController.text}'),
              Text('Jenis Kelamin: $_jenisKelamin'),
              Text('Pekerjaan: $_selectedPekerjaan'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Dropdown & Radio'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Nama
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // 1. Radio Button (Jenis Kelamin)
                const Text(
                  'Jenis Kelamin *',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                FormField<String>(
                  validator: (value) {
                    if (_jenisKelamin == null) {
                      return 'Pilih jenis kelamin';
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioListTile<String>(
                          title: const Text('Laki-laki'),
                          value: 'Laki-laki',
                          groupValue: _jenisKelamin,
                          onChanged: (value) {
                            setState(() {
                              _jenisKelamin = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Perempuan'),
                          value: 'Perempuan',
                          groupValue: _jenisKelamin,
                          onChanged: (value) {
                            setState(() {
                              _jenisKelamin = value;
                            });
                          },
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),

                // 2. Dropdown (Pekerjaan)
                DropdownButtonFormField<String>(
                  value: _selectedPekerjaan,
                  decoration: const InputDecoration(
                    labelText: 'Pekerjaan *',
                    border: OutlineInputBorder(),
                  ),
                  items: _listPekerjaan.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPekerjaan = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan pilih pekerjaan';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Tombol Simpan
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Simpan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
