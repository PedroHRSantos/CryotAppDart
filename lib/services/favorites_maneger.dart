// lib/services/favorites_manager.dart

import '../models/crypto_coin.dart';

class FavoritesManager {
  static final List<CryptoCoin> _favorites = [];

  static void addFavorite(CryptoCoin coin) {
    if (!_favorites.any((c) => c.id == coin.id)) {
      _favorites.add(coin);
    }
  }

  static void removeFavorite(CryptoCoin coin) {
    _favorites.removeWhere((c) => c.id == coin.id);
  }

  static List<CryptoCoin> get favorites => _favorites;

  static bool isFavorite(CryptoCoin coin) {
    return _favorites.any((c) => c.id == coin.id);
  }
}
