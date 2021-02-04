import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:picturesque/comment.dart';
import 'package:picturesque/images.dart';
import 'package:picturesque/user.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class CommentPage extends StatefulWidget {
  final Images image;
  final User user;
  final Comment comment;

  const CommentPage(
      {Key key,
      @required this.image,
      @required this.user,
      @required this.comment})
      : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List commentlist;
  String titlecenter = "No Comment";

  @override
  void initState() {
    super.initState();
    _loadComment();
  }

  Widget _buildCommentList() {
    commentlist == null
        ? Container()
        : ListView.builder(itemBuilder: (context, index) {
            if (index < commentlist.length) {
              return _buildCommentItem(commentlist[index]);
            }
          });
  }

  Widget _buildCommentItem(comments) {
    return ListTile(
        title: Text(comments['username']), subtitle: Text(comments['comment']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text('Comments', style: TextStyle(color: Colors.white))),
        body: Column(children: <Widget>[
          SizedBox(height: 5),
          /*Expanded(
              child: commentlist == null
                  ? _buildCommentList()
                  : SizedBox(height: 0)),*/
          Container(child: _buildCommentList()),
          Container(
              width: 50.0,
              height: 50.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 6.0),
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(
                          "https://techvestigate.com/picturesque/image/Profile/${widget.user.email}.jpg")))),
          Text(widget.user.username,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          TextField(
            onSubmitted: (String submittedString) {
              _onPost(submittedString);
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20.0),
                hintText: "Add a comment at here"),
          )
        ]));
  }

  void _addComment(String val) {
    setState(() {
      Comment newComment = new Comment(
          imagescover: widget.image.imagescover,
          username: widget.user.username,
          comment: val);
      commentlist.add(newComment);
    });
  }

  void _onPost(String submittedString) {
    http.post("https://techvestigate.com/picturesque/php/add_comment.php",
        body: {
          "commentusername": widget.user.username,
          "comment": submittedString,
          "imagecover": widget.image.imagescover,
          "time": DateTime.now().toString(),
        }).then((res) {
      print(res.body);
      if (res.body == "success") {
        print("Comment Success");
        _addComment(submittedString);
      } else {
        print("Comment Failed");
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadComment() {
    http.post("https://techvestigate.com/picturesque/php/load_comment.php",
        body: {
          "imagescover": widget.image.imagescover,
        }).then((res) {
      if (res.body == "nodata") {
        commentlist = null;
        setState(() {
          print(" No data");
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          commentlist = jsondata["comments"];
          print(commentlist.toString());
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
