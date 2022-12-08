
import 'package:boost_provider_state/model/user_auth_model.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../provider/login_provider.dart';
import '../../utility/common.dart';
import '../../widget/button_widget.dart';
import '../../widget/widget_decoration.dart';

class Login extends StatelessWidget {

  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  UserAuthModel loginModel= UserAuthModel();

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);
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
                        "Login",
                        style: GoogleFonts.raleway(textStyle: Common.testStyleWhite25,),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: MediaQuery.of(context).orientation == Orientation.portrait ? Common.mediaQueryHeight * .34 : 190,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Common.fieldTitle18("Email"),
                    Container(
                      height: 40,
                      width: Common.mediaQueryWidth,
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: emailController,
                        style: GoogleFonts.raleway(textStyle: Common.testStyleWhite16,),
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

                    const SizedBox(height: 20),

                    Common.fieldTitle18("Password"),
                    Container(
                      height: 40,
                      width: Common.mediaQueryWidth,
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: loginProvider.isVisiblePassword,
                        style: GoogleFonts.raleway(textStyle: Common.testStyleWhite16,),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: Colors.white,
                          hintText: 'password',
                          hintStyle: const TextStyle(fontSize: 18, color: Colors.white70),
                          suffixIcon: IconButton(icon: Icon(!loginProvider.isVisiblePassword ? Icons.visibility : Icons.visibility_off, color: Colors.cyanAccent),
                            onPressed: () {
                              loginProvider.passwordVisibility(!loginProvider.isVisiblePassword);
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(height: 1,
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      color: Colors.white,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(
                          height: 45,
                          width: Common.mainContainerWidth * .55,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              CustomCheckBox(
                                value: loginProvider.rememberPassword,
                                splashColor: Colors.red.withOpacity(0.4),
                                splashRadius: 40,
                                checkedIconColor: Colors.blue,
                                checkedFillColor: Colors.white,
                                borderColor: Colors.white,
                                uncheckedFillColor: Colors.transparent,
                                uncheckedIconColor: Colors.transparent,
                                shouldShowBorder: true,
                                onChanged: (value) {
                                  loginProvider.rememberPasswordStatus(value);
                                },
                              ),
                              const Text("Remember Password", style: TextStyle(fontSize: 12, color: Colors.white)),
                            ],
                          ),
                        ),

                        GestureDetector(
                          child: Container(
                            height: 45,
                            width: Common.mainContainerWidth * .35,
                            alignment: Alignment.centerRight,
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: (){
                            //Get.to(ForgotPassword());
                          },
                        ),
                      ],
                    ),


                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).orientation == Orientation.portrait ? Common.mediaQueryHeight * .30 : 150,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    loginProvider.loggedInStatus == Status.authenticating ? loading : ButtonWidget(
                      title: "Log in",
                      color: Colors.white,
                      textColor: Colors.black,
                      onPress: () async {
                        if(emailController.text.toString().isEmpty){
                          Common.customToast("Enter Email");
                        } else if(passwordController.text.toString().isEmpty){
                          Common.customToast("Enter Password");
                        }  else {
                          loginModel= await loginProvider.login(emailController.text.toString(), passwordController.text.toString());
                          if(loginProvider.loggedInStatus == Status.loggedIn){
                            customToast("Login success");
                            Navigator.pushReplacementNamed(context, '/homePage');
                          } else if(loginProvider.loggedInStatus == Status.notLoggedIn){
                            customToast("Invalid Email or password");
                          }
                        }
                      },
                    ),

                    Container(
                      height: 30,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, "/registration");
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
