import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:picturesque/addscreen.dart';
import 'package:picturesque/imageCard.dart';
import 'package:picturesque/mainscreen.dart';
import 'package:picturesque/profilescreen.dart';
import 'package:picturesque/searchscreen.dart';
import 'package:picturesque/user.dart';
import 'package:picturesque/images.dart';

class UnderwaterScreen extends StatefulWidget {
  final User user;
  final Images image;
  const UnderwaterScreen({Key key, @required this.user, @required this.image})
      : super(key: key);
  @override
  _UnderwaterScreenState createState() => _UnderwaterScreenState();
}

class _UnderwaterScreenState extends State<UnderwaterScreen> {
  double screenHeight, screenWidth;
  List imagesList;
  String titlecenter = "Loading Islands Images...";
  bool liked = false;
  bool showHeartOverlay = false;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadUnderwater();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Feather.home,
              color: Colors.grey,
            ),
            label: 'HOME',
            activeIcon: Icon(
              Feather.home,
              color: Colors.red,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesome.search,
              color: Colors.grey,
            ),
            label: 'SEARCH',
            activeIcon: Icon(
              Feather.search,
              color: Colors.red,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvilIcons.plus,
              color: Colors.grey,
              size: 36,
            ),
            label: 'ADD',
            activeIcon: Icon(
              Feather.plus,
              color: Colors.red,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvilIcons.user,
              color: Colors.grey,
              size: 36,
            ),
            label: 'PROFILE',
            activeIcon: Icon(
              Feather.user,
              color: Colors.red,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MainScreen(user: widget.user, image: widget.image)));
            } else if (index == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SearchScreen(
                          user: widget.user, image: widget.image)));
            } else if (index == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddScreen(user: widget.user, image: widget.image)));
            } else if (index == 3) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen(
                          user: widget.user, image: widget.image)));
            }
          });
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[100],
        title: Text('Collections : Underwater',
            style: TextStyle(color: Colors.black87)),
      ),
      body: Column(
        children: [
          imagesList == null
              ? Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                  titlecenter,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))))
              : Flexible(
                  child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: (screenWidth / screenHeight) / 0.93,
                  children: List.generate(imagesList.length, (index) {
                    Images images = new Images(
                      // pass all the parameter
                      imagesid: imagesList[index]['imagesid'],
                      imagesdestination: imagesList[index]['imagesdestination'],
                      imagescollections: imagesList[index]['imagescollections'],
                      imagesauthor: imagesList[index]['imagesauthor'],
                      imagescaption: imagesList[index]['imagescaption'],
                      imagescover: imagesList[index]['imagescover'],
                      // imagesemail: imagesList[index]['imagesemail'],
                    );

                    return Padding(
                      padding: EdgeInsets.all(0.5),
                      child: ImageCard(
                        ownerEmail: imagesList[index]['imagesemail'],
                        image: images,
                      ),
                    );
                  }),
                ))
        ],
      ),
    );
  }

  void _loadUnderwater() {
    http.post("https://techvestigate.com/picturesque/php/load_images.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        imagesList = null;
        setState(() {
          print(" No data");
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          imagesList = jsondata["images"];
          imagesList.removeWhere(
              (element) => element['imagescollections'] != "Underwater");
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _pressedliked() {
    setState(() {
      liked = !liked;
    });
  }

  _doubleTapped() {
    setState(() {
      showHeartOverlay = true;
      liked = true;
      if (showHeartOverlay) {
        Timer(const Duration(milliseconds: 500), () {
          setState(() {
            showHeartOverlay = false;
          });
        });
      }
    });
  }
}
