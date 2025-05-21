import 'package:cion_app/pages/coin_list_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CoinListPage()),
    );
  }
}
