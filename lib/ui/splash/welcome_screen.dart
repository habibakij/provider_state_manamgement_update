
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../utility/common.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Common.dynamicScreenSize(context);
    return Scaffold(
      body: Container(
        width: Common.mediaQueryWidth,
        height: Common.mediaQueryHeight,
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
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                height: Common.mediaQueryHeight * .32,
                margin: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Row(
                      children: [

                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Welcome",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Image.asset(
                            "images/wave.jpg",
                            height: 30,
                            width: 30,
                            color: Colors.amber,
                          ),
                        ),

                      ],
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        "If you are already a Boost Home services",
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        "account enter your email below",
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).orientation == Orientation.portrait ?
                Common.mediaQueryHeight * .39 : 210,
                alignment: Alignment.center,
                child: Image.asset(
                  "images/boostlogo.png",
                  height: 150,
                  width: 200,
                  color: Colors.white,
                ),
              ),

              Container(
                height: Common.mediaQueryHeight * .25,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        //minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Continue With Email",
                          style: GoogleFonts.raleway(textStyle: Common.testStyleBlackBold16,),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                    ),

                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        child: Text(
                          "Don't have an account? Register",
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.pushReplacementNamed(context, '/registration');
                        },
                      ),
                    ),

                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
