import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'loginscreen.dart';

final TextEditingController _emcontroller = TextEditingController();
String _email = "";
String urlpw = "https://techvestigate.com/picturesque/php/forgetPassword.php";

class ForgotpwScreen extends StatefulWidget {
  @override
  _ForgotpwScreenState createState() => _ForgotpwScreenState();
}

class _ForgotpwScreenState extends State<ForgotpwScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Reset Password'),
          backgroundColor: Colors.blue[200],
        ),
        body: new Container(
          /*decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.PNG'),
                fit: BoxFit.cover),
          ),*/
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              TextField(
                  controller: _emcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.greenAccent[50],
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  )),
              SizedBox(height: 30),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minWidth: 300,
                height: 50,
                child: Text('Submit'),
                color: Colors.teal[900],
                textColor: Colors.white,
                elevation: 15,
                onPressed: _onSubmit,
              ),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: _onBackPress,
                  child: Text('Return to Sign In',
                      style: TextStyle(fontSize: 16, color: Colors.teal))),
            ],
          ),
        ),
      ),
    );
  }

  void _onBackPress() {
    print('onBackpress from Forgot Password');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
    return Future.value(false);
  }

  void _onSubmit() {
    _email = _emcontroller.text;
    if (_checkEmail(_email)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Sending link to your email.");
      pr.show();
      http.post(urlpw, body: {
        "email": _email,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        _emcontroller.text = '';
        pr.hide();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }).catchError((err) {
        pr.hide();
        print(err);
      });
    } else {}
  }

  bool _checkEmail(String email) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);
    return emailValid;
  }
}
