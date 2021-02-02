import 'package:flutter/material.dart';
import 'package:picturesque/images.dart';
import 'package:picturesque/user.dart';

class SettingScreen extends StatefulWidget {
  final User user;
  final Images image;
  const SettingScreen({Key key, @required this.user, @required this.image})
      : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Setting',
            style: TextStyle(color: Colors.white),
          ),
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
