import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:picturesque/images.dart';
import 'package:picturesque/user.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class AdventureScreen extends StatefulWidget {
  final User user;
  const AdventureScreen({Key key, @required this.user}) : super(key: key);

  @override
  _AdventureScreenState createState() => _AdventureScreenState();
}

class _AdventureScreenState extends State<AdventureScreen> {
  double screenHeight, screenWidth;
  List imagesList;
  String titlecenter = "Loading Adventure Images...";
  GlobalKey<RefreshIndicatorState> refreshKey;
  bool liked = false;
  bool showHeartOverlay = false;

  @override
  void initState() {
    super.initState();
    _loadAdventure();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[100],
        title: Text('Collections : Adventure',
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
                    return Padding(
                      padding: EdgeInsets.all(0.5),
                      child: Card(
                        child: InkWell(
                          //we want to pass index because we want to deals it with restlist
                          //onTap: () => _loadImagesDetail(index),

                          //onDoubleTap: () => _doubleTapped(),

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
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: new NetworkImage(
                                                "https://techvestigate.com/picturesque/image/Profile/${imagesList[index]['imagesimage']}.jpg"))),
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
    ));
  }

  void _loadAdventure() {
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
              (element) => element['imagescollections'] != "Adventure");
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  /*_loadImagesDetail(int index) {
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
  }*/

  _pressedliked() {
    setState(() {
      liked = !liked;
    });
  }
}
