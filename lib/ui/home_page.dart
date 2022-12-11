
import 'dart:developer';
import 'dart:async';
import 'package:boost_provider_state/provider/home_screen_provider.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/select_property_provider.dart';
import '../utility/common.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  late DateTime currentBackPressTime;
  String selectedHome = "";
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
  Gradient selectedGradient =
  const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
  const LinearGradient(colors: [Colors.red, Colors.blueGrey]);
  Color? containerColor;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final homeScreenProvider= Provider.of<HomeScreenProvider>(context, listen: false);
      homeScreenProvider.getCategory();
      homeScreenProvider.getFeaturedService();
      homeScreenProvider.getTestimonial();
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider homeScreenProvider = Provider.of<HomeScreenProvider>(context);
    SelectPropertyProvider selectPropertyProvider = Provider.of<SelectPropertyProvider>(context);
    Common.dynamicScreenSize(context);
    getSelectedCash();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            Center(
              child: Container(
                height: Common.mediaQueryHeight,
                color: Colors.grey.withOpacity(.2),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: const [0.1, 0.9],
                            colors: [HexColor("#00639C"), HexColor("#00AFDE")],
                          ),
                        ),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 250,
                                width: Common.mainContainerWidth * .52,
                                margin: const EdgeInsets.only(left: 15, top: 50, bottom: 15),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    InkWell(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.white,
                                        ),
                                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(height: 3, width: 20, color: Colors.grey),
                                            Container(height: 3, width: 25, margin: const EdgeInsets.only(top: 5),color: Colors.grey),
                                            Container(height: 3, width: 20, margin: const EdgeInsets.only(top: 5), color: Colors.grey),
                                          ],
                                        ),
                                      ),
                                      onTap: () => scaffoldKey.currentState?.openDrawer(),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(top: 30),
                                      child: Text(
                                        "What type of services",
                                        style: GoogleFonts.raleway(textStyle: Common.testStyleWhiteBold16),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "do you need?",
                                        style: GoogleFonts.raleway(textStyle: Common.testStyleWhiteBold16),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 120,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(top: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      ),
                                      child: Text("Get Start",style: GoogleFonts.raleway(textStyle: Common.testStyleBlackBold16)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 250,
                                width: Common.mainContainerWidth * .48,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      "images/homelogo.png",
                                      width: Common.mainContainerWidth * .48,
                                      height: 250,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    InkWell(
                                      child: Container(
                                        margin: EdgeInsets.zero,
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 10,
                                          width: 65,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.all(5),
                                          child: const Text(
                                            "Change Home",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 10, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Timer(const Duration(milliseconds: 200), () => Navigator.pushNamed(context, '/selectProperty'));
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// search
                      Container(
                        height: 55,
                        width: Common.mediaQueryWidth,
                        margin: const EdgeInsets.only(top: 10, left: 15, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: Common.mediaQueryWidth - 95,
                              margin: const EdgeInsets.only(right: 5, left: 5),
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                controller: searchController,
                                style: const TextStyle(fontSize: 14, color: Colors.black),
                                onTap: () {
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  Timer(const Duration(milliseconds: 500), () => Navigator.pushNamed(context, '/propertySearch'));
                                },
                                decoration: const InputDecoration(
                                  focusColor: Colors.blue,
                                  border: InputBorder.none,
                                  hintText: "Search Services",
                                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                                  contentPadding: EdgeInsets.only(left: 10),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              color: Colors.blue,
                              child: InkWell(
                                child: const SizedBox(
                                  height: 55,
                                  width: 50,
                                  child: Icon(Icons.search, color: Colors.white),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// category and see all
                      Container(
                        height: 30,
                        width: Common.mediaQueryWidth,
                        margin: const EdgeInsets.only(top: 5, left: 5),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: (Common.mediaQueryWidth / 100) * 50 - 12,
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text("Categories", style: GoogleFonts.raleway(textStyle: Common.testStyleBlackBold16)),
                            ),
                            InkWell(
                              child: Container(
                                height: 30,
                                width: (Common.mediaQueryWidth / 100) * 50,
                                padding: const EdgeInsets.only(right: 10),
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  "View All",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/allCategory');
                              },
                            ),
                          ],
                        ),
                      ),

                      /// category
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeRight: true,
                        removeBottom: true,
                        removeLeft: true,
                        child: Consumer<HomeScreenProvider>(
                          builder: ((context, provider, child){
                            return AlignedGridView.count(
                                controller: provider.controller,
                                crossAxisCount: 4,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.categoryModel == null ? 0 : provider.categoryModel!.data!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: DelayedDisplay(
                                      delay: const Duration(milliseconds: 100),
                                      slidingBeginOffset: const Offset(0.0, 0.10),
                                      child: Container(
                                        height: 110,
                                        width: (Common.mediaQueryWidth / 100) * 25 - 5,
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white),
                                              child: provider.categoryModel!.data![index].icon.toString() == "null" ||
                                                  provider.categoryModel!.data![index].icon == "icon" ? Image.asset(
                                                "images/boostlogo.png",
                                                height: 60,
                                                width: 60,
                                              ) : Image.network(
                                                provider.categoryModel!.data![index].icon.toString(),
                                                height: 60,
                                                width: 60,
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              margin: const EdgeInsets.only(top: 5),
                                              child: Text(
                                                provider.categoryModel!.data![index].title.toString(),
                                                textAlign:TextAlign.center,
                                                style: GoogleFonts.raleway(textStyle: Common.testStyleBlack13),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      Common.customToast("clicked: $index");
                                      /*final prefs = await SharedPreferences.getInstance();
                                      prefs.setString("subTitle", appController.categoryTitle[index].toString());
                                      log("category_id: ${appController.categoryID[index]} title: ${appController.categoryTitle[index].toString()}");
                                      appController.getService(appController.categoryID[index].toString());*/
                                    },
                                  );
                                }
                            );
                          }),
                        ),
                      ),

                      Container(
                        height: 30,
                        width: Common.mediaQueryWidth,
                        padding: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Text("Popular Service", style: GoogleFonts.raleway(textStyle: Common.testStyleBlackBold16)),
                      ),

                      /// popular
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeRight: true,
                        removeBottom: true,
                        removeLeft: true,
                        child: Consumer<HomeScreenProvider>(
                          builder: ((context, provider, child){
                            return ListView.builder(
                              itemCount: provider.featuredServiceModel == null ? 0 : provider.featuredServiceModel!.data!.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  child: DelayedDisplay(
                                    delay: const Duration(milliseconds: 100),
                                    slidingBeginOffset: const Offset(0.0, 0.10),
                                    child: Container(
                                      height: 150,
                                      width: Common.mainContainerWidth,
                                      margin: const EdgeInsets.only(left: 10, right: 10),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.white, width: 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [

                                            SizedBox(
                                              height: 150,
                                              width: Common.mainContainerWidth * .48,
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                ),
                                                child: provider.featuredServiceModel!.data![index].image == null ? Image.asset(
                                                  "images/boostlogo.png",
                                                  height: 130,
                                                  width: (Common.mainContainerWidth / 100) * 45 - 2,
                                                  fit: BoxFit.fill,
                                                ) : Image.network(
                                                  provider.featuredServiceModel!.data![index].image!.original.toString(),
                                                  height: 130,
                                                  width: (Common.mainContainerWidth / 100) * 45 - 2,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              height: 150,
                                              width: Common.mainContainerWidth * .50,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    alignment: Alignment.centerLeft,
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: Text(
                                                      provider.featuredServiceModel!.data![index].title.toString(),
                                                      textAlign: TextAlign.start,
                                                      style: GoogleFonts.raleway(textStyle: Common.testStyleBlackBold14,),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 70,
                                                    alignment: Alignment.topLeft,
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: Text(
                                                      provider.featuredServiceModel!.data![index].description.toString(),
                                                      textAlign: TextAlign.justify,
                                                      style: GoogleFonts.raleway(textStyle: Common.testStyleBlack13,),
                                                      maxLines: 4,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 20,
                                                    alignment: Alignment.centerLeft,
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: Text(
                                                      "By ${provider.featuredServiceModel!.data![index].title.toString()}",
                                                      textAlign: TextAlign.start,
                                                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    /*log("check_popular_id: ${appController.serviceListID[index].toString()}");
                                    appController.getServiceDetails(appController.serviceListID[index].toString());*/
                                  },
                                );
                              },
                            );
                          }),
                        ),
                      ),

                      /// testimonial
                      Container(
                        height: 30,
                        width: Common.mediaQueryWidth,
                        margin: const EdgeInsets.only(left: 15, top: 10),
                        child: Text("Testimonial", style: GoogleFonts.raleway(textStyle: Common.testStyleBlackBold16,)),
                      ),

                      SizedBox(
                        height: 270,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeRight: true,
                          removeBottom: true,
                          removeLeft: true,
                          child: Consumer<HomeScreenProvider>(
                            builder: ((context, provider, child){
                              return ListView.builder(
                                itemCount: provider.testimonialModel == null ? 0 : provider.testimonialModel!.data!.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return DelayedDisplay(
                                    delay: const Duration(milliseconds: 100),
                                    slidingBeginOffset: const Offset(0.0, 0.10),
                                    child: Container(
                                      width: Common.halfWidth + 70,
                                      margin: const EdgeInsets.only(left: 5),
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Container(
                                          color: Colors.white,
                                          margin: const EdgeInsets.all(5),
                                          child: Column(
                                            children: <Widget>[

                                              Container(
                                                width: 100,
                                                height: 100,
                                                margin: const EdgeInsets.only(top: 5),
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.blue, width: 2),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                  child: provider.testimonialModel!.data![index].image == null ? Image.asset(
                                                    "images/boostlogo.png",
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.fill,
                                                  ) : Image.network(
                                                    provider.testimonialModel!.data![index].image!.original.toString(),
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                height: 25,
                                                width: Common.halfWidth + 70,
                                                margin: const EdgeInsets.only(top: 5),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  provider.testimonialModel!.data![index].title.toString(),
                                                  style: GoogleFonts.raleway(textStyle: Common.testStyleBlackBold14,),
                                                ),
                                              ),

                                              Container(
                                                height: 20,
                                                width: Common.halfWidth + 70,
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  provider.testimonialModel!.data![index].designation.toString(),
                                                  style: GoogleFonts.raleway(textStyle: Common.testStyleBlack13),
                                                ),
                                              ),

                                              Container(
                                                width: Common.halfWidth + 70,
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(left: 10, right: 10),
                                                child: Text(
                                                  provider.testimonialModel!.data![index].description.toString(),
                                                  textAlign: TextAlign.justify,
                                                  style: GoogleFonts.raleway(textStyle: Common.testStyleBlack13),
                                                  maxLines: 3,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          shape: bottomBarShape,
          snakeViewColor: selectedColor,
          selectedItemColor: itemSelectedColor,
          unselectedItemColor: unselectedColor,
          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,
          currentIndex: homeScreenProvider.selectedNevItemPosition,
          onTap: (index) {
            homeScreenProvider.nevPosition(index);
            if (index == 0) {
            } else if (index == 1) {
              if (selectedHome != "1") {
                Common.serviceCashSave(context);
              } else {
                Timer(const Duration(milliseconds: 500), () => Navigator.pushNamed(context, "/serviceOwner"));
              }
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
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
        ),
        drawer: Drawer(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(100), topLeft: Radius.circular(100)),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Container(
                  height: 150,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 5),
                  padding: EdgeInsets.zero,
                  color: HexColor("#EDF4F6"),
                  child: Image.asset(
                    "images/boostlogo.png",
                    height: 140,
                    width: Common.mainContainerWidth,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 140,
                  margin: const EdgeInsets.only(top: 140),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        children: [
                          Common.customDrawerItem("Account Settings", Icons.settings,
                                () => {Navigator.pop(context), Navigator.pushNamed(context, "/accountSettings")}, Icons.arrow_forward_ios,),
                          Container(height: 1, color: Colors.grey, margin: const EdgeInsets.only(left: 5, right: 20)),
                          Common.customDrawerItem("Notification", Icons.notification_important,
                                  () => {Navigator.pop(context), Navigator.pushNamed(context, "/notification")}, Icons.arrow_forward_ios),
                          Container(height: 1, color: Colors.grey, margin: const EdgeInsets.only(left: 5, right: 20)),
                          Common.customDrawerItem("Service", Icons.calendar_today_rounded, () => {Navigator.pop(context),
                            if (selectPropertyProvider.listItem == 10000000){
                              Common.serviceCashSave(context)
                            } else {
                              Timer(const Duration(milliseconds: 500), () => Navigator.pushNamed(context, "/serviceOwner"))
                            }
                          }, Icons.arrow_forward_ios),
                          Container(height: 1, color: Colors.grey, margin: const EdgeInsets.only(left: 5, right: 20)),
                          Common.customDrawerItem("Manage Home / Property", Icons.home,
                                  () => {Navigator.pop(context), Navigator.pushNamed(context, "/propertyList")}, Icons.arrow_forward_ios),
                          Container(height: 1, color: Colors.grey, margin: const EdgeInsets.only(left: 5, right: 20)),
                          Common.customDrawerItem("Log Out", Icons.logout,
                                  () => {Navigator.pop(context), _logoutDialog(context)}, Icons.arrow_forward_ios),
                          Container(height: 1, color: Colors.grey, margin: const EdgeInsets.only(left: 5, right: 20)),
                          Common.customDrawerItem("Delete Account", Icons.delete,
                                  () => {Navigator.pop(context), _deleteDialog(context)}, Icons.arrow_forward_ios),
                          Container(height: 1, color: Colors.grey, margin: const EdgeInsets.only(left: 5, right: 20)),
                        ],
                      ),
                      const Text("version: 1.0.0", style: TextStyle(fontSize: 12, color: Colors.black)),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getSelectedCash() async {
    final prefs = await SharedPreferences.getInstance();
    selectedHome = prefs.getString("selectedHome").toString();
    log("check_cash: $selectedHome");
  }

  Future<void> _logoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DelayedDisplay(
          delay: const Duration(milliseconds: 100),
          slidingBeginOffset: const Offset(0.0, 0.10),
          child: CupertinoAlertDialog(
            title: Text("Log Out", style: GoogleFonts.raleway(textStyle: Common.testStyleBlackBold18)),
            content: Container(
              height: 100,
              width: 150,
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Are you sure?", style: GoogleFonts.raleway(textStyle: Common.testStyleBlack16)),
                  Container(height: 1, margin: const EdgeInsets.only(top: 10),color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 100,
                          alignment: Alignment.center,
                          child: Text("Yes", style: GoogleFonts.raleway(textStyle: Common.testStyleBlack16)),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          //appController.userLogout();
                        },
                      ),
                      Container(width: 1, height: 50, color: Colors.grey),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 100,
                          alignment: Alignment.center,
                          child: Text("No", style: GoogleFonts.raleway(textStyle: Common.testStyleBlack16)),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DelayedDisplay(
          delay: const Duration(milliseconds: 100),
          slidingBeginOffset: const Offset(0.0, 0.10),
          child: CupertinoAlertDialog(
            title: Text("Delete Account", style: GoogleFonts.raleway(textStyle: Common.testStyleBlackBold18)),
            content: Container(
              height: 100,
              width: 150,
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Are you sure?", style: GoogleFonts.raleway(textStyle: Common.testStyleBlack16)),
                  Container(height: 1, margin: const EdgeInsets.only(top: 10), color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 100,
                          alignment: Alignment.center,
                          child: Text("Yes", style: GoogleFonts.raleway(textStyle: Common.testStyleBlack16)),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          //appController.userDelete();
                        },
                      ),
                      Container(width: 1, height: 50, color: Colors.grey),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 100,
                          alignment: Alignment.center,
                          child: Text("No", style: GoogleFonts.raleway(textStyle: Common.testStyleBlack16)),
                        ),
                        onTap: () {Navigator.pop(context);},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Common.customToast("Double tap to closed");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
