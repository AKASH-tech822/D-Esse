import 'package:flutter/material.dart';
import 'package:dessi/page/singnin_screen.dart';
import 'package:get_it/get_it.dart';
import './page/home.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = "DEsse-Daily Essentials";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.lime),
      //#DBE46F
      home: SignInScreen(),
    );
  }
}
