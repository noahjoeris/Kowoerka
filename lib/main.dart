import 'package:flutter/material.dart';
import 'package:kowoerka/screens/location_selector_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kowoerka',
      theme: ThemeData(
        primaryColor: Colors.blue.shade900,
        accentColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: LocationSelectorScreen(),
    );
  }
}
