import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contoh Spacer',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Contoh Spacer'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Kotak amber
              kotakUji(Colors.amber),

              // Jarak kecil
              const Spacer(flex: 1),

              // Kotak hijau
              SizedBox(
                width: 100,
                height: 100,
                child: kotakUji(Colors.green),
              ),

              // Jarak lebih besar
              const Spacer(flex: 2),

              // Kotak biru
              kotakUji(Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

Container kotakUji(Color warna) {
  return Container(
    height: 75,
    width: 75,
    color: warna,
  );
}