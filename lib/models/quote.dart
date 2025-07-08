// ✅ Сгенерировано AI
class Quote {
  final String text;

  Quote(this.text);

  Map<String, dynamic> toJson() => {'text': text};
  factory Quote.fromJson(Map<String, dynamic> json) => Quote(json['text']);
}
