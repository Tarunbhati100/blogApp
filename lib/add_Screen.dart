import 'package:blog_app/content.dart';
import 'package:flutter/material.dart';

int index;
String title;
String content;

class AddScreen extends StatelessWidget {
static final String addScreen = 'AddScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text("ADD DATA"),
        backgroundColor: Colors.teal,
      ),
      body: Add_Update(index,title,content),
    );
  }
}