import 'package:flutter/material.dart';
import 'package:movie_app/Color.dart';
import 'package:movie_app/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Mycolor.white,

      ),
      home: const Home(),
    );
  }
}


