import 'package:flutter/material.dart';
import 'package:news_app/view/home_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(NewsCloud());
}

class NewsCloud extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HomeView(),
    );
  }
}
