import 'package:flutter/material.dart';
import 'package:picturesque/images.dart';
import 'package:picturesque/splashscreen.dart';
import 'package:picturesque/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SettingScreen extends StatefulWidget {
  final User user;
  final Images image;
  const SettingScreen({Key key, @required this.user, @required this.image})
      : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

final TextEditingController emailController = TextEditingController();

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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                Container(
                    width: 450,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.green[100]))),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20),
                        Icon(Icons.edit, color: Colors.green[900]),
                        SizedBox(width: 10),
                        Text("NAME",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                        SizedBox(width: 280),
                        new Container(
                          child: GestureDetector(
                            onTap: _changeName,
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        )
                      ],
                    )),
                SizedBox(height: 2.0),
                Container(
                    width: 450,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.green[100]))),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20),
                        Icon(Icons.edit, color: Colors.green[900]),
                        SizedBox(width: 10),
                        Text("PASSWORD",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                        SizedBox(width: 242),
                        new Container(
                          child: GestureDetector(
                            onTap: _changePassword,
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        )
                      ],
                    )),
                SizedBox(height: 2.0),
                Container(
                    width: 450,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.green[100]))),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20),
                        Icon(Icons.lock_open, color: Colors.green[900]),
                        SizedBox(width: 10),
                        Text("LOG OUT",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                        SizedBox(width: 260),
                        new Container(
                          child: GestureDetector(
                            onTap: _gotologout,
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        )
                      ],
                    )),
              ])),
        ),
      ),
    );
  }

  void _changeName() {}
  void _gotologout() async {
    // flutter defined function
    print(widget.user.username);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
              "Are you sure you want to log out? " + widget.user.username),
          //content: new Text("Are your sure?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () async {
                Navigator.of(context).pop();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('email', '');
                await prefs.setString('pass', '');
                print("LOGOUT");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SplashScreen()));
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void _changePassword() {
  /*TextEditingController passController = TextEditingController();
    // flutter defined function
    print(widget.user.username);
  
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change Password for " + widget.user.username),
          content: new TextField(
            controller: passController,
            decoration: InputDecoration(
              labelText: 'New Password',
              icon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                if (passController.text.length < 5) {
                  Toast.show("Password too short", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return;
                }
                http.post(urlupdate, body: {
                  "email": widget.user.email,
                  "password": passController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    print('in success');
                    setState(() {
                      widget.user.username = dres[1];
                      if (dres[0] == "success") {
                        Toast.show("Success", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        savepref(passController.text);
                        Navigator.of(context).pop();
                      }
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
                });
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void savepref(String pass) async {
    print('Inside savepref');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', pass);
  }*/
}
