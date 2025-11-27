import 'package:amiibo_app/models/amiibo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const base = 'https://www.amiiboapi.com/api/amiibo';

  Future<List<Amiibo>> fetchAll() async {
    final uri = Uri.parse(base);
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final map = jsonDecode(res.body) as Map<String, dynamic>;
      final list = (map['amiibo'] as List<dynamic>);
      return list.map((e) => Amiibo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load amiibo');
    }
  }
}
