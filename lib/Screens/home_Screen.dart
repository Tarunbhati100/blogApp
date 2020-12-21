import 'package:blog_app/DraggableList.dart';
import 'package:blog_app/Screens/add_Screen.dart';
import 'package:blog_app/Screens/auth_screen.dart';
import 'package:blog_app/Services/auth.dart';
import 'package:blog_app/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../content.dart';

class HomeScreen extends StatelessWidget {
  static final String home = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(child: Home()),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Blog>>.value(
      value: DatabaseServices().blogs,
      child: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.yellow,
            ),
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AuthScreen()));
            },
          ),
          title: Text(
            "BLOG APP",
            style: TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddScreen.addScreen);
              },
              icon: Icon(
                Icons.add,
                color: Colors.purple,
              ),
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: SvgPicture.asset("./assets/logo.svg"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                )
              ],
            ),
            DraggableList(),
          ],
        ),
      ),
    );
  }
}
