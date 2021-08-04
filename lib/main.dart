import 'package:flutter/material.dart';
import 'package:event_stream_app/navmenu.dart';

//void main() => runApp(MyApp());
void main() => runApp(NavApp());

class NavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: NavDrawerDemo(key: Key('test')));
  }
}
