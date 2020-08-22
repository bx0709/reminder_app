import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder_app/Models/Reminders.dart';

class DatabaseService {

  final String uid;
  final CollectionReference userCollection = Firestore.instance.collection('Users');
  DocumentReference userDocumentReference;
  CollectionReference remindersCollection;

  DatabaseService({ this.uid }){
    userDocumentReference = userCollection.document(uid);
    remindersCollection = userDocumentReference.collection("Reminders");
  }

  // Adding new data
  Future addData({String title, String notes, DateTime dateTime,bool allDay, bool email}) async{
    DocumentReference docRef = remindersCollection.document();
    return docRef.setData({
      'title': title,
      'notes': notes,
      'dateTime': dateTime,
      'allDay': allDay,
      'email': email,
      'reminderUid': docRef.documentID,
    });
  }
  // Deleting data
  void deleteData(Reminder r) async {
    await remindersCollection.document(r.reminderUid).delete();
  }

  //Reminder list from snapshots
  List<Reminder> _reminderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Reminder(
        title: doc.data['title']??'' ,
        notes: doc.data['notes']??'' ,
        dateTime: doc.data['dateTime'] ?? null,
        allDay: doc.data['allDay']?? false,
        email: doc.data['email']?? false,
        reminderUid: doc.data['reminderUid']?? '',
      );
    }).toList();
  }

  Stream<List<Reminder>> get reminders {
    return remindersCollection.snapshots()
      .map(_reminderListFromSnapshot);
  }
}