// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Pages/Reminders.dart';
import 'Pages/Add_Reminder.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Reminders(),
      '/add_reminder': (context) => Add_Reminder(),

    },
  ));
}
