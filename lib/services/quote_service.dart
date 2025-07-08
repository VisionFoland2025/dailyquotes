// ✅ Сгенерировано AI
import '../models/quote.dart';
import 'dart:math';

class QuoteService {
  static final List<Quote> _quotes = [
    Quote("Never give up on your dreams."),
    Quote("Success is not final, failure is not fatal."),
    Quote("Believe you can and you're halfway there."),
    Quote("Do something today that your future self will thank you for."),
    Quote("You are capable of amazing things."),
  ];

  static Quote getRandomQuote() {
    final random = Random();
    return _quotes[random.nextInt(_quotes.length)];
  }
}
