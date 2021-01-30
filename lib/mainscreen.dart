import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:http/http.dart' as http;
import 'package:picturesque/imageDetails.dart';
import 'dart:convert';
import 'package:picturesque/images.dart';
import 'package:picturesque/profile.dart';
//import 'package:picturesque/profile.dart';
import 'package:picturesque/profilescreen.dart';
import 'package:picturesque/searchscreen.dart';
import 'addscreen.dart';
import 'dart:async';

class MainScreen extends StatefulWidget {
  final Profile profile;

  const MainScreen({Key key, this.profile}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List imagesList;
  List profilelist;
  double screenHeight, screenWidth;
  String titlecenter = "Loading Images...";
  TextEditingController searchController = new TextEditingController();
  int _currentIndex = 0;
  bool liked = false;
  bool showHeartOverlay = false;

  @override
  void initState() {
    super.initState();
    _loadImages();
    //_loadProfile();
  }

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
                      builder: (BuildContext context) => MainScreen()));
            } else if (index == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SearchScreen()));
            } else if (index == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AddScreen()));
            } else if (index == 3) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen()));
            }
          });
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Picturesque', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // we need to use this is for the brief second when the data is loading and the layout already come out it won't get error
          imagesList == null
              // use flexible to resize base on the data
              // if restList == null, it will execute first layout which is flexible "titlecenter = No Data Found"
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
              //display the data, second layout if restList != null
              : Flexible(
                  child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: (screenWidth / screenHeight) / 0.93,
                  children: List.generate(imagesList.length, (index) {
                    return Padding(
                      padding: EdgeInsets.all(0.5),
                      child: Card(
                        child: InkWell(
                          //we want to pass index because we want to deals it with restlist
                          onTap: () => _loadImagesDetail(index),

                          onDoubleTap: () => _doubleTapped(),

                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(children: [
                                  Container(
                                    width: screenHeight / 9.5,
                                    height: screenWidth / 9.5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                      /*image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: new NetworkImage(
                                                "https://techvestigate.com/picturesque/image/Profile/${widget.profile.profileimage}.jpg"))*/
                                    ),
                                  ),
                                  Text(
                                    imagesList[index]['imagesauthor'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                              ),
                              /*Align(
                                child: Text(
                                  imagesList[index]['imagesdestination'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),*/
                              Stack(
                                // doubleclickliked
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    height: screenHeight / 2.0,
                                    width: screenWidth / 0.7,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://techvestigate.com/picturesque/image/${imagesList[index]['imagescover']}.jpg",
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          LoadingFlipping.circle(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(
                                        Icons.broken_image,
                                        size: screenWidth / 3,
                                      ),
                                    ),
                                  ),
                                  showHeartOverlay
                                      ? Icon(Icons.favorite,
                                          color: Colors.white, size: 80.0)
                                      : Container()
                                ],
                              ),
                              Container(
                                  //height: 0.,
                                  // width: screenWidth / 0.7,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                    ListTile(
                                        leading: IconButton(
                                      icon: Icon(
                                          liked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color:
                                              liked ? Colors.red : Colors.grey),
                                      onPressed: () => _pressedliked(),
                                    ))
                                  ])),
                              /* Text(
                                imagesList[index]['imagesauthor'] ,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),*/
                              SizedBox(height: 5),
                              Align(
                                child: Text(
                                  imagesList[index]['imagesauthor'] +
                                      ' : ' +
                                      imagesList[index]['imagescaption'],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              /*SizedBox(height: 5),
                              Text(
                                'RM' + imagesList[index]['imagesprice'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ))
        ],
      ),
    );
  }

  /*void _loadProfile() {
    http.post("https://techvestigate.com/picturesque/php/load_profile.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        profilelist = null;
        setState(() {
          print("No Data");
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          profilelist = jsondata["profile"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }*/

  void _loadImages() {
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
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadImagesDetail(int index) {
    print(imagesList[index]['imagesauthor']);

    Images images = new Images(
      // pass all the parameter
      imagesid: imagesList[index]['imagesid'],
      imagesdestination: imagesList[index]['imagesdestination'],
      imagescollections: imagesList[index]['imagescollections'],
      imagesauthor: imagesList[index]['imagesauthor'],
      imagesprice: imagesList[index]['imagesprice'],
      imagescaption: imagesList[index]['imagescaption'],
      imagescover: imagesList[index]['imagescover'],
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ImageDetails(image: images)));
  }

  /*_loadProfileDetail(int index) {
    print(profilelist[index]['profileauthor']);

    Profile profile = new Profile(
      // pass all the parameter
      profileid: profilelist[index]['profileid'],
      profileauthor: profilelist[index]['profileauthor'],
      profileimage: profilelist[index]['profileimage'],
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                ProfileScreen(profilepage: profile)));
  }*/

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
