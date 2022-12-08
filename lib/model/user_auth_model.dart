class UserAuthModel {
  Data? data;
  String? authorization;
  int? statusCode;
  String? message;

  UserAuthModel({this.data, this.authorization, this.statusCode, this.message});

  UserAuthModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    authorization = json['authorization'];
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['authorization'] = this.authorization;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  Avatar? avatar;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? password;

  Data(
      {this.id,
        this.avatar,
        this.name,
        this.phone,
        this.email,
        this.address,
        this.password});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar =
    json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['password'] = this.password;
    return data;
  }
}

class Avatar {
  String? original;
  String? small;
  String? medium;
  String? large;

  Avatar({this.original, this.small, this.medium, this.large});

  Avatar.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original'] = this.original;
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}