class SelectPropertyModel {
  List<Data>? data;

  SelectPropertyModel({this.data});

  SelectPropertyModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? user;
  String? title;
  String? estDate;
  String? location;
  String? totalSpace;
  String? country;
  String? state;
  String? city;
  Image? image;
  String? createdAt;

  Data(
      {this.id,
        this.user,
        this.title,
        this.estDate,
        this.location,
        this.totalSpace,
        this.country,
        this.state,
        this.city,
        this.image,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    title = json['title'];
    estDate = json['est_date'];
    location = json['location'];
    totalSpace = json['total_space'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    image = json['images'] != null ? new Image.fromJson(json['images']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['title'] = this.title;
    data['est_date'] = this.estDate;
    data['location'] = this.location;
    data['total_space'] = this.totalSpace;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    if (this.image != null) {
      data['images'] = this.image!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Image {
  String? original;
  String? small;
  String? medium;
  String? large;

  Image({this.original, this.small, this.medium, this.large});

  Image.fromJson(Map<String, dynamic> json) {
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