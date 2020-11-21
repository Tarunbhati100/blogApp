import 'package:blog_app/Services/database.dart';
import 'package:blog_app/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

bool isempty;
final _firestore = DatabaseServices();

class DraggableList extends StatefulWidget {
  @override
  _DraggableListState createState() => _DraggableListState();
}

class _DraggableListState extends State<DraggableList> {
  @override
  Widget build(BuildContext context) {
    final List<Blog> blogdata = Provider.of<List<Blog>>(context) ?? [];
    setState(() {
      isempty = blogdata.length == 0 ? true : false;
    });
    return DraggableScrollableSheet(
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
                              key: Key(item.id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (dir) async {
                                setState(() {
                                  blogdata.removeAt(index);
                                });
                                await _firestore.deleteData(item.id);
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Deleted Successfully")));
                              },
                              confirmDismiss: (dir) {
                                return showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: Text("Are Your Sure"),
                                        content: Text(
                                            "Do you want to remove the Card"),
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
                                              Navigator.of(context).pop((true));
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
                                id: item.id,
                                title: item.title,
                                content: item.data,
                              ),
                            );
                          })),
              ));
        });
  }
}
