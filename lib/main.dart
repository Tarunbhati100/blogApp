import 'package:blog_app/Screens/add_Screen.dart';
import 'package:blog_app/Screens/auth_screen.dart';
import 'package:blog_app/Screens/home_Screen.dart';
import 'package:blog_app/Services/auth.dart';
import 'package:blog_app/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
        title: 'Blog App',
        routes: {
          '/':(BuildContext context)=>Wrapper(),
          AuthScreen.authscreen: (BuildContext context) => AuthScreen(),
          HomeScreen.home: (BuildContext context) => HomeScreen(),
          AddScreen.addScreen: (BuildContext context) => AddScreen(),
        },),
    );
  }
}