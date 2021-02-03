import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:picturesque/commentscreen.dart';
import 'package:picturesque/images.dart';
import 'package:picturesque/user.dart';

class ImageCard extends StatefulWidget {
  final String ownerEmail;
  final String user;

  final Images image;

  const ImageCard({
    Key key,
    @required this.image,
    @required this.ownerEmail,
    @required this.user,
  }) : super(key: key);
  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  double screenHeight, screenWidth;
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Card(
      child: InkWell(
        //we want to pass index because we want to deals it with restlist
        //onTap: () => _loadImagesDetail(index),

        //onDoubleTap: () => _doubleTapped(),

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(children: [
                Container(
                  width: screenHeight / 9.5,
                  height: screenWidth / 9.5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new NetworkImage(
                            "https://techvestigate.com/picturesque/image/Profile/${widget.ownerEmail}.jpg")),
                  ),
                ),
                Text(
                  widget.image.imagesauthor,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
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
                    children: <Widget>[
                  (ListTile(
                      leading: IconButton(
                    icon: Icon(liked ? Icons.comment : Icons.article,
                        color: liked ? Colors.red : Colors.grey),
                    onPressed: () => _commentButtonPressed(),
                  )))
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

  _commentButtonPressed() {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CommentPage(
                  ownerEmail: widget.ownerEmail,
                  image: widget.image,
                  user: widget.user)));
    });
  }

  /*_pressedliked() {
    setState(() {
      liked = !liked;
    });
  }*/
}
