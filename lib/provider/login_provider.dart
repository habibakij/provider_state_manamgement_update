import 'dart:async';
import 'dart:convert';
import 'package:boost_provider_state/model/user_auth_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../utility/appUrl.dart';
import '../utility/common.dart';

enum Status {
  notLoggedIn,
  loggedIn,
  authenticating,
}

class LoginProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.notLoggedIn;

  Status get loggedInStatus => _loggedInStatus;
  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  bool isVisiblePassword= true;
  void passwordVisibility(value) {
    isVisiblePassword = value;
    notifyListeners();
  }
  bool rememberPassword= false;
  void rememberPasswordStatus(value) {
    rememberPassword = value;
    notifyListeners();
  }

  void loadingTextField(){
    _loggedInStatus = Status.authenticating;
    notifyListeners();
  }

  void textFieldLoadingValidity(String value){
    Future.delayed(const Duration(milliseconds: 500), () {
      _loggedInStatus = Status.notLoggedIn;
      Common.customToast(value);
      notifyListeners();
    });
  }

  Future<UserAuthModel> login(String email, String password) async {
    UserAuthModel loginModel= UserAuthModel();
    final Map<String, dynamic> loginData = {
      'user': email,
      'password': password
    };
    _loggedInStatus = Status.authenticating;
    notifyListeners();
    var response = await post(Uri.parse(AppUrl.login),
      body: loginData,
    );
    if (response.statusCode == 200) {
      loginModel= UserAuthModel.fromJson(jsonDecode(response.body));
      _loggedInStatus = Status.loggedIn;
      notifyListeners();
    } else {
      _loggedInStatus = Status.notLoggedIn;
      notifyListeners();
    }
    return loginModel;
  }

}