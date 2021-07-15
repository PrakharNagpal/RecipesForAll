import 'package:flutter/material.dart';
import 'package:recipes/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes For All',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
