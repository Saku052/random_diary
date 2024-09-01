import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:random_diary/item_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DiaryRepository {
  static const String _baseUrl = 'https://api.notion.com/v1/';
  final http.Client _client;

  DiaryRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  void clearSecureStorage() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<List<Item>> getItems() async {
    try {
      final storage = FlutterSecureStorage();
      final apiKey = await storage.read(key: 'api_key');
      final databaseId = await storage.read(key: 'database_id');
      final nameProp = await storage.read(key: 'name_prop');
      final dateProp = await storage.read(key: 'date_prop');

      if (apiKey == null) {
        throw ApiKeyNotFoundException('API key not found');
      } else if (databaseId == null) {
        throw DatabaseIdNotFoundException('Database ID not found');
      } else if (nameProp == null) {
        throw namePropNotFoundException('name property not found');
      } else if (dateProp == null) {
        throw datePropNotFoundException('date property not found');
      }

      final url = '${_baseUrl}databases/${databaseId}/query';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${apiKey}',
          'Notion-Version': '2022-06-28',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['results'] as List)
            .map((e) => Item(
                  name:
                      e['properties']['名前']?['title']?[0]?['plain_text'] ?? '?',
                  tag: e['properties']['タグ']?['select']?['name'] ?? 'Any',
                  date: DateTime.parse(
                      e['properties'][dateProp]?['date']?['start']),
                  description: e['properties'][nameProp]?['rich_text']?[0]
                          ?['plain_text'] ??
                      'idk',
                ))
            .toList();
      } else {
        throw IncorrectApiKeyException('Incorrect API key');
      }
    } on ApiKeyNotFoundException {
      throw Exception('Please add API key');
    } on DatabaseIdNotFoundException {
      throw Exception('Please add Database ID');
    } on IncorrectApiKeyException {
      throw Exception('Incorrect API key');
    } on Exception {
      rethrow;
    }
  }
}

class ApiKeyNotFoundException implements Exception {
  final String message;
  ApiKeyNotFoundException(this.message);

  @override
  String toString() => 'ApiKeyNotFoundException: $message';
}

class DatabaseIdNotFoundException implements Exception {
  final String message;
  DatabaseIdNotFoundException(this.message);

  @override
  String toString() => 'DatabaseIdNotFoundException: $message';
}

class namePropNotFoundException implements Exception {
  final String message;
  namePropNotFoundException(this.message);

  @override
  String toString() => 'namePropNotFoundException: $message';
}

class datePropNotFoundException implements Exception {
  final String message;
  datePropNotFoundException(this.message);

  @override
  String toString() => 'datePropNotFoundException: $message';
}

class IncorrectApiKeyException implements Exception {
  final String message;
  IncorrectApiKeyException(this.message);

  @override
  String toString() => 'IncorrectApiKeyException: $message';
}
