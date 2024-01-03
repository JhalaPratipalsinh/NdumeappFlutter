/// success : true
/// message : "Found"
/// data : {"detail":{"id":2,"admin_id":1,"category_id":3,"training_type":1,"post_owner":38,"title":"TEsting 2 topic","detail":"testingsss...","start_date":"2023-08-24 00:00:00","end_date":"2023-08-30 00:00:00","is_active":1,"created_at":"2023-08-25T09:30:47.000000Z","updated_at":"2023-08-25T09:30:47.000000Z","deleted_at":null},"gallery":[{"id":1,"training_id":2,"photo":"169295584834.png","type":"image","created_at":"2023-08-25T09:30:48.000000Z","updated_at":"2023-08-25T09:30:48.000000Z","deleted_at":null},{"id":2,"training_id":2,"photo":"169295627021.png","type":"image","created_at":"2023-08-25T09:37:50.000000Z","updated_at":"2023-08-25T09:37:50.000000Z","deleted_at":null}]}

class TrainingdetailModel {
  TrainingdetailModel({
      bool? success, 
      String? message, 
      Data? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  TrainingdetailModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  String? _message;
  Data? _data;

  bool? get success => _success;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// detail : {"id":2,"admin_id":1,"category_id":3,"training_type":1,"post_owner":38,"title":"TEsting 2 topic","detail":"testingsss...","start_date":"2023-08-24 00:00:00","end_date":"2023-08-30 00:00:00","is_active":1,"created_at":"2023-08-25T09:30:47.000000Z","updated_at":"2023-08-25T09:30:47.000000Z","deleted_at":null}
/// gallery : [{"id":1,"training_id":2,"photo":"169295584834.png","type":"image","created_at":"2023-08-25T09:30:48.000000Z","updated_at":"2023-08-25T09:30:48.000000Z","deleted_at":null},{"id":2,"training_id":2,"photo":"169295627021.png","type":"image","created_at":"2023-08-25T09:37:50.000000Z","updated_at":"2023-08-25T09:37:50.000000Z","deleted_at":null}]

class Data {
  Data({
      Detail? detail, 
      List<Gallery>? gallery,}){
    _detail = detail;
    _gallery = gallery;
}

  Data.fromJson(dynamic json) {
    _detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
    if (json['gallery'] != null) {
      _gallery = [];
      json['gallery'].forEach((v) {
        _gallery?.add(Gallery.fromJson(v));
      });
    }
  }
  Detail? _detail;
  List<Gallery>? _gallery;

  Detail? get detail => _detail;
  List<Gallery>? get gallery => _gallery;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_detail != null) {
      map['detail'] = _detail?.toJson();
    }
    if (_gallery != null) {
      map['gallery'] = _gallery?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// training_id : 2
/// photo : "169295584834.png"
/// type : "image"
/// created_at : "2023-08-25T09:30:48.000000Z"
/// updated_at : "2023-08-25T09:30:48.000000Z"
/// deleted_at : null

class Gallery {
  Gallery({
      num? id, 
      num? trainingId, 
      String? photo, 
      String? type, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt,}){
    _id = id;
    _trainingId = trainingId;
    _photo = photo;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  Gallery.fromJson(dynamic json) {
    _id = json['id'];
    _trainingId = json['training_id'];
    _photo = json['photo'];
    _type = json['type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  num? _id;
  num? _trainingId;
  String? _photo;
  String? _type;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;

  num? get id => _id;
  num? get trainingId => _trainingId;
  String? get photo => _photo;
  String? get type => _type;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['training_id'] = _trainingId;
    map['photo'] = _photo;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}

/// id : 2
/// admin_id : 1
/// category_id : 3
/// training_type : 1
/// post_owner : 38
/// title : "TEsting 2 topic"
/// detail : "testingsss..."
/// start_date : "2023-08-24 00:00:00"
/// end_date : "2023-08-30 00:00:00"
/// is_active : 1
/// created_at : "2023-08-25T09:30:47.000000Z"
/// updated_at : "2023-08-25T09:30:47.000000Z"
/// deleted_at : null

class Detail {
  Detail({
      num? id, 
      num? adminId, 
      num? categoryId, 
      num? trainingType, 
      num? postOwner, 
      String? title, 
      String? detail, 
      String? startDate, 
      String? endDate, 
      num? isActive, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt,}){
    _id = id;
    _adminId = adminId;
    _categoryId = categoryId;
    _trainingType = trainingType;
    _postOwner = postOwner;
    _title = title;
    _detail = detail;
    _startDate = startDate;
    _endDate = endDate;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  Detail.fromJson(dynamic json) {
    _id = json['id'];
    _adminId = json['admin_id'];
    _categoryId = json['category_id'];
    _trainingType = json['training_type'];
    _postOwner = json['post_owner'];
    _title = json['title'];
    _detail = json['detail'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  num? _id;
  num? _adminId;
  num? _categoryId;
  num? _trainingType;
  num? _postOwner;
  String? _title;
  String? _detail;
  String? _startDate;
  String? _endDate;
  num? _isActive;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;

  num? get id => _id;
  num? get adminId => _adminId;
  num? get categoryId => _categoryId;
  num? get trainingType => _trainingType;
  num? get postOwner => _postOwner;
  String? get title => _title;
  String? get detail => _detail;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  num? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['admin_id'] = _adminId;
    map['category_id'] = _categoryId;
    map['training_type'] = _trainingType;
    map['post_owner'] = _postOwner;
    map['title'] = _title;
    map['detail'] = _detail;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}