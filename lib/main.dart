import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() => runApp(const PustakaBukuApp());

class PustakaBukuApp extends StatelessWidget {
  const PustakaBukuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pustaka Buku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HomePage(),
    );
  }
}
