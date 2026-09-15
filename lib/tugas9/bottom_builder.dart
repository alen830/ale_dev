import 'package:ale_dev/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class BottomBuilder extends StatelessWidget {
  const BottomBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 9 Flutter - Kategori Toko',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainTabScreen(),
    );
  }
}

class MainTabScreen extends StatelessWidget {
  const MainTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Aplikasi Kategori Toko'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '1. List'),
              Tab(text: '2. List Map'),
              Tab(text: '3. Model'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PendekatanListSederhana(),
            PendekatanListMap(),
            PendekatanModel(),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 1. PENDEKATAN LIST (Teks Saja)
// ==========================================
class PendekatanListSederhana extends StatelessWidget {
  const PendekatanListSederhana({super.key});

  final List<String> kategoriList = const [
    'Pakaian Pria',
    'Pakaian Wanita',
    'Elektronik',
    'Sepatu & Sandal',
    'Tas & Aksesoris',
    'Kecantikan & Perawatan',
    'Makanan & Minuman',
    'Peralatan Rumah Tangga',
    'Olahraga & Outdoor',
    'Otomotif',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kategoriList.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(kategoriList[index]));
      },
    );
  }
}

// ==========================================
// 2. PENDEKATAN LIST<MAP<STRING, DYNAMIC>>
// ==========================================
class PendekatanListMap extends StatelessWidget {
  const PendekatanListMap({super.key});

  final List<Map<String, dynamic>> kategoriMap = const [
    {'nama': 'Pakaian Pria', 'icon': Icons.checkroom},
    {'nama': 'Pakaian Wanita', 'icon': Icons.woman},
    {'nama': 'Elektronik', 'icon': Icons.devices},
    {'nama': 'Sepatu & Sandal', 'icon': Icons.do_not_step},
    {'nama': 'Tas & Aksesoris', 'icon': Icons.shopping_bag},
    {'nama': 'Kecantikan & Perawatan', 'icon': Icons.face},
    {'nama': 'Makanan & Minuman', 'icon': Icons.fastfood},
    {'nama': 'Peralatan Rumah Tangga', 'icon': Icons.kitchen},
    {'nama': 'Olahraga & Outdoor', 'icon': Icons.sports_soccer},
    {'nama': 'Otomotif', 'icon': Icons.directions_car},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kategoriMap.length,
      itemBuilder: (context, index) {
        final item = kategoriMap[index];
        return ListTile(
          leading: Icon(item['icon'] as IconData),
          title: Text(item['nama'] as String),
        );
      },
    );
  }
}

// ==========================================
// 3. PENDEKATAN MODEL & WIDGET TERPISAH
// ==========================================

// Class Model Produk
class Produk {
  final String nama;
  final String deskripsi;
  final String gambarUrl;

  Produk({
    required this.nama,
    required this.deskripsi,
    required this.gambarUrl,
  });
}

class PendekatanModel extends StatelessWidget {
  const PendekatanModel({super.key});

  // Data 10 Produk
  static final List<Produk> daftarProduk = [
    Produk(
      nama: 'Kemeja Flanel Pria',
      deskripsi: 'Kemeja flanel katun nyaman dipakai sehari-hari.',
      gambarUrl: 'https://picsum.photos/200/200?random=1',
    ),
    Produk(
      nama: 'Gaun Casual Wanita',
      deskripsi: 'Gaun berbahan adem dengan desain elegan.',
      gambarUrl: 'https://picsum.photos/200/200?random=2',
    ),
    Produk(
      nama: 'Smartphone 5G',
      deskripsi: 'Layar AMOLED 120Hz dengan performa tinggi.',
      gambarUrl: 'https://picsum.photos/200/200?random=3',
    ),
    Produk(
      nama: 'Sepatu Running',
      deskripsi: 'Ringan dan empuk untuk olahraga lari jarak jauh.',
      gambarUrl: 'https://picsum.photos/200/200?random=4',
    ),
    Produk(
      nama: 'Tas Ransel Laptop',
      deskripsi: 'Kapasitas besar dengan fitur tahan air.',
      gambarUrl: 'https://picsum.photos/200/200?random=5',
    ),
    Produk(
      nama: 'Serum Wajah Vitamin C',
      deskripsi: 'Mencerahkan dan melembabkan kulit secara alami.',
      gambarUrl: 'https://picsum.photos/200/200?random=6',
    ),
    Produk(
      nama: 'Kopi Arabika 250g',
      deskripsi: 'Biji kopi pilihan dengan aroma khas nusantara.',
      gambarUrl: 'https://picsum.photos/200/200?random=7',
    ),
    Produk(
      nama: 'Blender Serbaguna',
      deskripsi: 'Hemat listrik dengan pisau stainless steel tajam.',
      gambarUrl: 'https://picsum.photos/200/200?random=8',
    ),
    Produk(
      nama: 'Matras Yoga',
      deskripsi: 'Bahan anti slip tebal 6mm untuk kenyamanan latihan.',
      gambarUrl: 'https://picsum.photos/200/200?random=9',
    ),
    Produk(
      nama: 'Helm Full Face',
      deskripsi: 'Standar SNI dengan proteksi maksimal dan kaca anti gores.',
      gambarUrl: 'https://picsum.photos/200/200?random=10',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: daftarProduk.length,
      itemBuilder: (context, index) {
        return ListProduk(produk: daftarProduk[index]);
      },
    );
  }
}

// Widget Terpisah ListProduk
class ListProduk extends StatelessWidget {
  final Produk produk;

  const ListProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            produk.gambarUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 50),
          ),
        ),
        title: Text(
          produk.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(produk.deskripsi),
      ),
    );
  }
}
