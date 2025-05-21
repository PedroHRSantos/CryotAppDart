import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto_coin.dart';

class ApiService {
  static const String _baseUrl =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&x_cg_demo_api_key=CG-6uPvzoDXnvW8aChugwWeXMUz';

  static Future<List<CryptoCoin>> fetchCoins() async {
    final response = await http.get(Uri.parse(_baseUrl));

    final url = Uri.parse(
  'https://api.coingecko.com/api/v3/coins/markets'
  '?vs_currency=usd'
  '&sparkline=true' // <<< importante!
  '&x_cg_demo_api_key=CG-6uPvzoDXnvW8aChugwWeXMUz',
);


    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((coin) => CryptoCoin.fromJson(coin)).toList();
    } else {
      throw Exception('Erro ao buscar dados da API');
    }
  }
}
