import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exercise.dart';

class ApiService {
  static const String _baseUrl = 'https://wger.de/api/v2';

  Future<List<Exercise>> fetchExercises() async {
    final uri = Uri.parse('$_baseUrl/exercise/?language=2&status=2');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((e) => Exercise.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }
}
