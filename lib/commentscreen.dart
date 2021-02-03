import 'package:flutter/material.dart';
import 'package:picturesque/images.dart';
import 'package:picturesque/user.dart';

class CommentPage extends StatefulWidget {
  final String ownerEmail;
  final Images image;
  final user;

  const CommentPage(
      {Key key,
      @required this.ownerEmail,
      @required this.image,
      @required this.user})
      : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<String> _comments = [];

  void _addComment(String val) {
    setState(() {
      _comments.add(val);
    });
  }

  Widget _buildCommentList() {
    return ListView.builder(itemBuilder: (context, index) {
      if (index < _comments.length) {
        return _buildCommentItem(_comments[index]);
      }
    });
  }

  Widget _buildCommentItem(String comments) {
    return ListTile(title: Text(comments));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Text('Comments', style: TextStyle(color: Colors.white))),
        body: Column(children: <Widget>[
          Container(
              width: 50.0,
              height: 50.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 6.0),
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(
                          "https://techvestigate.com/picturesque/image/Profile/${widget.ownerEmail}.jpg")))),
          SizedBox(height: 5),
          Expanded(child: _buildCommentList()),
          TextField(
            onSubmitted: (String submittedString) {
              _addComment(submittedString);
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20.0),
                hintText: "Add a comment at here"),
          )
        ]));
  }
}
