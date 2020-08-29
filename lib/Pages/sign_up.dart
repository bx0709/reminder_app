import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reminder_app/soc_icons_icons.dart';
import '../Functionality/conditional_builder.dart';
import 'package:reminder_app/Functionality/auth.dart';
import 'package:reminder_app/Shared/Loading.dart';

class Sign_Up extends StatefulWidget {
  @override
  _Sign_UpState createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  String email;
  String password;
  bool emailValid;
  String Confirm_password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Reminders',
            style: TextStyle(
              fontSize: 70,
              fontFamily: 'Dancing Script',
              color: Colors.amber,
            ),
          ),
          titleSpacing: 20,
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                    child: Card(
                      shape: StadiumBorder(
                          side: BorderSide(
                        color: Colors.amber,
                        width: 1.0,
                      )),
                      margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                      color: Colors.transparent,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        minLines: 1,
                        autofocus: false,
                        obscureText: false,
                        enableInteractiveSelection: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 25),
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          focusColor: Colors.white,
                        ),
                        onChanged: (String str) {
                          setState(() {
                            password = str;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                    child: Card(
                      shape: StadiumBorder(
                          side: BorderSide(
                        color: Colors.amber,
                        width: 1.0,
                      )),
                      margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                      color: Colors.transparent,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        minLines: 1,
                        autofocus: false,
                        enableInteractiveSelection: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            focusColor: Colors.white,
                            contentPadding: EdgeInsets.only(left: 25)),
                        onChanged: (String str) {
                          setState(() {
                            email = str;
                            emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                    child: Card(
                      shape: StadiumBorder(
                          side: BorderSide(
                        color: Colors.amber,
                        width: 1.0,
                      )),
                      margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                      color: Colors.transparent,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        minLines: 1,
                        autofocus: false,
                        obscureText: true,
                        enableInteractiveSelection: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 25),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          focusColor: Colors.white,
                        ),
                        onChanged: (String str) {
                          setState(() {
                            password = str;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                    child: Card(
                      shape: StadiumBorder(
                          side: BorderSide(
                        color: Colors.amber,
                        width: 1.0,
                      )),
                      margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                      color: Colors.transparent,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        minLines: 1,
                        autofocus: false,
                        obscureText: true,
                        enableInteractiveSelection: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 25),
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          focusColor: Colors.white,
                        ),
                        onChanged: (String str) {
                          setState(() {
                            Confirm_password = str;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: FlatButton(
                      padding: EdgeInsets.all(10),
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          side: BorderSide(color: Colors.amber)),
                      onPressed: () {
                        print('Sign up');
                        Navigator.pushNamed(context, '/reminders_home');
                      },
                      textColor: Colors.white,
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}
