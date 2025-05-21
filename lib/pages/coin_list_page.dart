import 'package:cion_app/pages/coin_detail_page.dart';
import 'package:flutter/material.dart';
import '../models/crypto_coin.dart';
import '../services/api_service.dart';
import '../services/coin_service.dart';
import '../services/coin_service.dart'; 

class CoinListPage extends StatefulWidget {
  @override
  _CoinListPageState createState() => _CoinListPageState();
}

class _CoinListPageState extends State<CoinListPage> {
  late Future<List<CryptoCoin>> _futureCoins;
  List<CryptoCoin> _allCoins = [];
  List<CryptoCoin> _filteredCoins = [];
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _futureCoins = ApiService.fetchCoins();
    _futureCoins.then((coins) {
      setState(() {
        _allCoins = coins;
        _filteredCoins = coins;
      });
    });

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCoins =
          _allCoins.where((coin) {
            return coin.name.toLowerCase().contains(query) ||
                coin.symbol.toLowerCase().contains(query);
          }).toList();
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _filteredCoins = _allCoins;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title:
          _isSearching
              ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Buscar moeda...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
              : Text('Criptomoedas'),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: _toggleSearch,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: FutureBuilder<List<CryptoCoin>>(
        future: _futureCoins,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma moeda encontrada'));
          }

          return ListView.builder(
            itemCount: _filteredCoins.length,
            itemBuilder: (context, index) {
              final coin = _filteredCoins[index];
              return ListTile(
                leading: Image.network(coin.image, width: 40),
                title: Text('${coin.name} (${coin.symbol.toUpperCase()})'),
                subtitle: Text('\$${coin.price.toStringAsFixed(2)}'),
                trailing: Text(
                  '${coin.percentage.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: coin.percentage >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => FutureBuilder(
                            future: fetchPriceHistory(coin.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return Scaffold(
                                  body: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );

                              if (snapshot.hasError)
                                return Scaffold(
                                  body: Center(
                                    child: Text("Erro: ${snapshot.error}"),
                                  ),
                                );

                              // Cria uma cópia da moeda com histórico
                              final coinWithHistory = CryptoCoin(
                                name: coin.name,
                                symbol: coin.symbol,
                                image: coin.image,
                                price: coin.price,
                                percentage: coin.percentage,
                                priceHistory: snapshot.data!,
                                id: coin.id,
                              );

                              return CoinDetailPage(coin: coinWithHistory);
                            },
                          ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
