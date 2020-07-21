import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReminderApp extends StatefulWidget {

  @override
  _ReminderAppState createState() => _ReminderAppState();
}

class Reminder {
  String msg;
  String time;
  bool enabled = true;
  Reminder(String msg,String time){
    this.msg = msg;
    this.time = time;
  }
}
class _ReminderAppState extends State<ReminderApp> {

  Color onClickProcessText(bool enabled){
    return  enabled ? Colors.white : Colors.grey[600];
  }

  Color onClickProcessIcon(bool enabled){
    return  enabled ? Colors.amber : Colors.grey[600];
  }


  final List<Reminder> reminders = <Reminder> [Reminder('Drink Water','10:00 AM'),
    Reminder('Send email to 123@xyz.com', '11:00 PM'),
    Reminder('Bring Medicines','1:00 PM'),
    Reminder('Heyyah!', '10:00 PM')];

  @override
  Widget build(BuildContext context) {
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

      body: ListView.separated(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          itemCount: reminders.length,
          itemBuilder: (context, index){
            return Card(
              color: Colors.transparent,
              child: ListTile(
                title: Text(
                    reminders[index].msg,
                    style: TextStyle(
                      fontSize: 20,
                      color: onClickProcessText(reminders[index].enabled),
                    )
                ),
                subtitle: Text(
                    reminders[index].time,
                    style: TextStyle(
                      fontSize: 15,
                      color: onClickProcessText(reminders[index].enabled),
                    )
                ),
                dense: true,

                trailing: IconButton(
                  onPressed: (){setState(() {
                    reminders[index].enabled = reminders[index].enabled ? false : true ;
                  });
                  },
                  icon: Icon(
                    Icons.access_alarm,
                    color: onClickProcessIcon(reminders[index].enabled),
                    size: 30,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[200],width: 0.5),
              ),
            ),
          )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
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