import 'package:flutter/material.dart';
import '../models/crypto_coin.dart';
import '../services/favorites_maneger.dart';
import 'coin_detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final List<CryptoCoin> favorites = FavoritesManager.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('Nenhuma moeda favoritada ainda.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final coin = favorites[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(coin.symbol.toUpperCase()),
                  ),
                  title: Text(coin.name),
                  subtitle: Text('\$${coin.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        FavoritesManager.removeFavorite(coin);
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CoinDetailPage(coin: coin),
                      ),
                    ).then((_) => setState(() {})); // Atualiza favoritos ao voltar
                  },
                );
              },
            ),
    );
  }
}

