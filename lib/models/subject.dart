import 'package:firebase_database/firebase_database.dart';

class Subject {
  String subject;
  String cfiId;
  String filename;
  String filepath;
  Subject({this.subject, this.cfiId, this.filename, this.filepath});

  Subject.fromSnapshot(DataSnapshot snapshot)
      : cfiId = snapshot.key,
        subject = snapshot.value['subject'],
        filename = snapshot.value['filename'],
        filepath = snapshot.value['filepath'];

  // toJson() {
  //   return {"subject": subject, "filename": filename, "filepath": filepath};
  // }
}
