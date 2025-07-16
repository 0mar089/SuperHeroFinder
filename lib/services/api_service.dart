import 'dart:convert';

import 'package:dio/dio.dart';

class ApiService {
  static const String baseUrl =
      "https://superheroapi.com/api/266cfc86b573bb180542dc01e052ef0d";
  static late final Dio _dio;

  static Future<void> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {"Content-Type": "application/json"},
      ),
    );
  }

  static Future<dynamic> getHeroById(int id) async {
    try {
      final response = await _dio.get("/$id");
      if (response.statusCode == 200) {
        print(jsonEncode(response.data));
        return response.data;
      } else if (response.statusCode != null && response.statusCode! >= 400 && response.statusCode! < 500) {
        throw Exception("Client error: ${response.statusCode} - ${response.statusMessage}");
      } else if (response.statusCode != null && response.statusCode! >= 500) {
        throw Exception("Server error: ${response.statusCode} - ${response.statusMessage}");
      } else {
        throw Exception("Unexpected response: ${response.statusCode} - ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Error al obtener datos: $e");
    }
  }

  static Future<List<dynamic>> getHeroesByName(String name) async {
    try {
      final response = await _dio.get("/search/$name");
      if (response.statusCode == 200) {
        if (response.data['results'] != null && response.data['results'].isNotEmpty) {
          return response.data['results'];
        } else {
          throw Exception("No results found for $name");
        }
      } else if (response.statusCode != null && response.statusCode! >= 400 && response.statusCode! < 500) {
        throw Exception("Client error: ${response.statusCode} - ${response.statusMessage}");
      } else if (response.statusCode != null && response.statusCode! >= 500) {
        throw Exception("Server error: ${response.statusCode} - ${response.statusMessage}");
      } else {
        throw Exception("Unexpected response: ${response.statusCode} - ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Error al buscar héroe por nombre: $e");
    }
  }
}
