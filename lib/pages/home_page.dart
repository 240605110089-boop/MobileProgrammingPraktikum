import 'package:flutter/material.dart';

import '../models/book.dart';
import '../services/book_service.dart';
import '../widgets/book_card.dart';
import '../widgets/state_views.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _subjects = [
    'Fantasy',
    'Science',
    'History',
    'Programming',
    'Romance',
    'Biography',
    'Mystery',
    'Philosophy',
  ];

  final _service = BookService();
  final _searchController = TextEditingController();

  late Future<List<Book>> _future;
  String _subject = _subjects.first;
  String _keyword = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Memuat buku berdasarkan kata kunci (jika ada) atau subjek terpilih.
  void _load() {
    _future = _keyword.isEmpty
        ? _service.booksBySubject(_subject)
        : _service.searchBooks(_keyword);
  }

  void _selectSubject(String subject) {
    setState(() {
      _subject = subject;
      _keyword = '';
      _searchController.clear();
      _load();
    });
  }

  void _submitSearch(String value) {
    setState(() {
      _keyword = value.trim();
      _load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pustaka Buku')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: _submitSearch,
              decoration: InputDecoration(
                hintText: 'Cari judul, mis. harry potter',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _keyword.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => _selectSubject(_subject),
                      ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
              ),
            ),
          ),
          SizedBox(
            height: 56,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _subjects.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) => ChoiceChip(
                label: Text(_subjects[i]),
                selected: _keyword.isEmpty && _subjects[i] == _subject,
                onSelected: (_) => _selectSubject(_subjects[i]),
              ),
            ),
          ),
          Expanded(child: _buildResults()),
        ],
      ),
    );
  }

  Widget _buildResults() {
    return FutureBuilder<List<Book>>(
      future: _future,
      builder: (context, snapshot) {
        // Kondisi 1: Loading
        if (snapshot.connectionState != ConnectionState.done) {
          return const LoadingView(message: 'Mencari buku...');
        }
        // Kondisi 2: Error
        if (snapshot.hasError) {
          return ErrorView(
            message: snapshot.error.toString(),
            onRetry: () => setState(_load),
          );
        }
        // Kondisi 3: Success
        final books = snapshot.data ?? [];
        if (books.isEmpty) {
          return EmptyView(message: 'Buku "$_keyword" tidak ditemukan.');
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.62,
          ),
          itemCount: books.length,
          itemBuilder: (context, i) => BookCard(
            book: books[i],
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => DetailPage(book: books[i])),
            ),
          ),
        );
      },
    );
  }
}
