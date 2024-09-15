import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:random_diary/models/diary_model.dart';
import 'package:random_diary/models/exception_model.dart';
import 'dart:convert';
import 'dart:io';

class RequestDiary {
  static const String _baseUrl = 'https://api.notion.com/v1/';
  final http.Client _client;

  RequestDiary({http.Client? client}) : _client = client ?? http.Client();
  Diary diaryEncoder(e, date, des) => Diary(
        date: DateTime.parse(e['properties'][date]?['date']?['start']),
        description:
            e['properties'][des]?['rich_text']?[0]?['plain_text'] ?? 'idk',
      );

  void dispose() {
    _client.close();
  }

  void clearSecureStorage() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<List<NameType>> getProperties() async {
    try {
      final storage = FlutterSecureStorage();
      final apiKey = await storage.read(key: 'api');
      final databaseId = await storage.read(key: 'des');

      List<NameType> properties = [];

      if (apiKey == null) {
        throw ApiKeyNotFoundException('API key not found');
      } else if (databaseId == null) {
        throw DatabaseIdNotFoundException('Database ID not found');
      }

      final url = '${_baseUrl}databases/$databaseId/query';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $apiKey',
          'Notion-Version': '2022-06-28',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prop = data['results'][0]['properties'];

        // Loop through properties to get name and type
        prop.forEach((name, details) {
          String type = details['type'];
          properties.add(NameType(name: name, type: type));
          print('Property Name: $name, Type: $type');
        });

        return properties;
      } else {
        throw IncorrectApiKeyException('Incorrect API key');
      }
    } catch (e) {
      throw Exception('Please add API key and Database ID');
    }
  }

  Future<List<Diary>> getDiary() async {
    try {
      final storage = FlutterSecureStorage();
      final apiKey = await storage.read(key: 'api');
      final databaseId = await storage.read(key: 'des');
      final nameProp = await storage.read(key: 'name');
      final dateProp = await storage.read(key: 'date');

      if (apiKey == null) {
        throw ApiKeyNotFoundException('API key not found');
      } else if (databaseId == null) {
        throw DatabaseIdNotFoundException('Database ID not found');
      } else if (nameProp == null) {
        throw NamePropNotFoundException('name property not found');
      } else if (dateProp == null) {
        throw DatePropNotFoundException('date property not found');
      }

      final url = '${_baseUrl}databases/$databaseId/query';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $apiKey',
          'Notion-Version': '2022-06-28',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return (data['results'] as List)
            .map((e) => diaryEncoder(e, dateProp, nameProp))
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
