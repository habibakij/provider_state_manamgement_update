import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    hintText: hintText,
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

final loading = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: const <Widget>[
    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
    Text(" Loading... please wait", style: TextStyle(color: Colors.white))
  ],
);

customToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.blue[900],
    textColor: Colors.white,
    fontSize: 14,
  );
}