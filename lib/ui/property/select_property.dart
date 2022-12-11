
import 'dart:developer';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/select_property_provider.dart';
import '../../utility/common.dart';


class SelectPropertyScreen extends StatefulWidget {
  @override
  State<SelectPropertyScreen> createState() => _SelectHomeScreen();
}

class _SelectHomeScreen extends State<SelectPropertyScreen> {

  String serviceCash = "";
  String noImage= "https://artsmidnorthcoast.com/wp-content/uploads/2014/05/no-image-available-icon-6.png";
  late Color cardColor, cardColor2;

  @override
  void initState() {
    super.initState();
    getCash();
    cardColor= Colors.grey.withOpacity(.2);
    cardColor2= Colors.blue.withOpacity(.5);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SelectPropertyProvider>(context, listen: false).getAllProperty();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.add, color: Colors.transparent),
          title: Text(
            "Select Home",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: _customBody(context),
        bottomNavigationBar: createHomeFooter(),
      ),
    );
  }

  void getCash() async {
    final prefs = await SharedPreferences.getInstance();
    serviceCash = prefs.getString("serviceCash").toString();
    log("service_cash: $serviceCash");
  }

  Widget createHomeFooter() {
    return Consumer<SelectPropertyProvider>(
      builder: ((context, provider, child){
        return Container(
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.blue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Visit Home",
                      style: GoogleFonts.lato(textStyle: Common.testStyleWhite14),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      size: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
                onTap: () {
                  if (provider.listItem == 10000000) {
                    Common.customToast("Please Select Homes");
                  } else {
                    provider.saveSelectCash();
                    if (serviceCash == "1") {
                      Navigator.pushNamed(context, "/serviceOwner");
                    } else {
                      Navigator.pushNamed(context, "/homePage");
                    }
                  }
                },
              ),
              Container(
                width: 1,
                color: Colors.white.withOpacity(.5),
              ),
              InkWell(
                child: Text(
                  "Create new homes",
                  style: GoogleFonts.lato(textStyle: Common.testStyleWhite14),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/propertyCreate");
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _customBody(BuildContext context) {
    return Consumer<SelectPropertyProvider>(
      builder: ((context, provider, child){
        if (provider.selectPropertyStatus == Status.selectingProperty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: provider.selectPropertyModel == null ? 0 : provider.selectPropertyModel!.data!.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.only(left: 15,right: 15, top: 10),
                  elevation: 0,
                  color: provider.cardIndex == index ? cardColor2 : cardColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: InkWell(
                    child: Container(
                      width: Common.mediaQueryWidth,
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Container(
                            height: 70,
                            width: 100,
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                provider.selectPropertyModel!.data![index].image == null ? noImage :
                                provider.selectPropertyModel!.data![index].image!.original.toString(),
                                height: 70,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                provider.selectPropertyModel!.data![index].title.toString(),
                                style: const TextStyle(fontSize: 18, color: Colors.black),
                              ),

                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "${provider.selectPropertyModel!.data![index].city.toString()}, "
                                      "${provider.selectPropertyModel!.data![index].state.toString()}, "
                                      "${provider.selectPropertyModel!.data![index].country.toString()}",
                                  style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(.7)),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      provider.cardSelectColor(index);
                      provider.selectListItem(provider.selectPropertyModel!.data![index].id!);
                      provider.selectedCity(provider.selectPropertyModel!.data![index].city.toString());
                      log("selected: $index ${provider.selectedPropertyCity}");
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
