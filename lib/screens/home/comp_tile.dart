import 'package:cfi_complaints/models/subject.dart';
import 'package:flutter/material.dart';

class CompTile extends StatelessWidget {
  final Subject compMe;
  CompTile({this.compMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          // leading: CircleAvatar(
          //   radius: 25.0,
          //   backgroundColor: Colors.brown[brewMe.strength],
          //   backgroundImage: AssetImage('assets/coffee_icon.png'),
          // ),
          title: Text(compMe.subject),
        ),
      ),
    );
  }
}
