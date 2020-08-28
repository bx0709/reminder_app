import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/Functionality/Database.dart';
import 'package:reminder_app/Functionality/auth.dart';
import 'package:reminder_app/Models/Reminders.dart';
import 'package:intl/intl.dart';

class CompletedReminders extends StatefulWidget {
  @override
  _CompletedRemindersState createState() => _CompletedRemindersState();
}

class _CompletedRemindersState extends State<CompletedReminders> {
  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();
    final Reminders = Provider.of<List<Reminder>>(context);

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      itemCount: Reminders.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
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
              setState(() async {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Reminder deleted")));
                final user = await _auth.currentUser();
                DatabaseService().deleteData(Reminders[index]);
              });
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("Reminder deleted")));
            },
            child: ListTile(
              title: Text(Reminders[index].title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )),
              subtitle:
              Text(DateFormat('yyyy-MM-dd – kk:mm').format(Reminders[index].dateTime),
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
    );
  }
}
