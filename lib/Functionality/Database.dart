import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/Models/Reminders.dart';

class DatabaseService {
  static String uid;
  static CollectionReference userCollection;

  void setupDatabase(String string){
    uid = string;
    userCollection = Firestore.instance.collection('UserID : ' + uid);
  }

  // Adding new data
  Future addData({String title, String notes, DateTime dateTime,bool allDay, bool email, bool isCompleted}) async{

    DocumentReference doc = userCollection.document();
    return doc.setData({
      'title': title,
      'notes': notes,
      'dateTime': dateTime,
      'allDay': allDay,
      'email': email,
      'reminderUid': doc.documentID,
      'isCompleted': isCompleted,
    });
  }

  //UpdateReminder
  Future updateData({Reminder reminder}) async{

    DocumentReference doc = userCollection.document(reminder.reminderUid);
    return doc.updateData({
      'title': reminder.title,
      'notes': reminder.notes,
      'dateTime': reminder.dateTime,
      'allDay': reminder.allDay,
      'email': reminder.email,
    });
  }

  //complete reminder
  Future completeReminder(Reminder r){
    return userCollection.document(r.reminderUid).updateData({'isCompleted' : true});
  }

  //active reminder
  Future activeReminder(Reminder r){
    return userCollection.document(r.reminderUid).updateData({'isCompleted' : false});
  }

  // Deleting data
  Future<void> deleteData(Reminder r) async {
    return await userCollection.document(r.reminderUid).delete();
  }

  //Reminder list from snapshots
  List<Reminder> _reminderListFromSnapshot(QuerySnapshot snapshot) {
    userCollection.orderBy("dateTime");

    print("`````````````````````````````````````````````````````````````````````");
    print(snapshot.documents.length);

    return snapshot.documents.map((doc){
      return Reminder(
        title: doc.data['title'] ?? '',
        notes: doc.data['notes'] ?? '',
        dateTime: doc.data['dateTime'] != null ? doc.data['dateTime'].toDate() : null,
        allDay: doc.data['allDay'] ?? false,
        email: doc.data['email'] ?? false,
        reminderUid: doc.data['reminderUid'] ?? '',
        isComplete: doc.data['isCompleted'] ?? false
      );
    }).toList();
  }

  Stream<List<Reminder>> get reminders {
    return userCollection != null ? userCollection.snapshots()
      .map(_reminderListFromSnapshot) : null;
  }
}