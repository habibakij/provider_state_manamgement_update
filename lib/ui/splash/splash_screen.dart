
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

class SplashScreen extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    String token = "";
    checkAlreadyLogin(token);
    resetCash();
  }

  void resetCash() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("serviceCash", "");
    prefs.setString("selectedHome", "");
  }

  void checkAlreadyLogin(String token) async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("loginToken") ?? "";
    log("already_login_token: $token");
    if (token.isNotEmpty) {
      Timer(const Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, '/selectProperty'));
    } else {
      Timer(const Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, '/welcome'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [
              0.1,
              0.9,
            ],
            colors: [
              HexColor("#00639C"),
              HexColor("#00AFDE"),
            ],
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .55,
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "images/boostlogo.png",
              height: 150,
              width: 200,
              color: Colors.white,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .42,
            alignment: Alignment.center,
            child: Text(
              "Know Your Home",
              style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
