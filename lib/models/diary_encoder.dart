import 'package:random_diary/models/diary_model.dart';

class DiaryEncoder {
  static String encodeProperty(
      Map<String, dynamic> e, String propName, String propType) {
    switch (propType) {
      case 'date':
        return e['properties'][propName]?['date']?['start'] ?? '';
      case 'title':
        return e['properties'][propName]?['title']?[0]?['plain_text'] ?? '';
      case 'rich_text':
        return e['properties'][propName]?[propType]?[0]?['plain_text'] ?? '';
      case 'select':
        return e['properties'][propName]?['select']?['name'] ?? '';
      case 'multi_select':
        final List<dynamic> options =
            e['properties'][propName]?['multi_select'] ?? [];
        return options.map((option) => option['name']).join(', ');
      case 'number':
        return e['properties'][propName]?['number']?.toString() ?? '';
      case 'checkbox':
        return e['properties'][propName]?['checkbox']?.toString() ?? '';
      default:
        return '';
    }
  }

  static Diary diaryEncoder(Map<String, dynamic> e, String dateProp,
      String descriptionProp, String descriptionType, String dateType) {
    final dateString = encodeProperty(e, dateProp, dateType);
    final description = encodeProperty(e, descriptionProp, descriptionType);

    return Diary(
      date: DateTime.tryParse(dateString) ?? DateTime.now(),
      description: description,
    );
  }
}
