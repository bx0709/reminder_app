import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference remindersCollection = Firestore.instance.collection('Reminders');

  Future addData({String title, String notes, DateTime dateTime,bool allDay, bool email}) async{
    return await remindersCollection.add({
      'title': title,
      'notes': notes,
      'dateTime': dateTime,
      'allDay': allDay,
      'email': email
    });


  }
}