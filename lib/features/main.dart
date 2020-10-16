import 'package:flutter/material.dart';
import 'package:cfi_complaints/wrapper.dart';
import 'package:cfi_complaints/screens/authenticate/auth.dart';
import 'models/cfi_user.dart';
import 'package:provider/provider.dart';

// import 'package:cfi_complaints/screens/authenticate/authenticate.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CfiUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
