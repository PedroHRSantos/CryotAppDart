import 'package:http/http.dart';

class CryptoCoin {
  final String id;
  final String name;
  final String symbol;
  final String image;
  final double price;
  final double percentage;
  final List<double>? priceHistory; // agora opcional

  CryptoCoin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.price,
    required this.percentage,
    this.priceHistory,
  });

  factory CryptoCoin.fromJson(Map<String, dynamic> json) {
    return CryptoCoin(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      image: json['image'],
      price: (json['current_price'] ?? 0).toDouble(),
      percentage: (json['price_change_percentage_24h'] ?? 0).toDouble(),
      
    );
  }

  get chartData => null;
}

