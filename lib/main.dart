import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/Functionality/auth.dart';
import 'package:reminder_app/Models/user.dart';
import 'package:reminder_app/Pages/Wrapper.dart';
import 'Pages/Home/Reminders_Home.dart';
import 'Pages/Add_Reminder.dart';
import 'Models/user.dart';
import 'Pages/Wrapper.dart';
import 'Pages/login.dart';
import 'Pages/sign_up.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        routes: {
          '/': (context) => Wrapper(),
          '/sign_up': (context) => Sign_Up(),
          '/reminders_home': (context) => reminders_Home(),
          '/add_reminder': (context) => Add_Reminder(),
        },
      ),
    );
  }
}
