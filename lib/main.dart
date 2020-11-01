import 'package:blog_app/add_Screen.dart';
import 'package:blog_app/auth_screen.dart';
import 'package:blog_app/home_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      routes: {
        '/' :(BuildContext context) => AuthScreen(),
        HomeScreen.home :(BuildContext context) => HomeScreen(),
        AddScreen.addScreen :(BuildContext context) => AddScreen(),      
      },
    );
  }
}