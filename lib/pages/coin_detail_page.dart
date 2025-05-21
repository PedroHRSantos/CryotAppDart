import 'package:cion_app/main_menu.dart';
import 'package:cion_app/pages/favorites_page.dart';
import 'package:cion_app/pages/home_page.dart';
import 'package:cion_app/services/favorites_maneger.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/crypto_coin.dart';

class CoinDetailPage extends StatelessWidget {
  final CryptoCoin coin;

  const CoinDetailPage({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${coin.name} ( ${coin.symbol.toUpperCase()})'),

        actions: [
          StatefulBuilder(
            builder: (context, setState) {
              bool isFav = FavoritesManager.isFavorite(coin);

              return IconButton(
                icon: Icon(isFav ? Icons.star : Icons.star_border),
                onPressed: () {
                  if (isFav) {
                    FavoritesManager.removeFavorite(coin);
                  } else {
                    FavoritesManager.addFavorite(coin);
                  }
                  setState(() {}); // Atualiza só o botão
                },
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // gráfico:
            SizedBox(height: 20),
            Text('Histórico de preço'),
            SizedBox(height: 12),
            Text(
              '\$${coin.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '24h: ${coin.percentage.toStringAsFixed(2)}%',
              style: TextStyle(
                fontSize: 18,
                color: coin.percentage >= 0 ? Colors.green : Colors.red,
              ),
            ),
            Center(
              child: SizedBox(
                height: 150,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(show: false),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots:
                            coin.priceHistory != null
                                ? List.generate(
                                  coin.priceHistory!.length,
                                  (index) => FlSpot(
                                    index.toDouble(),
                                    coin.priceHistory![index],
                                  ),
                                )
                                : [],

                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 2,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 8),
            Text('Domingo  Segunda  Terça   Quarta  Quinta  Sexta   Sábado'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MainMenu()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => FavoritesPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
        ],
      ),
    );
  }
}
