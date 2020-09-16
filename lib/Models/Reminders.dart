class Reminder{

  String title;
  String notes;
  DateTime dateTime;
  bool allDay;
  bool email;
  String reminderUid;
  bool isComplete;

  Reminder({this.title, this.notes, this.dateTime,this.allDay, this.email, this.reminderUid, this.isComplete});
}