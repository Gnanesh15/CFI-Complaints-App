import 'package:flutter/material.dart';
import 'package:cfi_complaints/screens/authenticate/register.dart';
import 'package:cfi_complaints/screens/authenticate/sign_in.dart';

// This file just helps to navigate or it decides to which file should
// we redirect - Sign in or Register.

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true; //bool that helps to switch b/w sign in & register
  // This function changes the state of showSignin
  void toggleView() {
    setState(() => showSignin = !showSignin);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin == true) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
