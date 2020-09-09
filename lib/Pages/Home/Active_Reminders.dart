import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/Functionality/auth.dart';
import 'package:reminder_app/Models/Reminders.dart';
import 'package:reminder_app/Functionality/Database.dart';
import 'package:intl/intl.dart';



class ActiveReminders extends StatefulWidget {
  @override
  _ActiveRemindersState createState() => _ActiveRemindersState();
}

class _ActiveRemindersState extends State<ActiveReminders> {
  @override

  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();
    final remindersList = Provider.of<List<Reminder>>(context);

    if(remindersList != null)
      print(remindersList.length);

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      itemCount: remindersList == null ? 0 : remindersList.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
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
                setState(() async {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Reminder deleted")));
                   DatabaseService().deleteData(remindersList[index]);
                });

              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Reminder shifted to completed")));
                setState(() {
                  //reminder shifted from active to completed

                });
              }
            },
            child: ListTile(
              title: Text(remindersList[index].title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )),
              subtitle: remindersList[index].dateTime != null ?
              Text(DateFormat('dd-MM-yyyy \nkk:mm').format(remindersList[index].dateTime),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  )) : Text(''),
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
    );
  }
}
