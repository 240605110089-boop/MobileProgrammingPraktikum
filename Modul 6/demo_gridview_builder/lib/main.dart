import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo GridView.builder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Demo GridView.builder',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List dataBerita = [];

  @override
  void initState() {
    super.initState();
    _ambilData();
  }

  Future<void> _ambilData() async {
    try {
      final httpClient = HttpClient();

      // Digunakan sementara untuk mengatasi
      // CERTIFICATE_VERIFY_FAILED pada emulator.
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return host == 'jakpost.vercel.app';
      };

      final client = IOClient(httpClient);

      final response = await client.get(
        Uri.parse(
          'https://jakpost.vercel.app/api/category/business/tech',
        ),
        headers: {
          'User-Agent':
          'Mozilla/5.0 (Android; Mobile) '
              'AppleWebKit/537.36 '
              '(KHTML, like Gecko) '
              'Chrome/140.0 Mobile Safari/537.36',
          'Accept': 'application/json',
        },
      );

      print('STATUS CODE: ${response.statusCode}');
      print('RESPONSE: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          dataBerita = data['posts'];
        });

        print('JUMLAH DATA: ${dataBerita.length}');
      } else {
        throw Exception(
          'Gagal load data. Status: ${response.statusCode}',
        );
      }

      client.close();
    } catch (e) {
      print('ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.title),
      ),

      body: ListView.builder(
        itemCount: dataBerita.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary,
                  width: 1,
                ),
              ),

              padding: const EdgeInsets.symmetric(
                vertical: 4,
              ),

              child: ListTile(
                title: Text(
                  dataBerita[index]['title'] ??
                      'Tidak ada judul',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  dataBerita[index]['published_at'] ??
                      dataBerita[index]['pusblised_at'] ??
                      'Tidak ada data',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),

                leading: Image.network(
                  dataBerita[index]['image'] ??
                      'https://cdn.pixabay.com/photo/2018/03/17/20/51/white-buildings-3235135__340.jpg',
                  width: 100,
                  fit: BoxFit.cover,

                  errorBuilder: (
                      context,
                      error,
                      stackTrace,
                      ) {
                    return const SizedBox(
                      width: 100,
                      height: 80,
                      child: Icon(
                        Icons.image_not_supported,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}