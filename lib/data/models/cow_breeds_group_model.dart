/// success : true
/// message : "Found"
/// cow_breeds : [{"id":1,"name":"Ayrshire"},{"id":2,"name":"Fresian"},{"id":3,"name":"Guensey"},{"id":4,"name":"Holstein"},{"id":5,"name":"Jersey"},{"id":6,"name":"Fleckvieh"},{"id":7,"name":"Boran"},{"id":8,"name":"Sahiwal"},{"id":9,"name":"zebu"},{"id":10,"name":"Brahman"},{"id":11,"name":"Brown Swiss"},{"id":12,"name":"Red freshian"},{"id":13,"name":"Crosses"}]
/// cow_groups : [{"id":1,"name":"Lactating"},{"id":2,"name":"Drying"},{"id":3,"name":"In Calf"},{"id":4,"name":"Heifer"}]

class CowBreedsGroupModel {
  CowBreedsGroupModel({
    bool? success,
    String? message,
    List<CowBreeds>? cowBreeds,
    List<CowGroups>? cowGroups,
  }) {
    _success = success;
    _message = message;
    _cowBreeds = cowBreeds;
    _cowGroups = cowGroups;
  }

  CowBreedsGroupModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _cowBreeds = [];
    _cowBreeds!.add(CowBreeds(id: 0, name: 'Select Breed'));
    if (json['cow_breeds'] != null) {
      json['cow_breeds'].forEach((v) {
        _cowBreeds?.add(CowBreeds.fromJson(v));
      });
    }
    _cowGroups = [];
    _cowGroups!.add(CowGroups(id: 0, name: 'Select Cow Group'));
    if (json['cow_groups'] != null) {
      json['cow_groups'].forEach((v) {
        _cowGroups?.add(CowGroups.fromJson(v));
      });
    }
  }

  bool? _success;
  String? _message;
  List<CowBreeds>? _cowBreeds;
  List<CowGroups>? _cowGroups;

  bool? get success => _success;

  String? get message => _message;

  List<CowBreeds>? get cowBreeds => _cowBreeds;

  List<CowGroups>? get cowGroups => _cowGroups;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_cowBreeds != null) {
      map['cow_breeds'] = _cowBreeds?.map((v) => v.toJson()).toList();
    }
    if (_cowGroups != null) {
      map['cow_groups'] = _cowGroups?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "Lactating"

class CowGroups {
  CowGroups({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  CowGroups.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  int? _id;
  String? _name;

  int? get id => _id;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

/// id : 1
/// name : "Ayrshire"

class CowBreeds {
  CowBreeds({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  CowBreeds.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  int? _id;
  String? _name;

  int? get id => _id;

  String? get name => _name;

  void setParams(String name, int id) {
    _name = name;
    _id = id;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
