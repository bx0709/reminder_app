import 'package:flutter/material.dart';
import 'package:reminder_app/Functionality/auth.dart';
import 'package:reminder_app/Shared/Loading.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}
class _AuthenticationState extends State<Authentication> {

  final AuthService _auth = AuthService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Reminders',
          style: TextStyle(
            fontSize: 25,
            color: Colors.amber,
          ),
        ),
        titleSpacing: 20,
      ),
      body: Center(
        child: FlatButton(
          color: Colors.amber,
          textColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          onPressed: () async {
            setState(() {
              loading = true;
            });
            dynamic result =  await _auth.signInAnon();
            if(result == null) {
              print('Error signing in');
              setState(() {
               loading = false;
            });
            }
            else{
              print('Signed in');
              print(result.uid);
              setState(() {
              loading = false;
               });
            }
          },
          child: Text(
            "Anonymous login",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

