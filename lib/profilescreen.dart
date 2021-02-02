import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:picturesque/addscreen.dart';
import 'package:picturesque/images.dart';
import 'package:picturesque/mainscreen.dart';
import 'package:picturesque/profileCard.dart';
import 'package:picturesque/searchscreen.dart';
import 'package:picturesque/settingScreen.dart';
import 'package:picturesque/user.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final User user;
  final Images image;

  const ProfileScreen({Key key, @required this.user, @required this.image})
      : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List imagesList;
  double width;
  double height;
  double screenHeight, screenWidth;
  String titlecenter = "Loading Images...";
  TextEditingController searchController = new TextEditingController();
  int _currentIndex = 3;

  @override
  void initState() {
    super.initState();
    _loadProfileImages();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
        actions: [
          // action button

          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SettingScreen(
                          user: widget.user, image: widget.image)));
            },
          ),
        ],
        backgroundColor: Colors.black,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: //SingleChildScrollView(
          ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                      child: Column(children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                        child: Image.asset(
                          "assets/images/backgrond.JPG",
                          fit: BoxFit.fitWidth,
                          height: 130,
                          width: 500,
                        ),
                      ),
                      Column(children: <Widget>[
                        SizedBox(height: 40),
                        GestureDetector(
                            onTap: _takePicture,
                            child: Container(
                                width: 150.0,
                                height: 150.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 6.0),
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: new NetworkImage(
                                            "https://techvestigate.com/picturesque/image/Profile/${widget.user.email}.jpg"))))),
                        SizedBox(height: 5),
                        Container(
                          child: Text(
                            widget.user.username?.toUpperCase() ??
                                'Not register',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.user.email,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        Container(height: 10),
                        Container(
                            width: 5000,
                            height: 5000,
                            //width: 350,
                            //height: 200,
                            child: Column(children: [
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
                                      childAspectRatio: 0.4,
                                      //(screenWidth / screenHeight) / 2.5,
                                      children: List.generate(imagesList.length,
                                          (index) {
                                        Images images = new Images(
                                          // pass all the parameter
                                          imagesid: imagesList[index]
                                              ['imagesid'],
                                          imagesdestination: imagesList[index]
                                              ['imagesdestination'],
                                          imagescollections: imagesList[index]
                                              ['imagescollections'],
                                          imagesauthor: imagesList[index]
                                              ['imagesauthor'],
                                          imagescaption: imagesList[index]
                                              ['imagescaption'],
                                          imagescover: imagesList[index]
                                              ['imagescover'],
                                          // imagesemail: imagesList[index]['imagesemail'],
                                        );

                                        return Padding(
                                          padding: EdgeInsets.all(0.5),
                                          child: ProfileCard(
                                            ownerEmail: imagesList[index]
                                                ['imagesemail'],
                                            image: images,
                                          ),
                                        );
                                      }),
                                    ))
                            ]))
                      ])
                    ])
                  ]));
                }
              }),
    );
  }

  void _loadProfileImages() {
    http.post("https://techvestigate.com/picturesque/php/load_userImage.php",
        body: {
          "email": widget.user.email,
        }).then((res) {
      print(res.body);
      print(widget.user.username);
      if (res.body == "Cart Empty") {
        imagesList = null;
        setState(() {
          print(" No data");
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          imagesList = jsondata["images"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _takePicture() {}
}
