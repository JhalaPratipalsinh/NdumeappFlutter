/// success : true
/// message : "Found"
/// categories : [{"id":3,"category_name":"NEW TRAININGS","created_at":null,"updated_at":"2023-08-26T05:16:20.000000Z"},{"id":4,"category_name":"UNGA FARM CARE","created_at":null,"updated_at":"2023-08-26T05:16:54.000000Z"},{"id":5,"category_name":"MERCYCORPS","created_at":"2023-08-25T12:28:07.000000Z","updated_at":"2023-08-26T05:17:12.000000Z"}]

class TrainingCategorylistModel {
  TrainingCategorylistModel({
      bool? success, 
      String? message, 
      List<CategoryList>? categories,}){
    _success = success;
    _message = message;
    _categories = categories;
}

  TrainingCategorylistModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _categories = [];
      json['data'].forEach((v) {
        _categories?.add(CategoryList.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<CategoryList>? _categories;

  bool? get success => _success;
  String? get message => _message;
  List<CategoryList>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_categories != null) {
      map['data'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 3
/// category_name : "NEW TRAININGS"
/// created_at : null
/// updated_at : "2023-08-26T05:16:20.000000Z"

class CategoryList {
  CategoryList({
      num? id, 
      String? categoryName, 
      dynamic createdAt, 
      String? updatedAt,}){
    _id = id;
    _categoryName = categoryName;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  CategoryList.fromJson(dynamic json) {
    _id = json['id'];
    _categoryName = json['category_name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _categoryName;
  dynamic _createdAt;
  String? _updatedAt;

  num? get id => _id;
  String? get categoryName => _categoryName;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_name'] = _categoryName;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}