import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reminder_app/soc_icons_icons.dart';
import '../Functionality/conditional_builder.dart';
import 'package:reminder_app/Functionality/auth.dart';
import 'package:reminder_app/Shared/Loading.dart';
import 'sign_up.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class login_page extends StatefulWidget {
  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  String email;
  String password;
  bool emailValid;
  final AuthService _auth = AuthService();
  bool loading = false;
  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Sign_Up()));
  }

  void _signInFacebook() async {
    FacebookLogin facebookLogin = FacebookLogin();

    final result = await facebookLogin.logIn(['email', 'public_profile']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name&access_token=${token}');
    print(graphResponse.body);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final credential = FacebookAuthProvider.getCredential(accessToken: token);
      FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  final _googleSignIn = GoogleSignIn();
  void _loginWithGoogle() async {
    final googleAccount = await _googleSignIn.signIn();
    final googleAuth = await googleAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Reminders',
                      style: TextStyle(
                        fontFamily: 'Dancing Script',
                        color: Colors.amber,
                        fontSize: 80,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
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
                  Container(
                    padding: EdgeInsets.only(top: 13),
                    alignment: Alignment.center,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 120,
                            child: FlatButton(
                              padding: EdgeInsets.all(10),
                              color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                  side: BorderSide(color: Colors.amber)),
                              onPressed: () {},
                              textColor: Colors.white,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 120,
                            child: FlatButton(
                              padding: EdgeInsets.all(10),
                              color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                  side: BorderSide(color: Colors.amber)),
                              onPressed: () {
                                navigateToSubPage(context);
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
                        ]),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(top: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton(
                            onPressed: () {
                              _loginWithGoogle();
                            },
                            child: Image.asset('images/google.png')),
                        SizedBox(
                          width: 18,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            _signInFacebook();
                          },
                          backgroundColor: Hexcolor("#4267B2"),
                          child: Icon(
                            SocIcons.facebook,
                          ),
                        ),
                        // SizedBox(
                        //   width: 18,
                        // ),
                        // FloatingActionButton(
                        //   onPressed: null,
                        //   backgroundColor: Colors.white,
                        //   child: Icon(
                        //     SocIcons.apple,
                        //     color: Colors.black,
                        //     size: 25,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: FlatButton(
                      color: Colors.black,
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          print('Error signing in');
                          setState(() {
                            loading = false;
                          });
                        } else {
                          print('Signed in');
                          print(result.uid);
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: Text(
                        'Continue Without Signing in >>',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: Colors.amber,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 40),
                  )
                ],
              ),
            ),
          );
  }
}
