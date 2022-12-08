
import 'dart:developer';
import 'package:boost_provider_state/provider/registration_provider.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../model/user_auth_model.dart';
import '../../utility/common.dart';
import '../../widget/button_widget.dart';
import '../../widget/widget_decoration.dart';

class RegistrationScreen extends StatelessWidget {

  TextEditingController nameController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  UserAuthModel registrationModel= UserAuthModel();

  @override
  Widget build(BuildContext context) {
    RegistrationProvider registrationProvider = Provider.of<RegistrationProvider>(context);
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

                    Container(
                      alignment: Alignment.bottomLeft,
                      height: 50,
                      child: Text(
                        "Home Owner",
                        style: GoogleFonts.raleway(textStyle: Common.testStyleWhite25,),
                      ),
                    ),

                    Container(
                      height: 50,
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Registration",
                        style: GoogleFonts.raleway(textStyle: Common.testStyleWhite25,),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: MediaQuery.of(context).orientation == Orientation.portrait ? Common.mediaQueryHeight * .39 : 195,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Common.fieldTitle18("User Name"),
                    Container(
                      height: 40,
                      width: Common.mediaQueryWidth,
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: nameController,
                        style: GoogleFonts.raleway(textStyle: Common.testStyleWhite16),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.white,
                          hintText: 'Jhon Deo',
                          hintStyle: TextStyle(fontSize: 18, color: Colors.white70),
                          suffixIcon: Icon(Icons.person, color: Colors.cyanAccent,),
                        ),

                      ),
                    ),
                    Container(height: 1,
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      color: Colors.white,
                    ),


                    const SizedBox(height: 20,),

                    Common.fieldTitle18("Email"),
                    Container(
                      height: 40,
                      width: Common.mediaQueryWidth,
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: emailController,
                        style: GoogleFonts.raleway(textStyle: Common.testStyleWhite16),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.white,
                          hintText: 'email@email.com',
                          hintStyle: TextStyle(fontSize: 18, color: Colors.white70),
                          suffixIcon: Icon(Icons.email, color: Colors.cyanAccent,),
                        ),
                      ),
                    ),
                    Container(height: 1,
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      color: Colors.white,
                    ),

                    const SizedBox(height: 20,),

                    Common.fieldTitle18("Password"),
                    Container(
                      height: 40,
                      width: Common.mediaQueryWidth,
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: registrationProvider.isVisiblePassword,
                        style: GoogleFonts.raleway(textStyle: Common.testStyleWhite16),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.white,
                          hintText: 'password',
                          hintStyle: const TextStyle(fontSize: 18, color: Colors.white70),
                          suffixIcon: IconButton(icon: Icon(!registrationProvider.isVisiblePassword ? Icons.visibility : Icons.visibility_off, color: Colors.cyanAccent),
                            onPressed: () {
                              registrationProvider.passwordVisibility(!registrationProvider.isVisiblePassword);
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(height: 1,
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).orientation == Orientation.portrait ? Common.mediaQueryHeight * .25 : 150,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      children: [

                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              MediaQuery.removePadding(
                                context: context,
                                removeLeft: true,
                                removeBottom: true,
                                removeRight: true,
                                removeTop: true,
                                child: CustomCheckBox(
                                  value: registrationProvider.rememberPasswordReg,
                                  splashColor: Colors.red.withOpacity(0.4),
                                  splashRadius: 40,
                                  checkedIconColor: Colors.blue,
                                  checkedFillColor: Colors.white,
                                  borderColor: Colors.white,
                                  uncheckedFillColor: Colors.transparent,
                                  uncheckedIconColor: Colors.transparent,
                                  shouldShowBorder: true,
                                  onChanged: (value) {
                                    registrationProvider.rememberPasswordStatusReg(value);
                                  },
                                ),
                              ),

                              Text(
                                "I accept the Terms & Conditions.",
                                style: GoogleFonts.raleway(textStyle: Common.testStyleWhite16),
                              ),
                            ],
                          ),
                        ),

                        registrationProvider.registrationStatus == Status.registering ? loading : ButtonWidget(
                          title: "Sign up",
                          color: Colors.white,
                          textColor: Colors.black,
                          onPress: () async {
                            if(nameController.text.toString().isEmpty){
                              Common.customToast("Enter User Name");
                            } else if(emailController.text.toString().isEmpty){
                              Common.customToast("Enter Email");
                            } else if(passwordController.text.toString().isEmpty){
                              Common.customToast("Enter Password");
                            } else if(passwordController.text.toString().length < 8) {
                              Common.customToast("Password at least 8 char long");
                            } else if(registrationProvider.rememberPasswordReg == false){
                              Common.customToast("Please accept terms and condition");
                            } else {
                              registrationModel= await registrationProvider.registration(nameController.text.toString(), emailController.text.toString(), passwordController.text.toString());
                              if(registrationProvider.registrationStatus == Status.registered){
                                customToast("Registration success");
                                Navigator.pushReplacementNamed(context, '/homePage');
                              } else if(registrationProvider.registrationStatus == Status.existingEmail){
                                customToast("Email already exists");
                              } else if(registrationProvider.registrationStatus == Status.internalError){
                                customToast("Internal error occur, Please try again");
                              } else if(registrationProvider.registrationStatus == Status.somethingWrong){
                                customToast("Somethings want wrong, Please try again");
                              }
                            }

                          },
                        ),

                      ],
                    ),

                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        child: Text(
                          "Already have an account? Login",
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: (){
                          //Get.off(Login());
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

  Future _chooseImage(BuildContext context){
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            const SizedBox(height: 10,),
            Container(
              child: const Text("Choose Photo", style: TextStyle(fontSize: 20),),
            ),
            Container(height: 1, color: Colors.grey, margin: const EdgeInsets.only(left: 10, right: 10),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                InkWell(
                  child: SizedBox(
                    height: 90,
                    width: 90,
                    child: Icon(
                      Icons.photo, size: 60, color: Colors.blue.withOpacity(.8),
                    ),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    //takeFromGallery();
                  },
                ),

                InkWell(
                  child: SizedBox(
                    height: 90,
                    width: 90,
                    child: Icon(
                      Icons.camera, size: 60, color: Colors.blue.withOpacity(.8),
                    ),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    //takeFromCamera();
                  },
                ),

              ],
            ),

          ],
        );
      },
    );
  }


}
