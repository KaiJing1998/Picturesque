import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:picturesque/addscreen.dart';
import 'package:picturesque/mainscreen.dart';
import 'package:picturesque/searchscreen.dart';
import 'package:picturesque/user.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);
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
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
        title: Text('Profile'),
      ),
      body: Stack(children: <Widget>[
        _buildTopHalf(),
        //_buildBottomHalf(),
      ]),
    );
  }

  Widget _buildTopHalf() {
    return Stack(
      children: <Widget>[
        Container(
          width: width,
          height: height / 1.65,
          child: CachedNetworkImage(
              /*imageUrl:
                    "https://techvestigate.com/picturesque/image/Profile/${widget.user.image}.jpg"
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ProfileScreen.
                        )
                      )*/

              ),
        ),
      ],
    );
  }
}
