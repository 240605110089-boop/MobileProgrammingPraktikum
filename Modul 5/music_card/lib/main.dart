import 'package:flutter/material.dart';

void main() {
  runApp(const MusicCardApp());
}

class MusicCardApp extends StatelessWidget {
  const MusicCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // a. ThemeData.dark()
      theme: ThemeData.dark(),

      home: const MusicPage(),
    );
  }
}

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // b. AppBar
      appBar: AppBar(
        title: const Text('Sedang memutar'),
        centerTitle: true,
      ),

      // c. Card di tengah layar
      body: Center(
        child: Card(
          // d. Properti Card
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          child: Padding(
            padding: const EdgeInsets.all(12),

            child: SizedBox(
              width: 320,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Cover album
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.album,
                      size: 100,
                    ),
                  ),

                  // SizedBox untuk jarak tetap
                  const SizedBox(height: 20),

                  // Judul lagu
                  const Text(
                    'Satu Bulan',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // SizedBox untuk jarak tetap
                  const SizedBox(height: 8),

                  // Nama artis
                  const Text(
                    'Bernadya',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // SizedBox
                  const SizedBox(height: 20),

                  // Spacer digunakan untuk mengatur posisi tombol
                  Row(
                    children: [
                      const Spacer(),

                      // Tombol Like
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 32,
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}