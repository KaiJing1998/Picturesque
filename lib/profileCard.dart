import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:picturesque/images.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class ProfileCard extends StatefulWidget {
  final String ownerEmail;
  final Images image;

  const ProfileCard({
    Key key,
    @required this.image,
    @required this.ownerEmail,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  double screenHeight, screenWidth;
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Card(
      child: InkWell(
        onLongPress: () => _onDeletePost(widget.image.imagesid.toString(),
            widget.image.imagesdestination.toString()),

        //onDoubleTap: () => _doubleTapped(),

        child: Column(
          children: [
            Stack(
              // doubleclickliked
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: screenHeight / 2.0,
                  width: screenWidth / 0.7,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://techvestigate.com/picturesque/image/${widget.image.imagescover}.jpg",
                    fit: BoxFit.fill,
                    placeholder: (context, url) => LoadingFlipping.circle(),
                    errorWidget: (context, url, error) => new Icon(
                      Icons.broken_image,
                      size: screenWidth / 3,
                    ),
                  ),
                ),
                /* showHeartOverlay
                                    ? Icon(Icons.favorite,
                                        color: Colors.white, size: 80.0)
                                    : Container()*/
              ],
            ),
            Container(
                //height: 0.,
                // width: screenWidth / 0.7,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  ListTile(
                      leading: IconButton(
                    icon: Icon(liked ? Icons.comment : Icons.article,
                        color: liked ? Colors.red : Colors.grey),
                    onPressed: () => _pressedliked(),
                  )),
                ])),
            SizedBox(height: 5),
            Align(
              child: Text(
                widget.image.imagesauthor + ' : ' + widget.image.imagescaption,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _pressedliked() {
    setState(() {
      liked = !liked;
    });
  }

  void _onDeletePost(String imagesid, String imagesdestination) {
    print("Cancel " + imagesid);
    _showDialog(imagesid, imagesdestination);
  }

  void _showDialog(String imagesid, String imagesdestination) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete Post"),
          content: new Text(
              "Are you sure you want to cancel selected accepted item?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                cancelItem(imagesid);
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

  Future<String> cancelItem(String itemid) async {
    String urlLoadItems =
        "https://techvestigate.com/picturesque/php/deletePost.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Canceling Post");
    await pr.show();
    http.post(urlLoadItems, body: {
      "imagesid": widget.image.imagesid,
    }).then((res) {
      print(res.body);
      if (res.body == "Deleted Successfully") {
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
    return null;
  }
}
