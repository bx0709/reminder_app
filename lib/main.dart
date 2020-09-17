import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/Functionality/auth.dart';
import 'package:reminder_app/Models/user.dart';
import 'package:reminder_app/Pages/Wrapper.dart';
import 'package:reminder_app/Pages/edit_reminders.dart';
import 'Pages/Home/Reminders_Home.dart';
import 'Pages/Add_Reminder.dart';
import 'Models/user.dart';
import 'Pages/Wrapper.dart';
import 'Pages/login.dart';
import 'Pages/sign_up.dart';
import 'Pages/edit_reminders.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/*final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();*/
void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });*/
  runApp(Home());
}

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
          '/edit_reminder': (context) => Edit_Reminder(),
        },
      ),
    );
  }
}
