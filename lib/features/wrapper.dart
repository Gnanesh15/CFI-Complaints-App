import 'package:flutter/material.dart';
import 'package:cfi_complaints/screens/authenticate/authenticate.dart';
import 'package:cfi_complaints/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'models/cfi_user.dart';

// This file helps in redirecting to either authenticate or home screens
// depending on the correct login credentials

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CfiUser>(context);
    print(user);
    // Return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
