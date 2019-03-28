import 'package:flutter/material.dart';
import 'package:delightful_animations/src/screens/home.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}