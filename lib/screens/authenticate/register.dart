import 'package:flutter/material.dart';
import 'package:cfi_complaints/screens/authenticate/auth.dart';
import 'package:cfi_complaints/constants.dart';
import 'package:cfi_complaints/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  // This is the link to firebase auth and us w.r.t 'form' that we use.
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  String error = '';

//   sendingUid(dynamic result) {
//     return result.uid;
//  }
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.purple[100],
            appBar: AppBar(
              backgroundColor: Colors.purple[400],
              elevation: 0.0,
              title: Text('Register to CFI App'),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Login'),
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 40.0),
                child: Form(
                    key: _formkey, // gives info abt any change in form fields
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
                                hintText: 'Create Password'),
                            validator: (val) => val.length < 7
                                ? 'Enter a password 8+ chars long'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => password = val);
                            }),
                        SizedBox(height: 15.0),
                        RaisedButton(
                          color: Colors.red,
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            // We define our own validator for each form and use
                            // built in 'validate'.
                            if (_formkey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailandPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Email invalid/Already registered';
                                  loading = false;
                                });
                              } else {
                                print("The result is below");
                                print(result.uid);
                              }
                            }
                          },
                        ),
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
