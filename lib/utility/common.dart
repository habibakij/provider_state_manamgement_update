
import 'dart:async';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Common{

  static var mediaQueryHeight= 0.0, mainContainerHeight= 0.0, mediaQueryWidth= 0.0,
      mainContainerWidth= 0.0, fixedHeight= 0.0, halfWidth= 0.0, quaterHalf= 0.0;

  static void dynamicScreenSize(BuildContext context){
    mediaQueryHeight = MediaQuery.of(context).size.height;
    mediaQueryWidth = MediaQuery.of(context).size.width;
    mainContainerHeight = ((mediaQueryHeight / 100.0) * 90.0);
    mainContainerWidth = ((mediaQueryWidth / 100.0) * 90.0);
    fixedHeight = 70;
    halfWidth = (mainContainerWidth / 2) - 10;
    quaterHalf = (mainContainerWidth / 3) - 8;
  }

  static String appbarImageUri = "https://w7.pngwing.com/pngs/310/974/png-transparent-two-dots-microphone-microphone-electronics-logo-monochrome-thumbnail.png";
  static String previewImageUri= "https://pbs.twimg.com/profile_images/1455185376876826625/s1AjSxph_400x400.jpg";

  static String categoryUri= "https://fakestoreapi.com/servicedetails/categories";
  static String productsUri= "https://fakestoreapi.com/servicedetails";
  static String singleProductsUri= "https://fakestoreapi.com/servicedetails/";
  static String productsAllCategoryUri= "https://fakestoreapi.com/servicedetails/categories";

  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    //EasyLoading.show(status: "Loading...");
    EasyLoading.isShow;
  }

/* static handleClick(String value) {
    switch (value) {
      case 'Change Home':
        Timer(const Duration(milliseconds: 200), ()=> Get.to(SelectHomeScreen()));
        break;
      default:
        break;
    }
  }*/

  static customToast(String msg) {
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

  static const testStyleWhite25= TextStyle(fontSize: 25, color: Colors.white,);
  static const testStyleWhiteBold25= TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold);
  static const testStyleWhite20= TextStyle(fontSize: 20, color: Colors.white,);
  static const testStyleWhiteBold16= TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
  static const testStyleWhite16= TextStyle(fontSize: 16, color: Colors.white,);
  static const testStyleWhite14= TextStyle(fontSize: 14, color: Colors.white,);
  static const testStyleGrey14= TextStyle(fontSize: 14, color: Colors.grey,);
  static const testStyleGreen14= TextStyle(fontSize: 14, color: Colors.green);
  static const testStyleRed14= TextStyle(fontSize: 14, color: Colors.red);
  static const testStyleRed20= TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
  static const testStyleBlackBold18= TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);
  static const testStyleBlackBold16= TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
  static const testStyleBlack16= TextStyle(fontSize: 16, color: Colors.black);
  static const testStyleBlack14= TextStyle(fontSize: 14, color: Colors.black);
  static const testStyleBlackBold14= TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
  static const testStyleBlack13= TextStyle(fontSize: 13, color: Colors.black);
  static fieldTitle18(String s) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      width: Common.mediaQueryWidth,
      child: Text(
        s,
        style: GoogleFonts.raleway(
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static fieldTitleBlack0(String s) {
    return Container(
      margin: const EdgeInsets.only(left: 10, bottom: 0, top: 0),
      width: Common.mediaQueryWidth,
      child: Text(
        s,
        style: const TextStyle(
            fontSize: 12,
            color: Colors.black
        ),
      ),
    );
  }

  static fieldTitleBlack(String s) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 0, top: 0),
      width: Common.mediaQueryWidth,
      child: Text(
        s,
        style: const TextStyle(
            fontSize: 12,
            color: Colors.black
        ),
      ),
    );
  }

  static fieldTitleBlack18(String s) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 0, top: 0),
      width: Common.mediaQueryWidth,
      child: Text(
        s,
        style: const TextStyle(
            fontSize: 16,
            color: Colors.black
        ),
      ),
    );
  }

  static iconAndText18(IconData icon, String s) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        children: [

          Icon(icon, size: 20, color: Colors.grey,),

          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              s,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),

        ],
      ),
    );
  }

  static customDrawerItem(String title,IconData icon,Function() onTab, IconData icon2){
    return InkWell(
      onTap: onTab,
      child: DelayedDisplay(
        delay: const Duration(milliseconds: 100),
        slidingBeginOffset: const Offset(0.0, 0.10),
        child: SizedBox(
          height: 50,
          width: 300,
          child: Row(
            children: <Widget> [

              Container(
                width: 20,
                margin: const EdgeInsets.only(left: 5, top: 5),
                child: FittedBox(
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.black.withOpacity(.6),
                  ),
                ),
              ),

              Container(
                width: 220,
                margin: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  title,
                  style: GoogleFonts.raleway(textStyle: Common.testStyleBlack16,),
                ),
              ),

              SizedBox(
                width: 15,
                //margin: const EdgeInsets.only(left: 30, top: 5),
                child: FittedBox(
                  child: Icon(
                    icon2,
                    color: Colors.black.withOpacity(.5),
                    size: 10,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  static Future<void> nextDateDialog1(BuildContext context, String serviceID, TextEditingController price, TextEditingController nDate) async {
    //var appController= Get.put(ServiceController());
    final DateFormat dateFormat = DateFormat('MM-dd-yyyy');
    final DateFormat dateFormat2 = DateFormat('yyyy-MM-dd');
    String passNextDate= "";
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DelayedDisplay(
          delay: const Duration(milliseconds: 500),
          child: CupertinoAlertDialog(
            content: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: 270,
                  width: 250,
                  margin: const EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// title text
                      const SizedBox(
                        height: 30,
                        child: Text(
                          "Update Next Date Service",
                          style: testStyleBlackBold16,
                        ),
                      ),

                      const SizedBox(height: 10,),
                      const SizedBox(height: 20, child: Text("Price", style: TextStyle(fontSize: 16, color: Colors.black,),),),
                      Container(
                        height: 40,
                        width: Common.mediaQueryWidth,
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          controller: price,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: testStyleBlack14,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusColor: Colors.black,
                            hintText: 'Price',
                            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                          ),

                        ),
                      ),

                      Container(height: 1, width: Common.mediaQueryWidth,
                        color: Colors.grey.withOpacity(.5),
                        margin: const EdgeInsets.only(top: 5),
                      ),

                      const SizedBox(height: 10,),
                      const SizedBox(height: 20, child: Text("Next Date", style: TextStyle(fontSize: 16, color: Colors.black,),),),
                      SizedBox(
                        height: 40,
                        width: Common.mediaQueryWidth,
                        child: TextFormField(
                          autofocus: false,
                          readOnly: true,
                          controller: nDate,
                          style: testStyleBlack14,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusColor: Colors.black,
                            hintText: 'mm-dd-yyyy',
                            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          onTap: () {
                            showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1970),
                                lastDate: DateTime(2222))
                                .then((date) {
                              if(date!=null){
                                nDate.text = dateFormat.format(date);
                                passNextDate = dateFormat2.format(date);
                              }
                            });
                          },
                        ),
                      ),

                      Container(height: 1, width: Common.mediaQueryWidth,
                        color: Colors.grey.withOpacity(.5),
                        margin: const EdgeInsets.only(top: 5),
                      ),

                      const SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Container(
                            height: 40,
                            width: 100,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: HexColor("#00AFDE"),
                            ),
                            child: TextButton(
                              //minWidth: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),

                          Container(
                            height: 40,
                            width: 100,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: HexColor("#00AFDE"),
                            ),
                            child: TextButton(
                              //minWidth: MediaQuery.of(context).size.width,
                              child: const Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                if(price.text.toString().isEmpty){
                                  Common.customToast("Enter Price");
                                } else if(nDate.text.toString().isEmpty){
                                  Common.customToast("Select Next Date");
                                } else {
                                  Navigator.pop(context);
                                  //appController.postNextDateService(context, serviceID, price.text.toString(), passNextDate);
                                }
                              },
                            ),
                          ),

                        ],
                      ),



                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

/*  static serviceCashSave() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("serviceCash", "1");
    Timer(const Duration(milliseconds: 500), ()=> Get.to(SelectHomeScreen()));
  }

  static homeCashSave() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("serviceCash", "0");
    Timer(const Duration(milliseconds: 500), ()=> Get.to(SelectHomeScreen()));
  }

  static cashClear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }*/

}