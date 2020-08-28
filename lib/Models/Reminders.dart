import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder{

  String title;
  String notes;
  DateTime dateTime;
  bool allDay;
  bool email;
  String reminderUid;

  Reminder({this.title, this.notes, this.dateTime,this.allDay, this.email, this.reminderUid});
}