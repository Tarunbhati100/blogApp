import 'package:blog_app/Services/auth.dart';
import 'package:blog_app/Screens/home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AuthScreen extends StatefulWidget {
  static final String authscreen = 'authScreen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthServices _auth = AuthServices();
  bool isNew = false;
  bool isloading = false;
  String emailid;
  String password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Blog App',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      letterSpacing: 2),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Your Email Address",
                            labelText: "Your Email Address",
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.teal,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                          ),
                          onChanged: (email) {
                            emailid = email;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: isNew
                              ? (val) {
                                  if (val.length < 6) {
                                    return "Password must contain atleast 6 characters.";
                                  }
                                  return null;
                                }
                              : (val) => null,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            labelText: "Enter Password",
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.teal,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                          ),
                          onChanged: (pass) {
                            password = pass;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        isNew
                            ? TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                validator: (val) {
                                  if (val != password) {
                                    return "Passwords don't match";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Re-Enter Password",
                                  labelText: "Re-Enter Password",
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.teal,
                                        style: BorderStyle.solid,
                                        width: 2),
                                  ),
                                ),
                                onChanged: null,
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            RaisedButton(
                              onPressed: () async {
                                setState(() {
                                  isloading = true;
                                });
                                try {
                                  if (_formKey.currentState.validate()) {
                                    final newUser = isNew
                                        ? await _auth
                                            .registerWithEmailAndPassword(
                                                emailid, password)
                                        : await _auth
                                            .signInWithEmailAndPassword(
                                                emailid, password);
                                    if (newUser != null) {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              HomeScreen.home);
                                    }
                                  }
                                } catch (e) {
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text(e.code)));
                                } finally {
                                  setState(() {
                                    isloading = false;
                                  });
                                }
                              },
                              child: Text(
                                isNew ? 'SignUp' : 'Log In',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              color: Colors.blue,
                            ),
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  isNew = isNew ? false : true;
                                });
                              },
                              child: Text(isNew
                                  ? "Already Exist/SignIn"
                                  : "New User/SignUp"),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}