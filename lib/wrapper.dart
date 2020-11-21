import 'package:blog_app/Screens/auth_screen.dart';
import 'package:blog_app/Screens/home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
  final user = Provider.of<User>(context);
  // print(user);
    if(user == null){
      return AuthScreen();
    }else{
       return HomeScreen();
    }
  }
}