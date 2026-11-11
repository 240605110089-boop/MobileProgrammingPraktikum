import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo ListView',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Demo ListView'),
          backgroundColor: Colors.amber,
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            listTile(
              Colors.blueAccent.shade400,
              Colors.greenAccent.shade400,
              'Kehadiran',
              'Presensi kehadiran kuliah',
              'assets/icon/boy.png',
            ),
            listTile(
              Colors.greenAccent.shade400,
              Colors.blueAccent.shade400,
              'Jadwal',
              'Jadwal perkuliahan',
              'assets/icon/timetable.png',
            ),
            listTile(
              Colors.yellowAccent.shade400,
              Colors.redAccent.shade400,
              'Tugas',
              'Tugas perkuliahan di luar kelas',
              'assets/icon/homeschooling.png',
            ),
            listTile(
              Colors.redAccent.shade400,
              Colors.amberAccent.shade400,
              'Pengumuman',
              'Informasi terkait perkuliahan',
              'assets/icon/clipboard.png',
            ),
            listTile(
              Colors.purpleAccent.shade400,
              Colors.tealAccent.shade400,
              'Nilai',
              'Nilai ujian dan tugas',
              'assets/icon/marks.png',
            ),
            listTile(
              Colors.tealAccent.shade400,
              Colors.purpleAccent.shade400,
              'Catatan',
              'Pengingat kegiatan perkuliahan',
              'assets/icon/pencil.png',
            ),
          ],
        ),
      ),
    );
  }
}

// Fungsi untuk membuat ListTile
Widget listTile(
    Color warna1,
    Color warna2,
    String judul,
    String subjudul,
    String gambar,
    ) {
  return Card(
    child: ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: warna1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          gambar,
          width: 35,
          height: 35,
        ),
      ),
      title: Text(
        judul,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subjudul),
      trailing: Container(
        width: 15,
        height: 50,
        color: warna2,
      ),
    ),
  );
}