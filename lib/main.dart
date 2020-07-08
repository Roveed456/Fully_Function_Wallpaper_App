import 'package:flutter/material.dart';
import 'package:wallpaper_app_1_simple_example/photos_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blueGrey,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PhotosHome(),
    );
  }
}
