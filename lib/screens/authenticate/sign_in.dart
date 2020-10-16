import 'package:flutter/material.dart';
import 'package:cfi_complaints/screens/authenticate/auth.dart';
import 'package:cfi_complaints/constants.dart';
import 'package:cfi_complaints/loading.dart';

// This is the screen for sign-in. This has 2 fields - email
// and password. User gives this data and clicks on sign in.
// If the credentials match, user will be redirected to home
// screen via loading screen.

class SignIn extends StatefulWidget {
  // This is a constructor - takes toggleView function
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading // Ternary operator to switch b/w loading and sig in
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green[100],
            appBar: AppBar(
              backgroundColor: Colors.green[400],
              // elevation: 0.0,
              title: Text('Login to CFI App'),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 40.0),
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15.0),
                        TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                        SizedBox(height: 18.0),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (val) => val.isEmpty
                                ? 'Minimum length of password is 8 chars.'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => password = val);
                            }),
                        SizedBox(height: 15.0),
                        RaisedButton(
                            color: Colors.red,
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithEmailandPassword(
                                        email, password);

                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Could not sign in with those credentials';
                                    loading = false;
                                  });
                                }
                              }
                            }),
                        SizedBox(height: 6.0),
                        Text(
                          error,
                          style:
                              TextStyle(color: Colors.red[900], fontSize: 16.0),
                        ),
                      ],
                    ))),
          );
  }
}
