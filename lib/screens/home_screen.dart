// ✅ Сгенерировано AI
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';
import '../storage/favorites_storage.dart';
import '../widgets/quote_card.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Quote _currentQuote;
  List<Quote> _favorites = [];

  @override
  void initState() {
    super.initState();
    _currentQuote = QuoteService.getRandomQuote();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final loaded = await FavoritesStorage.loadFavorites();
    setState(() {
      _favorites = loaded;
    });
  }

  void _getNewQuote() {
    setState(() {
      _currentQuote = QuoteService.getRandomQuote();
    });
  }

  void _addToFavorites() async {
    if (_favorites.any((q) => q.text == _currentQuote.text)) return;
    setState(() {
      _favorites.add(_currentQuote);
    });
    await FavoritesStorage.saveFavorites(_favorites);
  }

  void _copyQuote() {
    Clipboard.setData(ClipboardData(text: _currentQuote.text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Цитата скопирована!")));
  }

  void _goToFavorites() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FavoritesScreen(onUpdate: _loadFavorites),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Quotes'),
        backgroundColor: const Color(0xFF4CAF50),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: _goToFavorites,
            icon: const Icon(Icons.star),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuoteCard(quote: _currentQuote),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                ),
                onPressed: _getNewQuote,
                child: const Text('Ещё цитату'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                ),
                onPressed: _addToFavorites,
                child: const Text('В избранное'),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: _copyQuote,
                icon: const Icon(Icons.copy),
                color: const Color(0xFF4CAF50),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
