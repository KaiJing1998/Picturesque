import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:picturesque/addscreen.dart';
import 'package:picturesque/mainscreen.dart';
import 'package:picturesque/profilescreen.dart';

void main() => runApp(SearchScreen());

class SearchScreen extends StatefulWidget {
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
      body: Center(
        child: Container(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
