// ✅ Сгенерировано AI
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote.dart';
import 'dart:convert';

class FavoritesStorage {
  static const _key = 'favorite_quotes';

  static Future<List<Quote>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList.map((e) => Quote.fromJson(json.decode(e))).toList();
  }

  static Future<void> saveFavorites(List<Quote> quotes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = quotes.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }
}
