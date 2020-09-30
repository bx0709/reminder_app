import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reminder_app/Functionality/auth.dart';
import 'package:reminder_app/Functionality/Database.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/Models/Reminders.dart';
import 'package:reminder_app/Pages/Home/Active_Reminders.dart';
import 'package:reminder_app/Pages/Home/Completed_Reminders.dart';

class reminders_Home extends StatefulWidget {
  @override
  _ReminderAppState createState() => _ReminderAppState();
}

class _ReminderAppState extends State<reminders_Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return StreamProvider<List<Reminder>>.value(
      value: DatabaseService().reminders,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.amber,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.amber),
                ),
                onPressed: () async {
                  await _auth.signOut();
                })
          ],
          title: Text(
            'Reminders',
            style: TextStyle(
              fontSize: 25,
              //fontFamily: 'Bebas Neue',
              color: Colors.amber,
            ),
          ),
          titleSpacing: 20,
        ),

        body: _selectedIndex == 0 ? ActiveReminders(): CompletedReminders(),
        //body: ActiveReminders(),

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active), title: Text('')),
            BottomNavigationBarItem(icon: Icon(Icons.done_all), title: Text(''))
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.black,
          iconSize: 30,
          unselectedItemColor: Colors.grey[800],
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.pushNamed(context, '/add_reminder');
          },
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.add,
            size: 33,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
