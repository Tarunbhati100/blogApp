import 'package:blog_app/content.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  static final String updateScreen = 'UpdateScreen';

  UpdateScreen({this.id,this.title,this.content});
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text("UPDATE DATA"),
        backgroundColor: Colors.teal,
      ),
      body: Add_Update(id,title,content),
    );
  }
}