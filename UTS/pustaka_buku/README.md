# Pustaka Buku

Aplikasi katalog buku berbasis Flutter yang menampilkan data dari [Open Library API](https://openlibrary.org/developers/api).

## Deskripsi Singkat
Pustaka Buku membantu pengguna menemukan buku berdasarkan genre atau judul, lengkap dengan sampul, penulis, tahun terbit, jumlah halaman, subjek, dan sinopsis.

## Fitur Utama
- Daftar buku per genre (Fantasy, Science, History, Programming, dll.).
- Pencarian buku berdasarkan judul atau kata kunci.
- Grid buku dengan sampul, judul, dan penulis.
- Halaman detail: sampul besar, tahun terbit, halaman, jumlah edisi, subjek, dan sinopsis.
- Penanganan loading, success, dan error dengan `FutureBuilder`, termasuk tombol "Coba Lagi".

## Teknologi dan Package
- Flutter (Material 3) dan Dart
- [`http`](https://pub.dev/packages/http) untuk permintaan HTTP
- `flutter_lints` untuk analisis kode
- API (tanpa key): `https://openlibrary.org/search.json`, `https://openlibrary.org/works/{id}.json`, dan sampul `https://covers.openlibrary.org/b/id/{id}-M.jpg`

## Struktur Folder
```
lib/
  main.dart
  models/book.dart            # class model Book dan WorkDetail
  services/book_service.dart  # permintaan HTTP dan parsing JSON
  pages/                      # home_page.dart, detail_page.dart
  widgets/                    # book_card.dart, state_views.dart
test/book_test.dart           # unit test model
```

## Langkah Menjalankan
Prasyarat: Flutter SDK dan Android Studio dengan plugin Flutter/Dart.

1. Clone repositori ini lalu masuk ke foldernya.
2. Buat folder platform (sekali saja): `flutter create . --project-name pustaka_buku --platforms android`
3. Unduh dependensi: `flutter pub get`
4. Jalankan emulator atau sambungkan perangkat Android, lalu `flutter run` (atau tombol Run di Android Studio).
5. Opsional: `flutter test`

Catatan: untuk build release pastikan `android/app/src/main/AndroidManifest.xml` memuat
`<uses-permission android:name="android.permission.INTERNET"/>`.

Sumber data: Open Library (Internet Archive).
