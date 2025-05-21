import 'package:cion_app/pages/favorites_page.dart';
import 'package:cion_app/pages/home_page.dart';
import 'package:flutter/material.dart';



class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(), // página de moedas
    FavoritesPage(), // página de favoritos
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
        ],
      ),
    );
  }
}
