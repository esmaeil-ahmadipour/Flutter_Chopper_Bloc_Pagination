import 'package:chopperblocpagination/pages/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:chopperblocpagination/pages/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}