import 'package:flutter/material.dart';
import 'package:picturesque/user.dart';

class CitiesScreen extends StatefulWidget {
  final User user;
  const CitiesScreen({Key key, @required this.user}) : super(key: key);
  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
