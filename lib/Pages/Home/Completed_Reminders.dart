import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/Functionality/Database.dart';
import 'package:reminder_app/Models/Reminders.dart';
import 'package:intl/intl.dart';

class CompletedReminders extends StatefulWidget {
  @override
  _CompletedRemindersState createState() => _CompletedRemindersState();
}

class _CompletedRemindersState extends State<CompletedReminders> {
  @override
  Widget build(BuildContext context) {

    final remindersList = Provider.of<List<Reminder>>(context);

    if(remindersList != null)
      for(int i = 0; i < remindersList.length; i++)
        if(!remindersList[i].isComplete)
          remindersList.removeAt(i);

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
                  ])
            ),
            secondaryBackground: Container(
                color: Colors.grey[900],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.notifications_active,
                      size: 30,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 20),
                  ],
                )),
            key: UniqueKey(),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                DatabaseService().deleteData(remindersList[index]);
                setState(() {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Reminder deleted")));
                });
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Reminder shifted to active")));
                setState(() {
                  DatabaseService().activeReminder(remindersList[index]);
                });
              }
            },
            child: ListTile(
              title: Text(remindersList[index].title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )),
              subtitle:remindersList[index].dateTime != null ?
              Text(DateFormat('dd-MM-yyyy \nkk:mm').format(remindersList[index].dateTime),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  )) : Text(''),
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
    );
  }
}
