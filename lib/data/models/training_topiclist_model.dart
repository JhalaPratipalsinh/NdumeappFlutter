/// success : true
/// message : "Found"
/// topic : [{"id":2,"title":"TEsting 2 topic"},{"id":7,"title":"test topic 4"}]

class TrainingTopiclistModel {
  TrainingTopiclistModel({
      bool? success, 
      String? message, 
      List<Topics>? topic,}){
    _success = success;
    _message = message;
    _topic = topic;
}

  TrainingTopiclistModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _topic = [];
      json['data'].forEach((v) {
        _topic?.add(Topics.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Topics>? _topic;

  bool? get success => _success;
  String? get message => _message;
  List<Topics>? get topic => _topic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_topic != null) {
      map['data'] = _topic?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// title : "TEsting 2 topic"

class Topics {
  Topics({
      num? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  Topics.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
  }
  num? _id;
  String? _title;

  num? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    return map;
  }

}