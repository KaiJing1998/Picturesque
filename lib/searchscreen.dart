import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:picturesque/addscreen.dart';
import 'package:picturesque/Categories/adventurepage.dart';
import 'package:picturesque/Categories/citiesscreen.dart';
import 'package:picturesque/mainscreen.dart';
import 'package:picturesque/profilescreen.dart';
import 'package:picturesque/user.dart';

class SearchScreen extends StatefulWidget {
  final User user;
  const SearchScreen({Key key, @required this.user}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List imagesList;

  double screenHeight, screenWidth;
  String titlecenter = "Loading Images...";
  TextEditingController searchController = new TextEditingController();
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _searchcontroller = TextEditingController();
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
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          actions: <Widget>[
            Container(
              width: screenWidth / 1.4,
              padding: EdgeInsets.fromLTRB(0, 9, 9, 9),
              child: TextField(
                autofocus: false,
                controller: _searchcontroller,
                decoration: InputDecoration(
                  //hintText: 'Search',
                  filled: true,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),

                  labelText: 'Search',
                ),
              ),
            ),
            SizedBox(width: 5),
            Flexible(
              child: IconButton(
                icon: Icon(Icons.search),
                iconSize: 24,
                onPressed: () {
                  //_loadSearchPic(
                  //    selectedLoc, selectedRating, _foodnamecontroller.text);
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          height: 300,
                          width: 220,
                          child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              AdventureScreen(
                                                user: widget.user,
                                              )));
                                },
                                child: Image.asset(
                                  "assets/images/adventure.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ))),
                      Text(
                        "Adventure",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Stack(alignment: Alignment.center, children: [
                    Container(
                        height: 300,
                        width: 220,
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CitiesScreen(
                                              user: widget.user,
                                            )));
                              },
                              child: Image.asset(
                                "assets/images/cities.jpg",
                                fit: BoxFit.cover,
                              ),
                            ))),
                    Text(
                      "Cities",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  Stack(alignment: Alignment.center, children: [
                    Container(
                        height: 300,
                        width: 220,
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CitiesScreen(
                                              user: widget.user,
                                            )));
                              },
                              child: Image.asset(
                                "assets/images/aerial.jpg",
                                fit: BoxFit.cover,
                              ),
                            ))),
                    Text(
                      "Aerial",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  Stack(alignment: Alignment.center, children: [
                    Container(
                        height: 300,
                        width: 220,
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CitiesScreen(
                                              user: widget.user,
                                            )));
                              },
                              child: Image.asset(
                                "assets/images/beautifulGame.jpg",
                                fit: BoxFit.cover,
                              ),
                            ))),
                    Text(
                      "Beautiful Game",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  Stack(alignment: Alignment.center, children: [
                    Container(
                        height: 300,
                        width: 220,
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CitiesScreen(
                                              user: widget.user,
                                            )));
                              },
                              child: Image.asset(
                                "assets/images/islands.jpg",
                                fit: BoxFit.cover,
                              ),
                            ))),
                    Text(
                      "Islands",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  Stack(alignment: Alignment.center, children: [
                    Container(
                        height: 300,
                        width: 220,
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CitiesScreen(
                                              user: widget.user,
                                            )));
                              },
                              child: Image.asset(
                                "assets/images/mountain.jpg",
                                fit: BoxFit.cover,
                              ),
                            ))),
                    Text(
                      "Mountain",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  Stack(alignment: Alignment.center, children: [
                    Container(
                        height: 300,
                        width: 220,
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CitiesScreen(
                                              user: widget.user,
                                            )));
                              },
                              child: Image.asset(
                                "assets/images/underwater.jpg",
                                fit: BoxFit.cover,
                              ),
                            ))),
                    Text(
                      "Underwater",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ]))));
  }
}
