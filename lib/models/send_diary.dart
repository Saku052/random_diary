import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:random_diary/models/diary_model.dart';
import 'package:random_diary/models/exception_model.dart';

class SendDiary {
  final String _baseUrl = 'https://api.notion.com/v1/';
  final http.Client _client = http.Client();

  Future<void> sendDiaryToNotion(Diary diary) async {
    try {
      final storage = FlutterSecureStorage();
      final apiKey = await storage.read(key: 'api');
      final databaseId = await storage.read(key: 'des');
      final descriptionProp = await storage.read(key: 'description');
      final dateProp = await storage.read(key: 'date');

      if (apiKey == null) {
        throw ApiKeyNotFoundException('API key not found');
      } else if (databaseId == null) {
        throw DatabaseIdNotFoundException('Database ID not found');
      } else if (descriptionProp == null) {
        throw NamePropNotFoundException('Description property not found');
      } else if (dateProp == null) {
        throw DatePropNotFoundException('Date property not found');
      }

      final url = '${_baseUrl}pages';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $apiKey',
          'Notion-Version': '2022-06-28',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'parent': {'database_id': databaseId},
          'properties': {
            descriptionProp: {
              'rich_text': [
                {
                  'text': {'content': diary.description}
                }
              ]
            },
            dateProp: {
              'date': {
                'start': diary.date.toIso8601String(),
              }
            },
          },
        }),
      );

      if (response.statusCode != 200) {
        throw IncorrectApiKeyException('Failed to send diary to Notion');
      }
    } catch (e) {
      rethrow;
    }
  }
}
