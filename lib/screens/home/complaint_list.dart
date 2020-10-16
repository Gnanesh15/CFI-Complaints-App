import 'package:cfi_complaints/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'comp_tile.dart';

class ComplaintList extends StatefulWidget {
  @override
  _ComplaintListState createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  @override
  Widget build(BuildContext context) {
    final comps = Provider.of<List<Subject>>(context) ?? [];
    return ListView.builder(
      itemCount: comps.length,
      itemBuilder: (context, index) {
        return CompTile(compMe: comps[index]);
      },
    );
  }
}
