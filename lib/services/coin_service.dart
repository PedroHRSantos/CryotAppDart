import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto_coin.dart';

Future<CryptoCoin> fetchCoinWithChart(String coinId) async {
  // 1. Buscar dados principais
  final coinRes = await http.get(
    Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=$coinId',
    ),
  );
  final coinJson = json.decode(coinRes.body)[0];

  // 2. Buscar gráfico (últimos 7 dias)
  final chartRes = await http.get(
    Uri.parse(
      'https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=usd&days=7',
    ),
  );
  final chartJson = json.decode(chartRes.body);
  final prices = chartJson['prices'] as List;

  List<double> priceHistory =
      prices.map<double>((point) => (point[1] as num).toDouble()).toList();

  // 3. Retornar objeto completo
  return CryptoCoin.fromJson(coinJson);
}

Future<List<double>> fetchPriceHistory(String coinId) async {
  final url = Uri.parse(
    'https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=usd&days=7',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final prices = json['prices'] as List;

    // Cada item é [timestamp, price]
    return prices.map((item) => (item[1] as num).toDouble()).toList();
  } else {
    throw Exception('Falha ao carregar histórico de preços');
  }
}
