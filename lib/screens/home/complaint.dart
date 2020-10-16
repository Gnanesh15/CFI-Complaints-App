import 'dart:io';
import 'dart:ui';
import 'package:cfi_complaints/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cfi_complaints/models/cfi_user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cfi_complaints/constants.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class Complaint extends StatefulWidget {
  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  final _formkey = GlobalKey<FormState>();
  String errorLast = '';
  Map<String, String> _paths;
  String _extension;
  FileType _pickType = FileType.image;
  List<StorageUploadTask> _tasks = <StorageUploadTask>[];
  String sub = '';
  int i = 1;
  DatabaseReference itemRef;
  List<Subject> items = List(); // list of subject objects
  List<String> myfilename = List();
  List<String> myfilepath = List();
  //List<String> urls = [];
  Subject item; // object from Subject class
  bool mySubmit = false;
  String finalFilenames = '';
  String finalFilepaths = '';
  //String finalUrls = '';
  bool hasUploaded = false;
  //String url;

  // DatabaseReference database1 =
  //     FirebaseDatabase.instance.reference().child('counter');

  Future<void> loadAssets() async {
    String error;
    try {
      _paths = await FilePicker.getMultiFilePath(type: _pickType);
      mySubmit = true;
      if (_paths != null) {
        hasUploaded = true;
      }
      // resultList = await MultiImagePicker.pickImages(
      // maxImages: 300,
      // enableCamera: true,
    } on PlatformException catch (e) {
      error = e.toString();
      print('Unsupported Format ' + error);
    } on Exception catch (e) {
      error = e.toString();
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  Future finalSubmit(CfiUser user) async {
    print("The total paths are ");
    print(_paths.length);
    _paths.forEach((filename, filepath) async {
      myfilename.add(filename);
      myfilepath.add(filepath);
      print("filename = " + filename);
      print("filepath = " + filepath);
      await upload(filename, filepath, user);
    });
  }

  Future upload(filename, filepath, user) async {
    _extension = filename.toString().split('.').last;
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(filename);
    final StorageUploadTask uploadTask = storageReference.putFile(
        File(filepath),
        StorageMetadata(
          contentType: '$_pickType/$_extension',
        ));
    setState(() {
      _tasks.add(uploadTask);
    });
    // final String imageUrl =
    //     await (await uploadTask.onComplete).ref.getDownloadURL();
    // // url = imageUrl.toString();
    // urls.add(imageUrl);
    // // print("urls are - ");
    // print(urls);
  }

  Future uploadToDatabase(user) async {
    // print("Filename - ");
    // print(myfilename);
    // print("Filepaths");
    // print(myfilepath);
    for (i = 0; i < myfilename.length; i++) {
      finalFilenames = finalFilenames + myfilename[i];
      finalFilepaths = finalFilepaths + myfilepath[i];
      if (i < myfilename.length - 1) {
        finalFilenames = finalFilenames + " , ";
        finalFilepaths = finalFilepaths + " , ";
      }
    }
    final DatabaseReference database =
        FirebaseDatabase.instance.reference().child("User's uid : " + user.uid);
    await database.push().set({
      'uid of user': user.uid,
      'subject': sub,
      'image names': finalFilenames,
      'image paths': finalFilepaths,
    });
  }
  // if (mounted) {
  //   database.onChildAdded.listen((event) {
  //     setState(() {
  //       items.add(Subject.fromSnapshot(event.snapshot));
  //     });
  //   });
  // }

  // itemRef = database.reference().child('items');
  // handleSubmit();
  // itemRef.onChildAdded.listen(_onEntryAdded);

  // _onEntryAdded(Event event) {
  //   setState(() {
  //     items.add(Subject.fromSnapshot(event.snapshot));
  //   });
  // }

  // void handleSubmit() {
  //   final FormState form = _formkey.currentState;
  //   form.save();
  //   // form.reset();
  //   itemRef.push().set(item.toJson());
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CfiUser>(context);
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: Text('Create a new complaint'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Make a title of complaint'),
                  validator: (val) =>
                      val.isEmpty ? 'title should not be empty' : null,
                  onChanged: (val) {
                    setState(() => sub = val);
                  }),
              SizedBox(height: 10.0),
              RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'Upload images',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    await loadAssets();
                    if (hasUploaded == false) {
                      setState(() {
                        errorLast = 'Please upload atleast 1 image';
                      });
                    } else {
                      setState(() {
                        errorLast =
                            'Images succesfully uploaded. Click on submit';
                      });
                    }
                  }),
              SizedBox(height: 10.0),
              // Expanded(
              //   child: buildGridView(),
              // ),
              RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      if (mySubmit == false) {
                        setState(() {
                          errorLast = 'Please upload atleast 1 image';
                        });
                        // return null;
                      } else {
                        await finalSubmit(user);
                        await uploadToDatabase(user);
                        Navigator.pop(context);
                      }
                    }
                  }),
              SizedBox(height: 10.0),
              Text(
                errorLast,
                style: TextStyle(color: Colors.red[900], fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// List<Asset> images = List<Asset>();
// Widget buildGridView() {
//   if (images != null)
//     return GridView.count(
//       crossAxisCount: 3,
//       children: List.generate(images.length, (index) {
//         Asset asset = images[index];
//         return AssetThumb(
//           asset: asset,
//           width: 300,
//           height: 300,
//         );
//       }),
//     );
//   else
//     return Container(color: Colors.white);
// }
