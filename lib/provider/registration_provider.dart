

import 'dart:convert';

import 'package:boost_provider_state/model/user_auth_model.dart';
import 'package:boost_provider_state/utility/appUrl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum Status {
  registered,
  notRegistered,
  registering,
  existingEmail,
  internalError,
  somethingWrong
}

class RegistrationProvider extends ChangeNotifier {

  Status _registrationStatus = Status.notRegistered;

  Status get registrationStatus => _registrationStatus;
  set registrationStatus(Status value) {
    _registrationStatus = value;
  }

  bool isVisiblePassword= true;
  void passwordVisibility(value) {
    isVisiblePassword = value;
    notifyListeners();
  }
  bool rememberPasswordReg= false;
  void rememberPasswordStatusReg(value) {
    rememberPasswordReg = value;
    notifyListeners();
  }

  Future<UserAuthModel> registration(String name, String email,String password) async{
    UserAuthModel registrationModel= UserAuthModel();
    try{
      final Map<String, dynamic> registrationData = {
        "name": name,
        "email": email,
        "password": password,
      };
      _registrationStatus = Status.registering;
      notifyListeners();
      var response= await http.post(Uri.parse(AppUrl.registration),
        body: registrationData
      );
      if(response.statusCode == 422){
        _registrationStatus = Status.existingEmail;
        notifyListeners();
      } else if (response.statusCode == 200 || response.statusCode == 201){
        registrationModel= UserAuthModel.fromJson(jsonDecode(response.body));
        _registrationStatus = Status.registered;
        notifyListeners();
      } else {
        _registrationStatus = Status.internalError;
        notifyListeners();
      }
    } catch(exception){
      _registrationStatus = Status.somethingWrong;
      notifyListeners();
    }
    return registrationModel;
  }

}