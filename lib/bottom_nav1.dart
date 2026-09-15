import 'package:flutter/material.dart';

class BottomNav1 extends StatefulWidget {
  const BottomNav1({super.key});

  @override
  State<BottomNav1> createState() => _BottomNav1State();
}

class _BottomNav1State extends State<BottomNav1> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 40,
    fontWeight: .bold,
  );

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: Beranda', style: optionStyle),
    Text('Index 1: Produk', style: optionStyle),
    Text('Index 2: Keranjang', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Navigation')),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
