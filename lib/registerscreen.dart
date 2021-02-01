//import 'dart:html';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picturesque/user.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _password2controller = TextEditingController();

  String _username = "";
  String _email = "";
  String _password = "";
  File _images;
  String pathAsset = 'assets/images/addphoto.png';
  bool _passwordVisible = false;
  bool _password2Visible = false;
  bool _agree = false;
  bool _rememberMe = false;
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
            // appBar: AppBar(
            //backgroundColor: Colors.blueGrey[50],
            // title:
            //    Text('Register', style: TextStyle(color: Colors.grey[900])),
            // ),
            body: Center(
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                GestureDetector(
                    onTap: () => {_onPictureSelection()},
                    child: Container(
                      height: screenHeight / 3.2,
                      width: screenWidth / 1.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _images == null
                              ? AssetImage(pathAsset)
                              : FileImage(_images),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          width: 3.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(
                                5.0) //         <--- border radius here
                            ),
                      ),
                    )),
                SizedBox(height: 5),
                Text("Click image to take restaurant picture",
                    style: TextStyle(fontSize: 10.0, color: Colors.black)),
                SizedBox(height: 5),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'Register',
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
                      'Register',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                TextFormField(
                    controller: _usernamecontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your username';
                      }

                      return null;
                    },
                    onSaved: (String name) {
                      _username = name;
                    }),
                SizedBox(height: 10),
                TextFormField(
                    controller: _emailcontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter email';
                      }
                      if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                    onSaved: (String email) {
                      _email = email;
                    }),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          })),
                  obscureText: _passwordVisible,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _password2controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Comfirmation Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(
                            _password2Visible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _password2Visible = !_password2Visible;
                            });
                          })),
                  obscureText: _password2Visible,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter comfirmation password';
                    }
                    if (_passwordcontroller.text != _password2controller.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
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
                FormField<bool>(
                  builder: (state) {
                    return Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Checkbox(
                            value: _agree,
                            onChanged: (bool value) {
                              _onAgree(value);
                              state.didChange(value);
                            },
                          ),
                          Text("I have read and accept ",
                              style: TextStyle(fontSize: 16)),
                          GestureDetector(
                            onTap: _showAgreement,
                            child: Text('Terms and Conditions',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[200])),
                          ),
                        ]),
                        Text(
                          state.errorText ?? '',
                          style: TextStyle(
                            color: Theme.of(context).errorColor,
                          ),
                        )
                      ],
                    );
                  },
                  validator: (value) {
                    if (!_agree) {
                      return 'You need to accept Terms and Conditions';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  minWidth: 300,
                  height: 55,
                  child: Text('Register', style: TextStyle(fontSize: 19)),
                  color: Colors.cyan[600],
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onComfirmationDialog,
                ),
                SizedBox(height: 10),
                GestureDetector(
                    onTap: _onLogin,
                    child: Text('Already register',
                        style: TextStyle(fontSize: 16))),
              ]),
            ),
          )),
    )));
  }

  void _onRegister() async {
    _username = _usernamecontroller.text;
    _email = _emailcontroller.text;
    _password = _passwordcontroller.text;
    print(_username);
    final dateTime = DateTime.now();
    String base64Image = base64Encode(_images.readAsBytesSync());
    print(base64Image);

    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Registration...");
    await pr.show();

    http.post("https://techvestigate.com/picturesque/php/PHPMaker/index.php",
        // data that we need to pass
        body: {
          "name": _username,
          "email": _email,
          "password": _password,
          "encoded_string": base64Image,
          "imagename": _username + "-${dateTime.microsecondsSinceEpoch}",
          //return part, the server will request then respond of this echo (success/fail)
        }).then((res) {
      print(res.body);
      if (res.body == "Success") {
        Toast.show(
          "Registration Success, Please check your email to verify your email.",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );

        if (_rememberMe) {
          savepref();
        }
        _onLogin();
      } else {
        Toast.show(
          "Registration failed",
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

  void _onLogin() {
    User user = new User(
        username: _username,
        email: _email,
        password: _password,
        image: _images);
    print('Welcome to Picturesque ' + user.username);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen(user: user)));
  }

  void savepref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = _emailcontroller.text;
    _password = _passwordcontroller.text;
    await prefs.setString('email', _email);
    await prefs.setString('password', _password);
    await prefs.setBool('rememberMe', true);
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }

  void _onComfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Comfirmation"),
          content:
              new Text("Are you comfirm want to proceeds with registration?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                if (_formKey.currentState.validate()) {
                  //    If all data are correct then save data to out variables
                  _formKey.currentState.save();
                  _onRegister();
                }
              },
            ),

            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  void _onAgree(bool value) {
    setState(() {
      _agree = value;
    });
  }

  _onPictureSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            //backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: new Container(
              //color: Colors.white,
              height: screenHeight / 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Take picture from:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 80,
                        child: Text('Camera',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        //color: Color.fromRGBO(101, 255, 218, 50),
                        color: Colors.blueGrey,
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseCamera()},
                      )),
                      SizedBox(width: 10),
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 80,
                        child: Text('Gallery',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        //color: Color.fromRGBO(101, 255, 218, 50),
                        color: Colors.blueGrey[50],
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: () => {
                          Navigator.pop(context),
                          _chooseGallery(),
                        },
                      )),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _chooseCamera() async {
    // ignore: deprecated_member_use
    _images = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
    _cropImage();
    //update your image
    setState(() {});
  }

  void _chooseGallery() async {
    // ignore: deprecated_member_use
    _images = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    _cropImage();
    //update your image
    setState(() {});
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _images.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Resize',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      _images = croppedFile;
      setState(() {});
    }
  }

  void _showAgreement() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(
            child: Text("Terms & Conditions"),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('End-User License Agreement (EULA) of Picturesque',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(
                    'This End-User License Agreement ("EULA") is a legal agreement between you and Techvestigate. Our EULA was created by EULA Template for Picturesque.',
                    textAlign: TextAlign.justify),
                Text(
                    'This EULA agreement governs your acquisition and use of our Picturesque software ("Software") directly from Techvestigate or indirectly through a Techvestigate authorized reseller or distributor (a "Reseller"). Our Privacy Policy was created by the Privacy Policy Generator.',
                    textAlign: TextAlign.justify),
                Text(
                    'Please read this EULA agreement carefully before completing the installation process and using the Picturesque software. It provides a license to use the Picturesque software and contains warranty information and liability disclaimers.',
                    textAlign: TextAlign.justify),
                Text(
                    'If you register for a free trial of the Picturesque software, this EULA agreement will also govern that trial. By clicking "accept" or installing and/or using the Picturesque software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement.',
                    textAlign: TextAlign.justify),
                Text(
                    'If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.',
                    textAlign: TextAlign.justify),
                Text(
                    'This EULA agreement shall apply only to the Software supplied by Techvestigate herewith regardless of whether other software is referred to or described herein. The terms also apply to any Techvestigate updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply.',
                    textAlign: TextAlign.justify),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
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
