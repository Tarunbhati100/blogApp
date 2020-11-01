import 'package:blog_app/add_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'content.dart';

bool isempty;

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
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

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
    setState(() {
      isempty = blogdata.length == 0 ? true : false;
    });
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Blog App",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _auth.signOut();
                      // Navigator.of(context).pushNamed('/');
                      Navigator.of(context).pushNamed(AddScreen.addScreen);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.limeAccent,
                      size: 50,
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
        DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.45,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    // height:MediaQuery.of(context).size.height,
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.all(10),
                    child: Column(
                        children: isempty
                            ? <Widget>[SvgPicture.asset("./assets/No_data.svg")]
                            : List.generate(blogdata.length, (index) {
                                final item = blogdata[index];
                                return Dismissible(
                                  key: Key(item.title),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (dir) {
                                    setState(() {
                                      blogdata.removeAt(index);
                                    });
                                  },
                                  confirmDismiss: (dir) {
                                    return showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            title: Text("Are Your Sure"),
                                            content: Text(
                                                "Do you want to remove the Cart"),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop((false));
                                                },
                                                child: Text("No"),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop((true));
                                                },
                                                child: Text("Yes"),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    color: Colors.teal,
                                    child: Icon(
                                      Icons.delete,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Blogwidget(
                                    index: index,
                                    title: item.title,
                                    content: item.data,
                                  ),
                                );
                              })),
                  ));
            })
      ],
    );
  }
}
