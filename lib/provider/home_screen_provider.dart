import 'dart:convert';

import 'package:boost_provider_state/model/category_model.dart';
import 'package:boost_provider_state/model/featured_service_model.dart';
import 'package:boost_provider_state/model/testimonials_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/appUrl.dart';


enum CategoryStatus {
  initial,
  loading,
  loaded,
  internalError,
  somethingWrong
}

class HomeScreenProvider extends ChangeNotifier {

  CategoryStatus categoryStatus = CategoryStatus.initial;

  CategoryStatus get selectStatus => categoryStatus;
  set selectStatus(CategoryStatus status){
    categoryStatus= status;
  }

  int selectedNevItemPosition = 0;
  void nevPosition(int position) {
    selectedNevItemPosition = position;
    notifyListeners();
  }

  ScrollController? controller;
  CategoryModel? categoryModel;
  Future<void> getCategory() async {
    controller= ScrollController();
    final prefs = await SharedPreferences.getInstance();
    String? token= prefs.getString("loginToken");
    categoryStatus = CategoryStatus.loading;
    notifyListeners();
    var response = await get(Uri.parse(AppUrl.category),
        headers: {
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      categoryModel= CategoryModel.fromJson(jsonDecode(response.body));
      categoryStatus = CategoryStatus.loaded;
      notifyListeners();
    } else if (response.statusCode == 500) {
      categoryStatus = CategoryStatus.internalError;
      notifyListeners();
    } else {
      categoryStatus = CategoryStatus.somethingWrong;
      notifyListeners();
    }
  }

  FeaturedServiceModel? featuredServiceModel;
  Future<void> getFeaturedService() async {
    final prefs = await SharedPreferences.getInstance();
    String? token= prefs.getString("loginToken");
    categoryStatus = CategoryStatus.loading;
    notifyListeners();
    var response = await get(Uri.parse(AppUrl.featureService),
        headers: {
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      featuredServiceModel= FeaturedServiceModel.fromJson(jsonDecode(response.body));
      categoryStatus = CategoryStatus.loaded;
      notifyListeners();
    } else if (response.statusCode == 500) {
      categoryStatus = CategoryStatus.internalError;
      notifyListeners();
    } else {
      categoryStatus = CategoryStatus.somethingWrong;
      notifyListeners();
    }
  }

  TestimonialModel? testimonialModel;
  Future<void> getTestimonial() async {
    final prefs = await SharedPreferences.getInstance();
    String? token= prefs.getString("loginToken");
    categoryStatus = CategoryStatus.loading;
    notifyListeners();
    var response = await get(Uri.parse(AppUrl.testimonials),
        headers: {
          'Accept': 'application/json',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      testimonialModel= TestimonialModel.fromJson(jsonDecode(response.body));
      categoryStatus = CategoryStatus.loaded;
      notifyListeners();
    } else if (response.statusCode == 500) {
      categoryStatus = CategoryStatus.internalError;
      notifyListeners();
    } else {
      categoryStatus = CategoryStatus.somethingWrong;
      notifyListeners();
    }
  }

}