class UserServiceModel {
  List<Data>? data;

  UserServiceModel({this.data});

  UserServiceModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  Property? property;
  Service? service;
  UserServiceRenews? userServiceRenews;
  ServiceProvider? serviceProvider;
  String? title;
  String? name;
  String? price;
  String? phone;
  String? location;
  String? date;
  String? nextServiceDate;
  String? description;
  String? adminStatus;
  String? adminNote;
  String? createdAt;

  Data(
      {this.id,
        this.user,
        this.property,
        this.service,
        this.userServiceRenews,
        this.serviceProvider,
        this.title,
        this.name,
        this.price,
        this.phone,
        this.location,
        this.date,
        this.nextServiceDate,
        this.description,
        this.adminStatus,
        this.adminNote,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    property = json['property'] != null ? new Property.fromJson(json['property']) : null;
    service = json['service'] != null ? new Service.fromJson(json['service']) : null;
    userServiceRenews = json['user_service_renews'] != null ? new UserServiceRenews.fromJson(json['user_service_renews']) : null;
    serviceProvider = json['service_provider'] != null ? new ServiceProvider.fromJson(json['service_provider']) : null;
    title = json['title'];
    name = json['name'];
    price = json['price'];
    phone = json['phone'];
    location = json['location'];
    date = json['date'];
    nextServiceDate = json['next_service_date'];
    description = json['description'];
    adminStatus = json['admin_status'];
    adminNote = json['admin_note'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.property != null) {
      data['property'] = this.property!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.userServiceRenews != null) {
      data['user_service_renews'] = this.userServiceRenews!.toJson();
    }
    if (this.serviceProvider != null) {
      data['service_provider'] = this.serviceProvider!.toJson();
    }
    data['title'] = this.title;
    data['name'] = this.name;
    data['price'] = this.price;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['date'] = this.date;
    data['next_service_date'] = this.nextServiceDate;
    data['description'] = this.description;
    data['admin_status'] = this.adminStatus;
    data['admin_note'] = this.adminNote;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? location;
  Avatar? avatar;

  User(
      {this.id, this.name, this.email, this.phone, this.location, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    avatar = json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['location'] = this.location;
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
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

class Property {
  int? id;
  String? user;
  String? title;
  String? estDate;
  String? location;
  String? totalSpace;
  String? country;
  String? state;
  String? city;
  Avatar? image;
  String? createdAt;

  Property(
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

  Property.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    title = json['title'];
    estDate = json['est_date'];
    location = json['location'];
    totalSpace = json['total_space'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    image = json['image'] != null ? new Avatar.fromJson(json['image']) : null;
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
      data['image'] = this.image!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Service {
  int? id;
  String? title;
  Category? category;
  String? description;
  String? isBoost;
  Avatar? image;
  String? createdAt;

  Service(
      {this.id,
        this.title,
        this.category,
        this.description,
        this.isBoost,
        this.image,
        this.createdAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    description = json['description'];
    isBoost = json['is_boost'];
    image = json['image'] != null ? new Avatar.fromJson(json['image']) : null;
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

class UserServiceRenews {
  int? id;
  UserService? userService;
  User? user;
  Property? property;
  Service? service;
  ServiceProvider? serviceProvider;
  String? name;
  String? phone;
  String? location;
  String? date;
  String? nextServiceDate;
  String? description;
  String? status;
  String? note;
  String? amount;
  String? createdAt;

  UserServiceRenews(
      {this.id,
        this.userService,
        this.user,
        this.property,
        this.service,
        this.serviceProvider,
        this.name,
        this.phone,
        this.location,
        this.date,
        this.nextServiceDate,
        this.description,
        this.status,
        this.note,
        this.amount,
        this.createdAt});

  UserServiceRenews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userService = json['user_service'] != null ? new UserService.fromJson(json['user_service']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    property = json['property'] != null ? new Property.fromJson(json['property']) : null;
    service = json['service'] != null ? new Service.fromJson(json['service']) : null;
    //serviceProvider = json['service_provider'];
    serviceProvider = json['service_provider'] != null ? new ServiceProvider.fromJson(json['service_provider']) : null;
    name = json['name'];
    phone = json['phone'];
    location = json['location'];
    date = json['date'];
    nextServiceDate = json['next_service_date'];
    description = json['description'];
    status = json['status'];
    note = json['note'];
    amount = json['amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userService != null) {
      data['user_service'] = this.userService!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.property != null) {
      data['property'] = this.property!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['service_provider'] = this.serviceProvider;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['date'] = this.date;
    data['next_service_date'] = this.nextServiceDate;
    data['description'] = this.description;
    data['status'] = this.status;
    data['note'] = this.note;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class UserService {
  int? id;
  String? name;
  String? phone;
  String? location;
  String? date;
  String? createdAt;

  UserService(
      {this.id,
        this.name,
        this.phone,
        this.location,
        this.date,
        this.createdAt});

  UserService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    location = json['location'];
    date = json['date'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ServiceProvider {
  int? id;
  String? isFeatured;
  String? companyName;
  String? name;
  String? email;
  String? phone;
  String? location;
  User? user;
  Avatar? image;
  String? country;
  String? state;
  String? city;
  String? status;
  String? createdAt;

  ServiceProvider(
      {this.id,
        this.isFeatured,
        this.companyName,
        this.name,
        this.email,
        this.phone,
        this.location,
        this.user,
        this.image,
        this.country,
        this.state,
        this.city,
        this.status,
        this.createdAt});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isFeatured = json['is_featured'];
    companyName = json['company_name'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    //user = json['user'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    image = json['image'] != null ? new Avatar.fromJson(json['image']) : null;
    country = json['country'];
    state = json['state'];
    city = json['city'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_featured'] = this.isFeatured;
    data['company_name'] = this.companyName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['user'] = this.user;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}