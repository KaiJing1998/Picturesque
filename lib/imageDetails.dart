import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picturesque/addscreen.dart';
import 'package:picturesque/images.dart';
import 'package:picturesque/mainscreen.dart';
import 'package:picturesque/profilescreen.dart';
import 'package:picturesque/searchscreen.dart';

class ImageDetails extends StatefulWidget {
  final Images image;

  const ImageDetails({Key key, @required this.image}) : super(key: key);
  @override
  _ImageDetailsState createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  double screenHeight, screenWidth;
  List imagesList;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadImages();
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
                        builder: (BuildContext context) => SearchScreen(
                              user: null,
                            )));
              } else if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AddScreen(image: widget.image)));
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
          backgroundColor: Colors.white,
          title: Text(widget.image.imagesdestination,
              style: TextStyle(color: Colors.black)),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Column(
          children: [
            /*Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(children: [
                Container(
                  width: screenHeight / 9.5,
                  height: screenWidth / 9.5,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //color: Colors.red,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: new NetworkImage(
                              "https://techvestigate.com/picturesque/image/Profile/${widget.image.imagesimage}.jpg"))),
                ),
                Text(
                  widget.image.imagesauthor,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),*/
            Container(
                padding: EdgeInsets.all(15.0),
                height: screenHeight / 1.4,
                width: screenWidth / 1.0,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://techvestigate.com/picturesque/image/${widget.image.imagescover}.jpg",
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(
                    Icons.broken_image,
                    size: screenWidth / 3,
                  ),
                )),
            /*Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Column(children: <Widget>[
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.image.imagesdestination,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Product Story: ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'ABOUT THE ARTIST',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.image.imagescaption,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
            ),*/
          ],
        ))));
  }

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
}
