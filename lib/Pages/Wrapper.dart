import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/Models/user.dart';
import 'package:reminder_app/Pages/Authentication.dart';
import 'file:///C:/Users/daksh/Desktop/Work/Android_studio/reminder_app/lib/Pages/Home/Reminders_Home.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    if(user == null)
      return Authentication();
    else
      return reminders_Home();
  }
}
