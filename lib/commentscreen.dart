import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:picturesque/comment.dart';
import 'package:picturesque/images.dart';
import 'package:picturesque/user.dart';
import 'package:http/http.dart' as http;

class CommentPage extends StatefulWidget {
  final Images image;
  final User user;

  const CommentPage({
    Key key,
    @required this.image,
    @required this.user,
  }) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> commentlist = [];
  String titlecenter = "No Comment";

  @override
  void initState() {
    super.initState();
    _loadComment();
  }

  List<Widget> _buildCommentList() {
    List<Widget> ws = [];

    for (Comment c in commentlist) {
      Widget tile = _buildCommentItem(c);
      setState(() {
        ws.add(tile);
      });
    }

    return ws;
  }

  Widget _buildCommentItem(Comment comment) {
    return ListTile(
        leading: Container(
            width: 50.0,
            height: 50.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 6.0),
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(
                        "https://techvestigate.com/picturesque/image/Profile/${comment.email}.jpg")))),
        title: Text(comment.username),
        subtitle: Text(comment.comment));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text('Comments', style: TextStyle(color: Colors.white))),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ..._buildCommentList(),
              TextField(
                onSubmitted: (String submittedString) {
                  _onPost(submittedString);
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    hintText: "Add a comment at here"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addComment(String val) {
    Comment newComment = new Comment(
      imagescover: widget.image.imagescover,
      username: widget.user.username,
      comment: val,
      email: widget.user.email,
    );
    setState(() {
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
        setState(() {
          commentlist = [];
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);

          for (dynamic v in jsondata["comments"]) {
            Comment c = new Comment(
              username: v['username'],
              imagescover: v['imagescover'],
              comment: v['comment'],
              email: v['email'],
            );

            commentlist.add(c);
          }
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
