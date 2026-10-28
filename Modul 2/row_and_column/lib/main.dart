import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Row and Column',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Row and Column'),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Baris pertama
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KotakBiruJempol(
                    warna: Colors.blue,
                    nama: 'Kotak 1',
                  ),

                  SizedBox(width: 20),

                  KotakBiruJempol(
                    warna: Colors.green,
                    nama: 'Kotak 2',
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Baris kedua
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KotakBiruJempol(
                    warna: Colors.orange,
                    nama: 'Kotak 3',
                  ),

                  SizedBox(width: 20),

                  KotakBiruJempol(
                    warna: Colors.purple,
                    nama: 'Kotak 4',
                  ),
                ],
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class KotakBiruJempol extends StatelessWidget {
  final Color warna;
  final String nama;

  const KotakBiruJempol({
    Key? key,
    required this.warna,
    required this.nama,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: warna,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.favorite,
            color: Colors.red,
            size: 40,
          ),
        ),

        SizedBox(height: 8),

        Text(
          nama,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}