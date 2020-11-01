import 'package:blog_app/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final _firestore = FirebaseFirestore.instance;

List<Blog> blogdata = [];

class Blog {
  String title;
  String data;
  Blog({this.title, this.data});
}

class Blogwidget extends StatelessWidget {
  final int index;
  final String title;
  final String content;
  Blogwidget({this.index, this.content, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => UpdateScreen(
                          index: index, title: title, content: content)));
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class Add_Update extends StatelessWidget {
  int index;
  String title;
  String content;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  Add_Update(this.index, this.title, this.content);

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(content);
    getCurrentUser();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50, top: 20),
                    child: TextFormField(
                      initialValue: title,
                      decoration: InputDecoration(
                        hintText: "Enter Title",
                        labelText: "Enter Title",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.teal,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (text) {
                        title = text;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: TextFormField(
                      initialValue: content,
                      maxLines: 8,
                      maxLength: 1000,
                      decoration: InputDecoration(
                        hintText: "Enter Content",
                        labelText: "Enter Content",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.teal,
                              style: BorderStyle.solid,
                              width: 2),
                        ),
                      ),
                      onChanged: (text) {
                        content = text;
                      },
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (title != null && content != null) if (index == null) {
                        blogdata.add(Blog(
                          title: title,
                          data: content,
                        ));
                        _firestore.collection('blogs').add({
                          'title': title,
                          'data': content,
                          'sender': loggedInUser.email
                        });
                      } else {
                        blogdata[index].title = title;
                        blogdata[index].data = content;
                      }
                      Navigator.of(context).pop();
                    },
                    color: Colors.blue,
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(fontSize: 20),
                    ),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: SvgPicture.asset("./assets/typewriter.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
