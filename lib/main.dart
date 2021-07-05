import 'package:flutter/material.dart';
import 'package:wordpair_generator/navmenu.dart';
import 'randwom_words.dart';

//void main() => runApp(MyApp());
void main() => runApp(NavApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: RandomWords());
  }
}

class NavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: NavDrawerDemo(key: Key('test')));
  }
}
