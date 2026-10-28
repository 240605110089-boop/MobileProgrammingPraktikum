
import 'dart:convert';
import 'package:game_app/model/game.dart';
import 'package:http/http.dart' as http;

Future<List<Game>> fetchGames() async {
  try {
    final response = await http.get(
      Uri.parse('https://www.freetogame.com/api/games'),
    );

    print('Status API games: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      return jsonData
          .map((item) => Game.fromJson(item))
          .toList();
    }

    throw Exception(
      'Gagal mengambil data game. HTTP ${response.statusCode}',
    );
  } catch (e) {
    print('Error fetchGames: $e');
    rethrow;
  }
}

Future<Map<String, dynamic>> fetchDataFromAPI(int idGame) async {
  try {
    final response = await http.get(
      Uri.parse(
        'https://www.freetogame.com/api/game?id=$idGame',
      ),
    );

    print('Status API detail: ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData is Map<String, dynamic>) {
        return jsonData;
      }

      throw Exception('Format data detail game tidak sesuai');
    }

    throw Exception(
      'Gagal mengambil detail game. HTTP ${response.statusCode}',
    );
  } catch (e) {
    print('Error fetchDataFromAPI: $e');
    rethrow;
  }
}
