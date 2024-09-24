class Diary {
  final DateTime date;
  final String description;
  final String name;

  const Diary({
    required this.date,
    required this.description,
    this.name = 'sent from random diary',
  });
}

class NameType {
  final String name;
  final String type;

  const NameType({
    required this.name,
    required this.type,
  });
}
