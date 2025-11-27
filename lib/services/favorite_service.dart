import 'package:shared_preferences/shared_preferences.dart';
import '../models/amiibo.dart';

class FavoriteService {
  static const key = "favorites";

  Future<List<Amiibo>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    return list.map((e) => Amiibo.fromJsonString(e)).toList();
  }

  Future<void> addFavorite(Amiibo a) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];

    if (!list.contains(a.toJsonString())) {
      list.add(a.toJsonString());
    }

    await prefs.setStringList(key, list);
  }

  Future<void> removeFavorite(Amiibo a) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];

    list.removeWhere((e) => Amiibo.fromJsonString(e).head == a);
    await prefs.setStringList(key, list);
  }

  Future<bool> isFavorite(Amiibo a) async {
    final favs = await loadFavorites();
    return favs.any((x) => x.head == a.head);
  }
}
