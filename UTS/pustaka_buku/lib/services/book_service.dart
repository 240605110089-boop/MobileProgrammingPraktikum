import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/book.dart';

/// Dilempar ketika permintaan ke API gagal atau data tidak dapat diproses.
class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

/// Klien untuk Open Library API.
class BookService {
  static const String baseUrl = 'https://openlibrary.org';
  static const String _fields =
      'key,title,author_name,first_publish_year,cover_i,number_of_pages_median,edition_count,subject';

  final http.Client _client;

  BookService({http.Client? client}) : _client = client ?? http.Client();

  /// Mengirim GET, memeriksa status, lalu mengurai JSON.
  Future<Map<String, dynamic>> _get(String path, Map<String, String> query) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query.isEmpty ? null : query);
    try {
      final response = await _client.get(uri, headers: {
        'User-Agent': 'PustakaBuku/1.0 (tugas kuliah)',
        'Accept': 'application/json',
      }).timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        throw ApiException('Server membalas dengan kode ${response.statusCode}.');
      }

      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is! Map<String, dynamic>) {
        throw const ApiException('Format respons tidak dikenali.');
      }
      return decoded;
    } on TimeoutException {
      throw const ApiException('Waktu tunggu habis. Periksa koneksi internet.');
    } on FormatException {
      throw const ApiException('Data dari server tidak dapat diproses.');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('Tidak dapat terhubung ke server Open Library.');
    }
  }

  Future<List<Book>> _search(String q) async {
    final body = await _get('/search.json', {
      'q': q,
      'limit': '30',
      'fields': _fields,
    });
    final docs = body['docs'];
    if (docs is! List) return [];
    return docs.whereType<Map<String, dynamic>>().map(Book.fromJson).toList();
  }

  /// Mencari buku berdasarkan judul atau kata kunci.
  Future<List<Book>> searchBooks(String keyword) => _search(keyword);

  /// Menampilkan buku berdasarkan subjek/genre.
  Future<List<Book>> booksBySubject(String subject) =>
      _search('subject:"${subject.toLowerCase()}"');

  /// Mengambil deskripsi sebuah karya.
  Future<WorkDetail> fetchWork(String workId) async {
    final body = await _get('/works/$workId.json', {});
    return WorkDetail.fromJson(body);
  }
}
