import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picturesque/mainscreen.dart';
import 'package:picturesque/user.dart';
import 'package:picturesque/registerscreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'forgotpw.dart';

class LoginScreen extends StatefulWidget {
  // final User user;
  //const LoginScreen({Key key, this.user}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  String _email = "";
  String _username = "";
  File _images;
  final TextEditingController _passwordcontroller = TextEditingController();
  String _password = "";
  bool _rememberMe = false;

  SharedPreferences prefs;

  @override
  void initState() {
    loadpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
        // appBar: AppBar(
        // backgroundColor: Colors.blueGrey[50],
        //  title: Text('Login', style: TextStyle(color: Colors.grey[900])),
        // ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/picturesqueLogo3.png',
                  scale: 1.85,
                ),
                SizedBox(height: 15),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.blueGrey[200],
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: _usernamecontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Username',
                    )),
                SizedBox(height: 8),
                TextField(
                    controller: _emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    )),
                SizedBox(height: 8),
                TextField(
                  controller: _passwordcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  minWidth: 300,
                  height: 55,
                  child: Text('Login', style: TextStyle(fontSize: 19)),
                  color: Colors.cyan[600],
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onLogin,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool value) {
                        _onChange(value);
                      },
                    ),
                    Text('Remember Me', style: TextStyle(fontSize: 16))
                  ],
                ),
                GestureDetector(
                    onTap: _onRegister,
                    child: Text('Register New Account',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: _onForgot,
                    child:
                        Text('Forgot Account', style: TextStyle(fontSize: 16))),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onLogin() async {
    _username = _usernamecontroller.text;
    _email = _emailcontroller.text;
    _password = _passwordcontroller.text;
    print(_username);

    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Login...");
    await pr.show();

    http.post("https://techvestigate.com/picturesque/php/login_user.php",
            // data that we need to pass
            body: {
          "username": _username,
          "email": _email,
          "password": _password,
          //return part, the server will request then respond of this echo (success/fail)
        })
        //wait for the response back from server
        .then((res) {
      //print from php success or not
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Login Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        User user = new User(
            username: _username,
            email: _email,
            password: _password,
            image: _images);

        print('hi ' + _username);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainScreen(
                      user: user,
                    )));
      } else {
        Toast.show(
          "Login Failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  void _onRegister() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
  }

  void _onForgot() {
    print('Forgot');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotpwScreen()));
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
      savepref(value);
    });
  }

  void loadpref() async {
    prefs = await SharedPreferences.getInstance();
    _username = (prefs.getString('username')) ?? '';
    _email = (prefs.getString('email')) ?? '';
    _password = (prefs.getString('password')) ?? '';
    _rememberMe = (prefs.getBool('rememberme')) ?? false;
    if (_email.isNotEmpty) {
      setState(() {
        _usernamecontroller.text = _username;
        _emailcontroller.text = _email;
        _passwordcontroller.text = _password;
        _rememberMe = _rememberMe;
      });
    }
  }

  void savepref(bool value) async {
    prefs = await SharedPreferences.getInstance();
    _username = _usernamecontroller.text;
    _email = _emailcontroller.text;
    _password = _passwordcontroller.text;

    if (value) {
      if (_email.length < 5 || _password.length < 5) {
        print("Email/Password Empty");
        _rememberMe = false;
        Toast.show(
          "Email/password empty!!!",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        return;
      } else {
        await prefs.setString("username", _username);
        await prefs.setString("email", _email);
        await prefs.setString("password", _password);
        await prefs.setBool("rememberme", value);
        Toast.show(
          "Preferences saved",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        print("SUCCESS");
      }
    } else {
      await prefs.setString("username", '');
      await prefs.setString("email", '');
      await prefs.setString("password", '');
      await prefs.setBool("rememberme", false);
      setState(() {
        _usernamecontroller.text = "";
        _emailcontroller.text = "";
        _passwordcontroller.text = "";
        _rememberMe = false;
      });
      Toast.show(
        "Preferences removed",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    }
  }

  Future<bool> _onBackPressAppBar() async {
    SystemNavigator.pop();
    print('Backpress');
    return Future.value(false);
  }
}
