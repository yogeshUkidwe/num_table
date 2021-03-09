import 'package:flutter/material.dart';
import 'package:num_table/pages/numTable.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.amber,
        buttonColor: Colors.amber,
      ),
      routes: {
        '/': (BuildContext context) => MainPage(),
      },
    );
  }
}
