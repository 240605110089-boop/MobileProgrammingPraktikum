import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/book_service.dart';
import '../widgets/book_card.dart';

class DetailPage extends StatefulWidget {
  final Book book;
  const DetailPage({super.key, required this.book});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _service = BookService();
  late Future<WorkDetail> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.fetchWork(widget.book.workId);
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Buku')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 130,
                height: 190,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: 'cover-${book.key}',
                    child: BookCover(url: book.coverUrl('L')),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title, style: textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(book.authorText, style: textTheme.bodyMedium),
                    const SizedBox(height: 12),
                    if (book.firstPublishYear != null)
                      _info(Icons.event, 'Terbit pertama ${book.firstPublishYear}'),
                    if (book.pages != null)
                      _info(Icons.menu_book, '${book.pages} halaman'),
                    if (book.editionCount != null)
                      _info(Icons.library_books, '${book.editionCount} edisi'),
                  ],
                ),
              ),
            ],
          ),
          if (book.subjects.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: book.subjects.map((s) => Chip(label: Text(s))).toList(),
            ),
          ],
          const SizedBox(height: 16),
          Text('Sinopsis', style: textTheme.titleMedium),
          const SizedBox(height: 8),
          FutureBuilder<WorkDetail>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.error.toString()),
                    TextButton.icon(
                      onPressed: () => setState(() =>
                          _future = _service.fetchWork(widget.book.workId)),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                );
              }
              final text = snapshot.data!.description;
              return Text(
                text.isEmpty ? 'Sinopsis belum tersedia.' : text,
                style: const TextStyle(height: 1.5),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 6),
            Expanded(child: Text(text)),
          ],
        ),
      );
}
