
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/select_property_model.dart';
import '../utility/appUrl.dart';

enum Status {
  property,
  selectingProperty,
  selectedProperty,
  notSelectedProperty
}

class SelectPropertyProvider extends ChangeNotifier {

  Status selectPropertyStatus = Status.property;

  Status get selectStatus => selectPropertyStatus;
  set selectStatus(Status status){
    selectPropertyStatus= status;
  }

  int cardIndex= 1000;
  void cardSelectColor(int index){
    cardIndex= index;
    notifyListeners();
  }

  String selectedPropertyCity= "";
  void selectedCity(String value){
    selectedPropertyCity= value;
    notifyListeners();
  }

  int listItem = 10000000;
  void selectListItem(int value) {
    listItem = value;
    notifyListeners();
  }
  saveSelectCash() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("selectedHome", "1");
    notifyListeners();
  }

  SelectPropertyModel? selectPropertyModel;
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
      selectPropertyStatus = Status.selectedProperty;
      notifyListeners();
    } else {
      selectPropertyStatus = Status.notSelectedProperty;
      notifyListeners();
    }
  }

}