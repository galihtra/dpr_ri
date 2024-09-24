import 'package:dpr_ri/screens/home_page.dart';
import 'package:dpr_ri/screens/ruu_list_page.dart';
import 'package:flutter/material.dart';

import 'screens/info_singkat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RuuListScreen(),
    );
  }
}
