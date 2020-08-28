import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/Models/Reminders.dart';

class DatabaseService {

  final String uid = '123456';
  CollectionReference userCollection;

  DatabaseService(){
   userCollection = Firestore.instance.collection('UserID : ' + uid);
  }

  // Adding new data
  Future addData({String title, String notes, DateTime dateTime,bool allDay, bool email}) async{
    return userCollection.document().setData({
      'title': title,
      'notes': notes,
      'dateTime': dateTime,
      'allDay': allDay,
      'email': email,
      'reminderUid': userCollection.document().documentID,
    });
  }
  // Deleting data
  void deleteData(Reminder r) async {
    await userCollection.document(r.reminderUid).delete();
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
        dateTime: doc.data['dateTime'].toDate() ?? null,
        allDay: doc.data['allDay'] ?? false,
        email: doc.data['email'] ?? false,
        reminderUid: doc.data['reminderUid'] ?? ''
      );
    }).toList();
  }

  Stream<List<Reminder>> get reminders {
    return userCollection.snapshots()
      .map(_reminderListFromSnapshot);
  }
}