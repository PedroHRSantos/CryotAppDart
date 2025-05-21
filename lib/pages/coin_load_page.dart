import 'package:flutter/material.dart';
import '../models/crypto_coin.dart';
import '../services/coin_service.dart';
import 'coin_detail_page.dart';

class CoinLoaderPage extends StatelessWidget {
  final String coinId;

  const CoinLoaderPage({Key? key, required this.coinId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CryptoCoin>(
      future: fetchCoinWithChart(coinId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text("Carregando...")),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Erro")),
            body: Center(child: Text('Erro: ${snapshot.error}')),
          );
        } else {
          return CoinDetailPage(coin: snapshot.data!);
        }
      },
    );
  }
}
