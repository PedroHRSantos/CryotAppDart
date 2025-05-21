import 'package:cion_app/main_menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainMenu(),
    );
  }
}
