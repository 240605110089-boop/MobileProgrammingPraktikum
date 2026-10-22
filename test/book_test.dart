import 'package:flutter_test/flutter_test.dart';
import 'package:pustaka_buku/models/book.dart';

void main() {
  test('Book.fromJson memetakan field dan URL sampul', () {
    final b = Book.fromJson({
      'key': '/works/OL45804W',
      'title': 'Fantastic Mr Fox',
      'author_name': ['Roald Dahl'],
      'first_publish_year': 1970,
      'cover_i': 12345,
      'number_of_pages_median': 96,
      'edition_count': 120,
      'subject': ['Foxes', 'Fiction'],
    });
    expect(b.workId, 'OL45804W');
    expect(b.authorText, 'Roald Dahl');
    expect(b.coverUrl('L'), 'https://covers.openlibrary.org/b/id/12345-L.jpg');
    expect(b.subjects.length, 2);
  });

  test('field kosong tidak menyebabkan error', () {
    final b = Book.fromJson({'key': '/works/OL1W'});
    expect(b.title, 'Tanpa judul');
    expect(b.authorText, 'Penulis tidak diketahui');
    expect(b.coverUrl(), isNull);
  });

  test('WorkDetail menerima description berupa teks atau objek', () {
    expect(WorkDetail.fromJson({'description': 'Halo'}).description, 'Halo');
    expect(
        WorkDetail.fromJson({
          'description': {'type': '/type/text', 'value': 'Dunia'}
        }).description,
        'Dunia');
    expect(WorkDetail.fromJson({}).description, '');
  });
}
