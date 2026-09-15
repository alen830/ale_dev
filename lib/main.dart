import 'package:ale_dev/pages/validasi.dart';
import 'package:ale_dev/tugas8/bottom_nav8.dart';
import 'package:ale_dev/tugas9/bottom_builder.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: LoginScreenDB(),
    );
  }
}
