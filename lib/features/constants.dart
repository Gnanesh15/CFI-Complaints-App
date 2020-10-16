import 'package:flutter/material.dart';

// This is used in many areas as a decoration for the fields
const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.white,
      width: 1.0,
    )),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.redAccent,
      width: 1.0,
    )));
