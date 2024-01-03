/// success : true
/// message : "Found"
/// cow_records : [{"id":2209,"firebase_id":"2547085812361446","sid":null,"breed_id":"1","group_id":"1","mobile_number":"254708581236","title":"test cow 25","ear_code":"123654","date_of_birth":"10/01/18","calving_lactation":null,"dam":"abc","dam_code":"123","dam_father":"xyz","dam_father_code":"12345","dam_id":null,"dam_mother":"hhh","dam_mother_code":"3521","sire":"jjj","sire_code":"632","sire_father":"kkk","sire_father_code":"369","sire_mother":"lll","sire_mother_code":"2352","status":"sold","sync_at":"2018-07-27 12:07:78.784","firebase_json":"{\"id\": 1446, \"dam\": \"abc\", \"sire\": \"jjj\", \"title\": \"test cow 25\", \"status\": \"sold\", \"sync_at\": \"2018-07-27 12:07:78.784\", \"breed_id\": 1, \"dam_code\": \"123\", \"ear_code\": \"123654\", \"group_id\": 1, \"sire_code\": \"632\", \"created_at\": \"2018-07-27 12:07:78.784\", \"dam_father\": \"xyz\", \"dam_mother\": \"hhh\", \"updated_at\": \"2018-07-27 12:07:78.784\", \"sire_father\": \"kkk\", \"sire_mother\": \"lll\", \"date_of_birth\": \"10/01/18\", \"mobile_number\": \"254708581236\", \"dam_father_code\": \"12345\", \"dam_mother_code\": \"3521\", \"sire_father_code\": \"369\", \"sire_mother_code\": \"2352\", \"calving_lactation\": \"1\"}","created_at":null,"updated_at":null,"deleted_at":null}]
/// calf_records : [{"id":58,"sid":"2412","firebase_id":"2547085812362412","breed_id":"88","calf_code":"","calf_name":"test p calf","calf_weight":"50","d_o_b":"2022-07-07 00:00:00","dam":"","dam_code":"","dam_father":"","dam_father_code":"","dam_id":"","dam_mother":"","dam_mother_code":"","expected_mature_date":"2023-04-14 00:00:00","mobile_number":"254708581236","sex":"Bull","sire":"","sire_code":"","sire_father":"","sire_father_code":"","sire_mother":"","sire_mother_code":"","status":"active","sync_at":"2022-07-07 12:07:68.688","firebase_json":"{\"id\": 2412, \"dam\": \"\", \"sex\": \"Bull\", \"sire\": \"\", \"d_o_b\": \"2022-07-07 00:00:00.000\", \"dam_id\": \"\", \"status\": \"active\", \"sync_at\": \"2022-07-07 12:07:68.688\", \"breed_id\": \"88\", \"dam_code\": \"\", \"calf_code\": \"\", \"calf_name\": \"test p calf\", \"sire_code\": \"\", \"created_at\": \"2022-07-07 12:07:68.688\", \"dam_father\": \"\", \"dam_mother\": \"\", \"updated_at\": \"2022-07-07 12:07:68.688\", \"calf_weight\": \"50\", \"sire_father\": \"\", \"sire_mother\": \"\", \"mobile_number\": \"254708581236\", \"dam_father_code\": \"\", \"dam_mother_code\": \"\", \"sire_father_code\": \"\", \"sire_mother_code\": \"\", \"expected_mature_date\": \"2023-04-14 00:00:00.000\"}","created_at":null,"updated_at":null,"deleted_at":null}]

class CowListModel {
  CowListModel({
    bool? success,
    String? message,
    List<CowRecordsModel>? cowRecords,
    /*List<CowRecords>? calfRecords,*/
  }) {
    _success = success;
    _message = message;
    _cowRecords = cowRecords;
    /*_calfRecords = calfRecords;*/
  }

  CowListModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _cowRecords = [];
    if (json['cow_records'] != null) {
      json['cow_records'].forEach((v) {
        _cowRecords?.add(CowRecordsModel.fromJson(v));
      });
    }
    if (json['calf_records'] != null) {
      json['calf_records'].forEach((v) {
        dynamic json = v;
        int? id = json['id'];
        String? calfName = json['calf_name'];
        final cowRecord = CowRecordsModel(id: id, title: calfName);
        _cowRecords?.add(cowRecord);
      });
    }
  }

  bool? _success;
  String? _message;
  List<CowRecordsModel>? _cowRecords;

  bool? get success => _success;

  String? get message => _message;

  List<CowRecordsModel>? get cowRecords => _cowRecords;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_cowRecords != null) {
      map['cow_records'] = _cowRecords?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 58
/// sid : "2412"
/// firebase_id : "2547085812362412"
/// breed_id : "88"
/// calf_code : ""
/// calf_name : "test p calf"
/// calf_weight : "50"
/// d_o_b : "2022-07-07 00:00:00"
/// dam : ""
/// dam_code : ""
/// dam_father : ""
/// dam_father_code : ""
/// dam_id : ""
/// dam_mother : ""
/// dam_mother_code : ""
/// expected_mature_date : "2023-04-14 00:00:00"
/// mobile_number : "254708581236"
/// sex : "Bull"
/// sire : ""
/// sire_code : ""
/// sire_father : ""
/// sire_father_code : ""
/// sire_mother : ""
/// sire_mother_code : ""
/// status : "active"
/// sync_at : "2022-07-07 12:07:68.688"
/// firebase_json : "{\"id\": 2412, \"dam\": \"\", \"sex\": \"Bull\", \"sire\": \"\", \"d_o_b\": \"2022-07-07 00:00:00.000\", \"dam_id\": \"\", \"status\": \"active\", \"sync_at\": \"2022-07-07 12:07:68.688\", \"breed_id\": \"88\", \"dam_code\": \"\", \"calf_code\": \"\", \"calf_name\": \"test p calf\", \"sire_code\": \"\", \"created_at\": \"2022-07-07 12:07:68.688\", \"dam_father\": \"\", \"dam_mother\": \"\", \"updated_at\": \"2022-07-07 12:07:68.688\", \"calf_weight\": \"50\", \"sire_father\": \"\", \"sire_mother\": \"\", \"mobile_number\": \"254708581236\", \"dam_father_code\": \"\", \"dam_mother_code\": \"\", \"sire_father_code\": \"\", \"sire_mother_code\": \"\", \"expected_mature_date\": \"2023-04-14 00:00:00.000\"}"
/// created_at : null
/// updated_at : null
/// deleted_at : null

class CalfRecords {
  CalfRecords({
    int? id,
    String? sid,
    String? firebaseId,
    String? breedId,
    String? calfCode,
    String? calfName,
    String? calfWeight,
    String? dOB,
    String? dam,
    String? damCode,
    String? damFather,
    String? damFatherCode,
    String? damId,
    String? damMother,
    String? damMotherCode,
    String? expectedMatureDate,
    String? mobileNumber,
    String? sex,
    String? sire,
    String? sireCode,
    String? sireFather,
    String? sireFatherCode,
    String? sireMother,
    String? sireMotherCode,
    String? status,
    String? syncAt,
    String? firebaseJson,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
  }) {
    _id = id;
    _sid = sid;
    _firebaseId = firebaseId;
    _breedId = breedId;
    _calfCode = calfCode;
    _calfName = calfName;
    _calfWeight = calfWeight;
    _dOB = dOB;
    _dam = dam;
    _damCode = damCode;
    _damFather = damFather;
    _damFatherCode = damFatherCode;
    _damId = damId;
    _damMother = damMother;
    _damMotherCode = damMotherCode;
    _expectedMatureDate = expectedMatureDate;
    _mobileNumber = mobileNumber;
    _sex = sex;
    _sire = sire;
    _sireCode = sireCode;
    _sireFather = sireFather;
    _sireFatherCode = sireFatherCode;
    _sireMother = sireMother;
    _sireMotherCode = sireMotherCode;
    _status = status;
    _syncAt = syncAt;
    _firebaseJson = firebaseJson;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  CalfRecords.fromJson(dynamic json) {
    _id = json['id'];
    _sid = json['sid'];
    _firebaseId = json['firebase_id'];
    _breedId = json['breed_id'];
    _calfCode = json['calf_code'];
    _calfName = json['calf_name'];
    _calfWeight = json['calf_weight'];
    _dOB = json['d_o_b'];
    _dam = json['dam'];
    _damCode = json['dam_code'];
    _damFather = json['dam_father'];
    _damFatherCode = json['dam_father_code'];
    _damId = json['dam_id'];
    _damMother = json['dam_mother'];
    _damMotherCode = json['dam_mother_code'];
    _expectedMatureDate = json['expected_mature_date'];
    _mobileNumber = json['mobile_number'];
    _sex = json['sex'];
    _sire = json['sire'];
    _sireCode = json['sire_code'];
    _sireFather = json['sire_father'];
    _sireFatherCode = json['sire_father_code'];
    _sireMother = json['sire_mother'];
    _sireMotherCode = json['sire_mother_code'];
    _status = json['status'];
    _syncAt = json['sync_at'];
    _firebaseJson = json['firebase_json'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }

  int? _id;
  String? _sid;
  String? _firebaseId;
  String? _breedId;
  String? _calfCode;
  String? _calfName;
  String? _calfWeight;
  String? _dOB;
  String? _dam;
  String? _damCode;
  String? _damFather;
  String? _damFatherCode;
  String? _damId;
  String? _damMother;
  String? _damMotherCode;
  String? _expectedMatureDate;
  String? _mobileNumber;
  String? _sex;
  String? _sire;
  String? _sireCode;
  String? _sireFather;
  String? _sireFatherCode;
  String? _sireMother;
  String? _sireMotherCode;
  String? _status;
  String? _syncAt;
  String? _firebaseJson;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;

  int? get id => _id;

  String? get sid => _sid;

  String? get firebaseId => _firebaseId;

  String? get breedId => _breedId;

  String? get calfCode => _calfCode;

  String? get calfName => _calfName;

  String? get calfWeight => _calfWeight;

  String? get dOB => _dOB;

  String? get dam => _dam;

  String? get damCode => _damCode;

  String? get damFather => _damFather;

  String? get damFatherCode => _damFatherCode;

  String? get damId => _damId;

  String? get damMother => _damMother;

  String? get damMotherCode => _damMotherCode;

  String? get expectedMatureDate => _expectedMatureDate;

  String? get mobileNumber => _mobileNumber;

  String? get sex => _sex;

  String? get sire => _sire;

  String? get sireCode => _sireCode;

  String? get sireFather => _sireFather;

  String? get sireFatherCode => _sireFatherCode;

  String? get sireMother => _sireMother;

  String? get sireMotherCode => _sireMotherCode;

  String? get status => _status;

  String? get syncAt => _syncAt;

  String? get firebaseJson => _firebaseJson;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sid'] = _sid;
    map['firebase_id'] = _firebaseId;
    map['breed_id'] = _breedId;
    map['calf_code'] = _calfCode;
    map['calf_name'] = _calfName;
    map['calf_weight'] = _calfWeight;
    map['d_o_b'] = _dOB;
    map['dam'] = _dam;
    map['dam_code'] = _damCode;
    map['dam_father'] = _damFather;
    map['dam_father_code'] = _damFatherCode;
    map['dam_id'] = _damId;
    map['dam_mother'] = _damMother;
    map['dam_mother_code'] = _damMotherCode;
    map['expected_mature_date'] = _expectedMatureDate;
    map['mobile_number'] = _mobileNumber;
    map['sex'] = _sex;
    map['sire'] = _sire;
    map['sire_code'] = _sireCode;
    map['sire_father'] = _sireFather;
    map['sire_father_code'] = _sireFatherCode;
    map['sire_mother'] = _sireMother;
    map['sire_mother_code'] = _sireMotherCode;
    map['status'] = _status;
    map['sync_at'] = _syncAt;
    map['firebase_json'] = _firebaseJson;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }
}

/// id : 2209
/// firebase_id : "2547085812361446"
/// sid : null
/// breed_id : "1"
/// group_id : "1"
/// mobile_number : "254708581236"
/// title : "test cow 25"
/// ear_code : "123654"
/// date_of_birth : "10/01/18"
/// calving_lactation : null
/// dam : "abc"
/// dam_code : "123"
/// dam_father : "xyz"
/// dam_father_code : "12345"
/// dam_id : null
/// dam_mother : "hhh"
/// dam_mother_code : "3521"
/// sire : "jjj"
/// sire_code : "632"
/// sire_father : "kkk"
/// sire_father_code : "369"
/// sire_mother : "lll"
/// sire_mother_code : "2352"
/// status : "sold"
/// sync_at : "2018-07-27 12:07:78.784"
/// firebase_json : "{\"id\": 1446, \"dam\": \"abc\", \"sire\": \"jjj\", \"title\": \"test cow 25\", \"status\": \"sold\", \"sync_at\": \"2018-07-27 12:07:78.784\", \"breed_id\": 1, \"dam_code\": \"123\", \"ear_code\": \"123654\", \"group_id\": 1, \"sire_code\": \"632\", \"created_at\": \"2018-07-27 12:07:78.784\", \"dam_father\": \"xyz\", \"dam_mother\": \"hhh\", \"updated_at\": \"2018-07-27 12:07:78.784\", \"sire_father\": \"kkk\", \"sire_mother\": \"lll\", \"date_of_birth\": \"10/01/18\", \"mobile_number\": \"254708581236\", \"dam_father_code\": \"12345\", \"dam_mother_code\": \"3521\", \"sire_father_code\": \"369\", \"sire_mother_code\": \"2352\", \"calving_lactation\": \"1\"}"
/// created_at : null
/// updated_at : null
/// deleted_at : null

class CowRecordsModel {
  int? id;
  String? title;

  CowRecordsModel({
    this.id,
    this.title,
  });

  CowRecordsModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}
