import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/select_property_model.dart';
import 'package:http/http.dart';

import '../model/user_service_model.dart';
import '../utility/appUrl.dart';

enum Status {
  property,
  selectingProperty,
  selectedProperty,
  notSelectedProperty
}

enum UserServiceStatus {
  initial,
  serviceLoading,
  serviceLoaded,
  serviceNotFound,
}

class ServiceOwnerProvider extends ChangeNotifier {
  Status selectPropertyStatus = Status.property;
  UserServiceStatus selectUserServiceStatus = UserServiceStatus.initial;

  Status get selectStatus => selectPropertyStatus;
  set selectStatus(Status status){
    selectPropertyStatus= status;
  }

  UserServiceStatus get selectUserService => selectUserServiceStatus;
  set selectUserService(UserServiceStatus userServiceStatus){
    selectUserServiceStatus= userServiceStatus;
  }


  String serviceListSelectedValue= "";
  void serviceListDropDownSelect(String string){
    serviceListSelectedValue= string;
    notifyListeners();
  }

  /// get All Property
  SelectPropertyModel? selectPropertyModel;
  List dropDownTitleList= [];
  List dropDownIDList= [];
  var getDropDownID = {};
  Future<void> getAllProperty() async {
    final prefs = await SharedPreferences.getInstance();
    String? token= prefs.getString("loginToken");
    selectPropertyStatus = Status.selectingProperty;
    notifyListeners();
    var response = await get(Uri.parse(AppUrl.property),
        headers: {
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      selectPropertyModel= SelectPropertyModel.fromJson(jsonDecode(response.body));
      dropDownTitleList.add("All Homes");
      dropDownIDList.add("0");
      for(int i= 0; i< selectPropertyModel!.data!.length; i++) {
        dropDownTitleList.add(selectPropertyModel!.data![i].title);
        dropDownIDList.add(selectPropertyModel!.data![i].id);
      }
      for (int i=0; i< dropDownTitleList.length; i++) {
        getDropDownID["${dropDownTitleList[i]}"]= dropDownIDList[i].toString();
      }
      selectPropertyStatus = Status.selectedProperty;
      notifyListeners();
    } else {
      selectPropertyStatus = Status.notSelectedProperty;
      notifyListeners();
    }
  }

  /// get All Service
  UserServiceModel? userServiceModel;
  Future<void> getAllService(String homeID) async {
    final prefs = await SharedPreferences.getInstance();
    String? token= prefs.getString("loginToken");
    selectUserServiceStatus = UserServiceStatus.serviceLoading;
    notifyListeners();
    var response = await get(Uri.parse(AppUrl.userService+homeID),
        headers: {
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      userServiceModel= UserServiceModel.fromJson(jsonDecode(response.body));
      if(userServiceModel!.data!.isEmpty){
        selectUserServiceStatus = UserServiceStatus.serviceNotFound;
        notifyListeners();
      } else {
        selectUserServiceStatus = UserServiceStatus.serviceLoaded;
        notifyListeners();
      }
    } else {
      selectUserServiceStatus = UserServiceStatus.serviceNotFound;
      notifyListeners();
    }
  }

}