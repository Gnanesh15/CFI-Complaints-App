// import 'package:cfi_complaints/models/cfi_user.dart';
import 'package:cfi_complaints/models/subject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';

// NOTE: 1) Firestore changed to FirebaseFirestore
//       2) document changed to doc
//       3) setdata() changed to set()
// Brew class ---> Subject class

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
// collection reference
// adding new, reading, updating, deleting documents from..
// ..collections etc can be done by calling this 'CollectionReference'.
  final CollectionReference brewCollection =
      Firestore.instance.collection('complaints');

  Future updateUserData(String cfiId) async {
    //print("My uid = ");
    return await brewCollection.document(uid).setData({'cfiId': cfiId});
  }

  // Brew list from snapshot -- CHECKKKK
  List<Subject> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((e) {
      return Subject(
        cfiId: e.data['cfiId'] ?? '',
        subject: e.data['subject'] ?? '',
        filename: e.data['filename'] ?? '',
        filepath: e.data['filepath'] ?? '',
      );
    }).toList();
  }

  // List<Subject> _brewListFromSnapshot(DataSnapshot snapshot) {
  //   return
  // }
  // //get user data from snapshot
  // UserData userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //     uid: uid,
  //     name: snapshot.data['name'],
  //     sugars: snapshot.data['sugars'],
  //     strength: snapshot.data['strength'],
  //   );
  // }

  // // Get brews stream
  Stream<List<Subject>> get brewsSonu {
    return brewCollection
        .snapshots()
        .map(_brewListFromSnapshot); // built-in method
  }

  //  List<Subject> _fromSnapshot(DataSnapshot snapshot) {
  //   return snapshot.documents.map((e) {
  //     return Subject(
  //       cfiId: e.data['cfiId'] ?? '',
  //       subject: e.data['subject'] ?? '',
  //     );
  //   }).toList();
  // }
  // // get user doc stream
  // Stream<Subject> get compData {
  //   return brewCollection.document(uid).snapshots().map(_fromSnapshot);
  // }
}
