import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picturesque/images.dart';
import 'package:picturesque/mainscreen.dart';
import 'package:toast/toast.dart';

void main() => runApp(AddScreen());

class AddScreen extends StatefulWidget {
  final Images images;

  const AddScreen({Key key, this.images}) : super(key: key);
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _destinationcontroller = TextEditingController();
  final TextEditingController _captioncontroller = TextEditingController();

  String _destination = "";
  String _caption = "";
  String selectedcategory = "Adventure";
  double screenHeight, screenWidth;
  String pathAsset = 'assets/images/addphoto.png';
  File _imagepost;

  List<String> collectionlist = [
    "Adventure",
    "Aerial",
    "Beautiful Game",
    "Black & White",
    "Cities",
    "Islands",
    "Mountain",
    "Nature",
    "Surf",
    "Underwater",
    "Urban",
    "Others"
  ];

  get http => null;
  @override
  void initState() {
    super.initState();
    selectedcategory = collectionlist[0];
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: _onClose,
          child: Icon(Icons.close),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('New Post', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
              padding: EdgeInsets.all(16.0),
              child: GestureDetector(
                  onTap: _onPost,
                  child: Text('Share',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)))),
        ],
      ),
      body: Center(
        child: Container(
            child: Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
          child: SingleChildScrollView(
            child: Column(children: [
              GestureDetector(
                  onTap: () => {_onPictureSelection()},
                  child: Container(
                    height: screenHeight / 3.2,
                    width: screenWidth / 1.8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        //Selection
                        image: _imagepost == null
                            ? AssetImage(pathAsset)
                            : FileImage(_imagepost),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        width: 3.0,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  )),
              SizedBox(height: 5),
              Text("Click image to create a new post",
                  style: TextStyle(fontSize: 10.0, color: Colors.black)),
              SizedBox(height: 50),
              TextField(
                controller: _destinationcontroller,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    FontAwesome.camera_retro,
                    color: Colors.black,
                  ),
                  labelText: 'Photo Destination',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _captioncontroller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    FontAwesome.comment_o,
                    color: Colors.black,
                  ),
                  labelText: 'Write a Caption...',
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    FontAwesome.quote_right,
                    color: Colors.black,
                  ),
                  SizedBox(width: 25),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 82.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1.0),
                    ),
                    alignment: Alignment.centerLeft,
                    height: 55,
                    //width: screenWidth / 1.4,
                    child: DropdownButton(
                      //sorting dropdownoption
                      hint: Text(
                        'Category',
                        style: TextStyle(
                          //color: Color.fromRGBO(101, 255, 218, 50),
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),

                      value: selectedcategory,
                      onChanged: (newValue) {
                        setState(() {
                          selectedcategory = newValue;
                          print(selectedcategory);
                        });
                      },
                      items: collectionlist.map((selectedcategory) {
                        return DropdownMenuItem(
                          child: new Text(selectedcategory,
                              style: TextStyle(color: Colors.black)),
                          value: selectedcategory,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        )),
      ),
    );
  }

  void _onClose() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
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
    _imagepost = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
    _cropImage();
    //update your image
    setState(() {});
  }

  void _chooseGallery() async {
    // ignore: deprecated_member_use
    _imagepost = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    _cropImage();
    //update your image
    setState(() {});
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _imagepost.path,
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
      _imagepost = croppedFile;
      setState(() {});
    }
  }

  void _onPost() {
    final dateTime = DateTime.now();
    _destination = _destinationcontroller.text;
    _caption = _captioncontroller.text;
    String base64Image = base64Encode(_imagepost.readAsBytesSync());

    http.post("https://slumberjer.com/foodninjav2/php/add_newfood.php", body: {
      "imagesdestination": _destination,
      "imagescaption": _caption,
      "encoded_string": base64Image,
      "imagescover":
          widget.images.imagesid + "-${dateTime.microsecondsSinceEpoch}",
      "imagesid": widget.images.imagesid,
    }).then((res) {
      print(res.body);
      if (res.body == "succes") {
        Toast.show(
          "Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        Navigator.pop(context);
      } else {
        Toast.show(
          "Failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
  }
}
