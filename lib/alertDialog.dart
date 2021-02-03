import 'package:flutter/material.dart';

class AdvanceCustomAlert extends StatefulWidget {
  @override
  _AdvanceCustomAlertState createState() => _AdvanceCustomAlertState();
}

class _AdvanceCustomAlertState extends State<AdvanceCustomAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      'Warning !!! \n You Are Not Allowed to add Item. ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Please Pay for monthly subscriber.',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.redAccent,
                      child: Text(
                        'Pay',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 60,
                  child: Icon(
                    Icons.assistant_photo,
                    color: Colors.white,
                    size: 50,
                  ),
                )),
          ],
        ));
  }
}
