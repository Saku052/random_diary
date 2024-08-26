import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:random_diary/item_model.dart';

class DiaryRepository {
  static const String _baseUrl = 'https://api.notion.com/v1/';
  final http.Client _client;

  DiaryRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<Item>> getItems() async {
    try {
      final url =
          '${_baseUrl}databases/${dotenv.env['NOTION_DATABASE_ID']}/query';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${dotenv.env['NOTION_API_KEY']}',
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
                  date:
                      DateTime.parse(e['properties']['日付']?['date']?['start']),
                  description: e['properties']['AI 要約']?['rich_text']?[0]
                          ?['plain_text'] ??
                      'idk',
                ))
            .toList();
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception('Failed to load items: $e');
    }
  }
}
