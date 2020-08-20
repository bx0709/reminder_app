import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/Functionality/auth.dart';
import 'package:reminder_app/Models/user.dart';
import 'package:reminder_app/Pages/Wrapper.dart';
import 'Pages/Reminders_Home.dart';
import 'Pages/Add_Reminder.dart';
import 'Models/user.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        routes: {
          '/': (context) => Wrapper(),
          '/reminders': (context) => Reminders(),
          '/add_reminder': (context) => Add_Reminder(),
        },
      ),
    );
  }
}
