
import 'dart:developer';
import 'dart:async';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/home_screen_provider.dart';
import '../../provider/service_owner_provider.dart';
import '../../utility/common.dart';

class ServiceOwner extends StatefulWidget {
  @override
  State<ServiceOwner> createState() => _ServiceOwner();
}

class _ServiceOwner extends State<ServiceOwner> {

  String homeSelectID = "0", selectedHome = "";

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);
  SnakeShape snakeShape = SnakeShape.circle;
  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;
  Color selectedColor = Colors.blue;
  Color itemSelectedColor = Colors.white;
  Color unselectedColor = Colors.grey;
  Gradient selectedGradient = const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient = const LinearGradient(colors: [Colors.red, Colors.blueGrey]);
  Color? containerColor;
  int currentInd = 1;
  String noImage= "https://artsmidnorthcoast.com/wp-content/uploads/2014/05/no-image-available-icon-6.png";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final serviceOwnerProvider= Provider.of<ServiceOwnerProvider>(context, listen: false);
      serviceOwnerProvider.getAllProperty();
      serviceOwnerProvider.getAllService("0");
    });
  }

  @override
  Widget build(BuildContext context) {
    ServiceOwnerProvider serviceOwnerProvider = Provider.of<ServiceOwnerProvider>(context);
    HomeScreenProvider homeScreenProvider = Provider.of<HomeScreenProvider>(context);
    Common.dynamicScreenSize(context);
    currentInd = 1;
    getSelectedCash();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: HexColor("#EDF4F6"),
        appBar: AppBar(
          backgroundColor: HexColor("#EDF4F6"),
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.only(left: 1),
            height: 30,
            width: 30,
            child: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/homePage");
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          actions: [
            Container(
              width: Common.mainContainerWidth,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 20),
              child: Text(
                "Service",
                style: GoogleFonts.raleway(textStyle: Common.testStyleBlackBold16),
              ),
            ),
          ],
        ),
        body: Container(
          color: HexColor("#EDF4F6"),
          height: Common.mainContainerHeight + 66,
          margin: const EdgeInsets.all(5),
          child: Consumer<ServiceOwnerProvider>(
            builder: ((context, provider, child){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      width: Common.mediaQueryWidth - 2,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.white,
                      ),
                      child: Stack(children: <Widget>[
                        Builder(builder: (context) {
                          ///stack foreground ui
                          return Container(
                            height: 45,
                            width: Common.mediaQueryWidth,
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: (Common.mediaQueryWidth - 90),
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    provider.serviceListSelectedValue == "" ? "All Homes" : provider.serviceListSelectedValue.toString(),
                                    style: const TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                ),
                                Container(width: 50),
                              ],
                            ),
                          );
                        }),

                        ///stack drop down
                        Positioned(
                          child: SizedBox(
                            height: 40,
                            child: Row(children: <Widget>[
                              Container(
                                width: Common.mediaQueryWidth - 35,
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: true,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    iconSize: 18,
                                    elevation: 16,
                                    iconEnabledColor: Colors.grey,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (newSelected) {
                                      provider.serviceListDropDownSelect(newSelected!);
                                    },
                                    items: serviceOwnerProvider.dropDownTitleList.map<DropdownMenuItem<String>>((item) {
                                      return DropdownMenuItem<String>(
                                        value: item.toString(),
                                        child: DelayedDisplay(
                                          delay: const Duration(milliseconds: 200),
                                          slidingBeginOffset: const Offset(0.0, 0.30),
                                          child: Text(
                                            item.toString(),
                                            style: GoogleFonts.raleway(textStyle: Common.testStyleBlack14),
                                          ),
                                        ),
                                        onTap: () {
                                          homeSelectID = provider.getDropDownID[item.toString()].toString();
                                          log("selected_id: $homeSelectID");
                                          provider.getAllService(homeSelectID);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 5),
                    provider.selectUserServiceStatus == UserServiceStatus.serviceLoading ? const Center(child: CircularProgressIndicator()) :
                    provider.selectUserServiceStatus == UserServiceStatus.serviceLoaded ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: provider.userServiceModel!.data!.length,
                      itemBuilder: (context, index) => DelayedDisplay(
                        delay: const Duration(milliseconds: 200),
                        slidingBeginOffset: const Offset(0.0, 0.10),
                        child: InkWell(
                          child: Card(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10),),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      margin: const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 15),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          provider.userServiceModel!.data![index].serviceProvider == null ? noImage :
                                          provider.userServiceModel!.data![index].serviceProvider!.image!.original.toString(),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      width: Common.mainContainerWidth - 120,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            provider.userServiceModel!.data![index].serviceProvider == null ? "Empty" :
                                            provider.userServiceModel!.data![index].serviceProvider!.companyName.toString(),
                                            style: GoogleFonts.raleway(textStyle: Common.testStyleBlack16),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(top: 5),
                                            child: Text(
                                              provider.userServiceModel!.data![index].service == null ? "Empty" :
                                              provider.userServiceModel!.data![index].service!.title.toString(),
                                              style: GoogleFonts.raleway(textStyle: Common.testStyleGrey14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.grey,
                                  margin: const EdgeInsets.only(left: 10, right: 10),
                                ),
                                Container(
                                  height: 30,
                                  width: Common.mainContainerWidth,
                                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today_rounded,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Date",
                                              style: GoogleFonts.raleway(textStyle: Common.testStyleGrey14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        provider.userServiceModel!.data![index].date.toString(),
                                        style: GoogleFonts.raleway(textStyle: Common.testStyleBlack14),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: Common.mainContainerWidth,
                                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today_rounded,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Next Service Date",
                                              style: GoogleFonts.raleway(textStyle: Common.testStyleGrey14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        provider.userServiceModel!.data![index].userServiceRenews == null ? provider.userServiceModel!.data![index].date.toString() :
                                        provider.userServiceModel!.data![index].userServiceRenews!.nextServiceDate.toString(),
                                        style: GoogleFonts.raleway(textStyle: Common.testStyleBlack14),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: Common.mainContainerWidth,
                                  margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Location",
                                              style: GoogleFonts.raleway(textStyle: Common.testStyleGrey14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 30,
                                        width: 200,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          provider.userServiceModel!.data![index].property == null ? "Empty" :
                                          "${provider.userServiceModel!.data![index].property!.city.toString()}, "
                                              "${provider.userServiceModel!.data![index].property!.state.toString()}, "
                                              "${provider.userServiceModel!.data![index].property!.country.toString()}",
                                          textAlign: TextAlign.right,
                                          style: GoogleFonts.raleway(textStyle: Common.testStyleBlack14),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: Common.mainContainerWidth,
                                  margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today_rounded,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Status",
                                              style: GoogleFonts.raleway(textStyle: Common.testStyleGrey14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        provider.userServiceModel!.data![index].adminStatus == "0" ? "Quotation Rejected" :
                                        provider.userServiceModel!.data![index].adminStatus.toString(),
                                        style: GoogleFonts.raleway(textStyle: Common.testStyleGreen14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            Common.customToast("clicked: $index");
                          },
                        ),
                      ),
                    ) :
                    provider.selectUserServiceStatus == UserServiceStatus.serviceNotFound ? DelayedDisplay(
                      delay: const Duration(seconds: 1),
                      child: Container(
                        height: Common.mediaQueryHeight - 200,
                        alignment: Alignment.center,
                        child: Text(
                          "No Services Found",
                          style: GoogleFonts.raleway(textStyle: Common.testStyleRed20,),
                        ),
                      ),
                    ) : Container()

                  ],
                ),
              );
            }),
          ),
        ),
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          snakeViewColor: selectedColor,
          selectedItemColor: itemSelectedColor,
          unselectedItemColor: unselectedColor,
          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,
          currentIndex: homeScreenProvider.selectedNevItemPosition,
          onTap: (index) {
            homeScreenProvider.nevPosition(index);
            if (index == 0) {
              if (selectedHome != "1") {
                Common.homeCashSave(context);
              } else {
                Timer(const Duration(milliseconds: 500), () => Navigator.pushNamed(context, "/homePage"));
              }
            } else if (index == 1) {
            } else if (index == 2) {
              Timer(const Duration(milliseconds: 500), () => Navigator.pushNamed(context, "/notification"));
            } else {
              Timer(const Duration(milliseconds: 500), () => Navigator.pushNamed(context, "/accountSettings"));
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.business_center_rounded), label: 'Business'),
            BottomNavigationBarItem(icon: Icon(Icons.notification_important), label: 'Notification'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ],
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ///Get.to(ServiceCreate());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  getSelectedCash() async {
    final prefs = await SharedPreferences.getInstance();
    selectedHome = prefs.getString("selectedHome").toString();
  }

}
