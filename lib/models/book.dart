/// Ringkasan buku dari hasil pencarian (endpoint: search.json).
class Book {
  final String key; // contoh: "/works/OL45804W"
  final String title;
  final List<String> authors;
  final int? firstPublishYear;
  final int? coverId;
  final int? pages;
  final int? editionCount;
  final List<String> subjects;

  const Book({
    required this.key,
    required this.title,
    required this.authors,
    required this.firstPublishYear,
    required this.coverId,
    required this.pages,
    required this.editionCount,
    required this.subjects,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    List<String> toStrings(dynamic v) =>
        v is List ? v.map((e) => e.toString()).toList() : <String>[];

    return Book(
      key: json['key']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Tanpa judul',
      authors: toStrings(json['author_name']),
      firstPublishYear: (json['first_publish_year'] as num?)?.toInt(),
      coverId: (json['cover_i'] as num?)?.toInt(),
      pages: (json['number_of_pages_median'] as num?)?.toInt(),
      editionCount: (json['edition_count'] as num?)?.toInt(),
      subjects: toStrings(json['subject']).take(8).toList(),
    );
  }

  String get authorText => authors.isEmpty ? 'Penulis tidak diketahui' : authors.join(', ');

  /// ukuran: S, M, atau L.
  String? coverUrl([String size = 'M']) => coverId == null
      ? null
      : 'https://covers.openlibrary.org/b/id/$coverId-$size.jpg';

  /// Bagian id dari key, mis. "OL45804W".
  String get workId => key.split('/').last;
}

/// Deskripsi karya (endpoint: works/{id}.json).
class WorkDetail {
  final String description;

  const WorkDetail({required this.description});

  factory WorkDetail.fromJson(Map<String, dynamic> json) {
    // Field description dapat berupa teks biasa atau objek {"type", "value"}.
    final raw = json['description'];
    String text = '';
    if (raw is String) {
      text = raw;
    } else if (raw is Map && raw['value'] != null) {
      text = raw['value'].toString();
    }
    return WorkDetail(description: text.trim());
  }
}
