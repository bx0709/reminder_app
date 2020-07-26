import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Pages/Reminders.dart';

void main() {runApp(MaterialApp(
  routes: {
    '/': (context) => Reminders(),
  },
));
}


