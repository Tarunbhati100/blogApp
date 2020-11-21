import 'package:blog_app/DraggableList.dart';
import 'package:blog_app/Screens/add_Screen.dart';
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
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async{
                        await _auth.signOut();
                      },
                      child: Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                        size: MediaQuery.of(context).size.width*0.2,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "Blog App",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AddScreen.addScreen);
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.limeAccent,
                        size: MediaQuery.of(context).size.width*0.15,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
              ),
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
    );
  }
}
