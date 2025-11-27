import 'dart:convert';

class Amiibo {
  final String name;
  final String character;
  final String image;
  final String gameSeries;
  final String amiiboSeries;
  final String type;
  final String tail;
  final String head;

  Amiibo({
    required this.name,
    required this.character,
    required this.image,
    required this.gameSeries,
    required this.amiiboSeries,
    required this.type,
    required this.tail,
    required this.head,
  });

  factory Amiibo.fromJson(Map<String, dynamic> json) {
    return Amiibo(
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      image: json['image'] ?? '',
      gameSeries: json['gameSeries'] ?? '',
      amiiboSeries: json['amiiboSeries'] ?? '',
      type: json['type'] ?? '',
      tail: json['tail'] ?? '',
      head: json['head'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'character': character,
      'image': image,
      'gameSeries': gameSeries,
      'amiiboSeries': amiiboSeries,
      'type': type,
      'tail': tail,
      'head': head,
    };
  }

  String toJsonString() => jsonEncode(toJson());
  static Amiibo fromJsonString(String s) => Amiibo.fromJson(jsonDecode(s));
}
