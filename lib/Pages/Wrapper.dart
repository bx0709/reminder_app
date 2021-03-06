import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/Models/user.dart';
import 'package:reminder_app/Pages/Home/Reminders_Home.dart';
import 'package:reminder_app/Functionality/Database.dart';
import 'login.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null)
      return login_page();
    else {
      DatabaseService().setupDatabase(user.uid);
      return reminders_Home();
    }
  }
}
