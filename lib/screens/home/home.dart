import 'package:cfi_complaints/models/subject.dart';
import 'package:cfi_complaints/models/cfi_user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cfi_complaints/services/database.dart';
import 'package:cfi_complaints/screens/authenticate/auth.dart';
import 'complaint.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  List<Subject> itemlist = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CfiUser>(context);

    DatabaseReference itemRef =
        FirebaseDatabase.instance.reference().child("User's uid : " + user.uid);
    itemRef.once().then((DataSnapshot snapshot) {
      var kEYS = snapshot.value.keys;
      var dATA = snapshot.value;

      itemlist.clear(); // CHECK

      for (var individualKey in kEYS) {
        Subject subb = new Subject(
            cfiId: dATA[individualKey]['CfiId'],
            subject: dATA[individualKey]['subject'],
            filename: dATA[individualKey]['filename'],
            filepath: dATA[individualKey]['filepath']);
        itemlist.add(subb);
      }
      setState(() {
        // print('Length : $itemlist.length');
      });
    });
    return StreamProvider<List<Subject>>.value(
        value: DatabaseService().brewsSonu,
        child: Scaffold(
          backgroundColor: Colors.blue[100],
          appBar: AppBar(
            title: Text('My Complaints'),
            backgroundColor: Colors.blue[400],
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(Icons.person),
                  label: Text('logout')),
            ],
          ),
          body: Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('Assets/cfi.png'),
            //     fit: BoxFit.fitWidth,
            //   ),
            // ),
            child: itemlist.length == 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Complaints Registered',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Click on the  ',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'New',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  //backgroundColor: Colors.green,
                                  color: Colors.green),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              ' button to register ',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100.0,
                        ),
                        Column(
                          children: [
                            Text(
                              'NOTE: The registered complaints will be shown in this screen immediately. If it does not show up, Kindly wait for some time or login back again ',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: itemlist.length,
                    itemBuilder: (_, index) {
                      return postsUI(
                          itemlist[index].cfiId,
                          itemlist[index].subject,
                          itemlist[index].filename,
                          itemlist[index].filepath);
                    },
                  ),
          ),
          //child: RealDatabase()),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Complaint()),
              );
            },
            child: Text('New'),
            backgroundColor: Colors.green,
          ),
        ));
  }

  Widget postsUI(
      String cfiId, String subject, String filname, String filepath) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(7.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.amber[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Complaint ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    subject,
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
