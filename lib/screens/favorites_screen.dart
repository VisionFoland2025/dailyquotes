// ✅ Сгенерировано AI
import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../storage/favorites_storage.dart';

class FavoritesScreen extends StatefulWidget {
  final VoidCallback onUpdate;

  const FavoritesScreen({super.key, required this.onUpdate});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Quote> _favorites = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await FavoritesStorage.loadFavorites();
    setState(() {
      _favorites = list;
    });
  }

  Future<void> _removeQuote(int index) async {
    setState(() {
      _favorites.removeAt(index);
    });
    await FavoritesStorage.saveFavorites(_favorites);
    widget.onUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Избранные цитаты"),
        backgroundColor: const Color(0xFF4CAF50),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          final quote = _favorites[index];
          return ListTile(
            title: Text(quote.text),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeQuote(index),
            ),
          );
        },
      ),
    );
  }
}
