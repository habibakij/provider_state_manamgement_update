class FeaturedServiceModel {
  List<Data>? data;

  FeaturedServiceModel({this.data});

  FeaturedServiceModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  Category? category;
  String? description;
  String? isBoost;
  Image? image;
  String? createdAt;

  Data(
      {this.id,
        this.title,
        this.category,
        this.description,
        this.isBoost,
        this.image,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    description = json['description'];
    isBoost = json['is_boost'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['description'] = this.description;
    data['is_boost'] = this.isBoost;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Category {
  int? id;
  String? title;
  Null? icon;
  String? createdAt;

  Category({this.id, this.title, this.icon, this.createdAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['icon'] = this.icon;
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