import 'package:ale_dev/bottom_nav.dart';
import 'package:ale_dev/bottom_nav1.dart';
import 'package:ale_dev/bottom_nav2.dart';
import 'package:ale_dev/bottom_nav3.dart';
import 'package:ale_dev/latihan_figma.dart';

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
      home: MyBottomNav(),
    );
  }
}
