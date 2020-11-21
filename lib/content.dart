import 'package:blog_app/Screens/update.dart';
import 'package:blog_app/Services/auth.dart';
import 'package:blog_app/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Blog {
  String title;
  String data;
  String id;
  Blog({this.id,this.title, this.data});
}

class Blogwidget extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  Blogwidget({this.id, this.content, this.title});
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
                          id: id, title: title, content: content)));
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
  String id;
  String title;
  String content;
  final _auth = AuthServices();
  final DatabaseServices _firestore = DatabaseServices();
  Add_Update(this.id, this.title, this.content);

  @override
  Widget build(BuildContext context) {
    // print(content);
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
                      if (title != null && content != null) 
                      if (id == null) {
                        _firestore.addData(title,content,_auth.getCurrentUser().email);
                      } else {
                        _firestore.updateUserData(id,title,content);
                        // blogdata[index].title = title;
                        // blogdata[index].data = content;
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
