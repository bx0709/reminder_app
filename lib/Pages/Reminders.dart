import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../main.dart';

class Reminder {
  String msg;
  String time;
  bool enabled = true;
  Reminder(String msg, String time) {
    this.msg = msg;
    this.time = time;
  }
}

List<Reminder> reminders = <Reminder>[
  Reminder('Drink Water', '10:00 AM'),
  Reminder('Send email to 123@xyz.com', '11:00 PM'),
  Reminder('Bring Medicines', '1:00 PM'),
  Reminder('Heyyah!', '10:00 PM')
];

class Reminders extends StatefulWidget {
  @override
  _ReminderAppState createState() => _ReminderAppState();
}

class _ReminderAppState extends State<Reminders> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> body = <Widget>[
      ListView.builder(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              //                    <-- BoxDecoration
              border: Border(bottom: BorderSide(color: Colors.grey[800])),
            ),
            child: Dismissible(
              direction: DismissDirection.horizontal,
              background: Container(
                  color: Colors.grey[900],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.red,
                      ),
                    ],
                  )),
              secondaryBackground: Container(
                  color: Colors.grey[900],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.done,
                        size: 30,
                        color: Colors.green,
                      ),
                      SizedBox(width: 20),
                    ],
                  )),
              key: UniqueKey(),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  setState(() {
                    reminders.removeAt(index);
                  });
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Reminder deleted")));
                } else {
                  setState(() {
                    //reminder shifted from active to completed
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Reminder shifted to completed")));
                  });
                }
              },
              child: ListTile(
                title: Text(reminders[index].msg,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
                subtitle:
                    Text("${reminders[index].time} \n${reminders[index].time}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        )),
                //dense: true,
                isThreeLine: true,

                trailing: Icon(
                  Icons.notifications,
                  color: Colors.amber,
                  size: 30,
                ),
              ),
            ),
          );
        },
      ),
      ListView.builder(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              //                    <-- BoxDecoration
              border: Border(bottom: BorderSide(color: Colors.grey[800])),
            ),
            child: Dismissible(
              direction: DismissDirection.startToEnd,
              background: Container(
                  color: Colors.grey[900],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.red,
                      ),
                    ],
                  )),
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  reminders.removeAt(index);
                });
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Reminder deleted")));
              },
              child: ListTile(
                title: Text(reminders[index].msg,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
                subtitle:
                    Text("${reminders[index].time} \n${reminders[index].time}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        )),
                //dense: true,
                isThreeLine: true,

                trailing: Icon(
                  Icons.done,
                  color: Colors.amber,
                  size: 30,
                ),
              ),
            ),
          );
        },
      )
    ];

    return Scaffold(
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

      body: body[_selectedIndex],

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
        onPressed: () {
          Navigator.pushNamed(context, '/add_reminder');
        },
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.add,
          size: 33,
          color: Colors.black87,
        ),
      ),
    );
  }
}
