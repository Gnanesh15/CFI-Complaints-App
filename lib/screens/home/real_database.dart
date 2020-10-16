import 'package:cfi_complaints/models/cfi_user.dart';
import 'package:cfi_complaints/models/subject.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RealDatabase extends StatefulWidget {
  // final String uid;
  // RealDatabase({this.uid});
  @override
  _RealDatabaseState createState() => _RealDatabaseState();
}

class _RealDatabaseState extends State<RealDatabase> {
  List<Subject> items = List();
  Subject item;
  DatabaseReference itemRef;
  // final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    item = Subject();
    final FirebaseDatabase database = FirebaseDatabase();
    itemRef = database.reference().child('items');
  }

  Widget build(BuildContext context) {
    final user = Provider.of<CfiUser>(context);
    print("user from real Database");
    print(user.uid);
    return Container();
  }
}
