/// success : true
/// message : "Found"
/// breeding : 28
/// health : 2
/// data : [{"farmer_vet_id":4716,"farmer_id":null,"farmer_name":"Pratipalsinh","mobile_number":"254708581236","vet_id":173,"county":"Bungoma","subcounty":"Kimilili","ward":"Kibingei"},{"farmer_vet_id":5033,"farmer_id":null,"farmer_name":"Pdtest","mobile_number":"254708581512","vet_id":173,"county":"Bungoma","subcounty":"Kanduyi","ward":"Marakaru/Tuuti"},{"farmer_vet_id":9107,"farmer_id":null,"farmer_name":"Test Pd","mobile_number":"254708581259","vet_id":173,"county":"Bungoma","subcounty":"Likuyani","ward":"Nzoia"},{"farmer_vet_id":10051,"farmer_id":null,"farmer_name":"Jay","mobile_number":"254708581987","vet_id":173,"county":"Kirinyaga","subcounty":"Kirinyaga Central","ward":"Mutira"},{"farmer_vet_id":11314,"farmer_id":null,"farmer_name":"Gideon TEST","mobile_number":"254729834003","vet_id":173,"county":"Taita Taveta","subcounty":"Mwatate","ward":"Bura"}]

class FarmerModel {
  FarmerModel({
    bool? success,
    String? message,
    int? breeding,
    int? health,
    List<FarmerData>? data,
  }) {
    _success = success;
    _message = message;
    _breeding = breeding;
    _health = health;
    _data = data;
  }

  FarmerModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _breeding = json['breeding'];
    _health = json['health'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FarmerData.fromJson(v));
      });
    }
  }

  bool? _success;
  String? _message;
  int? _breeding;
  int? _health;
  List<FarmerData>? _data;

  bool? get success => _success;

  String? get message => _message;

  int? get breeding => _breeding;

  int? get health => _health;

  List<FarmerData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['breeding'] = _breeding;
    map['health'] = _health;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// farmer_vet_id : 4716
/// farmer_id : null
/// farmer_name : "Pratipalsinh"
/// mobile_number : "254708581236"
/// vet_id : 173
/// county : "Bungoma"
/// subcounty : "Kimilili"
/// ward : "Kibingei"

class FarmerData {
  FarmerData({
    int? farmerVetId,
    dynamic farmerId,
    String? farmerName,
    String? mobileNumber,
    int? vetId,
    int? totalHealthRecord,
    int? totalBreedingRecord,
    String? county,
    String? subcounty,
    String? ward,
  }) {
    _farmerVetId = farmerVetId;
    _farmerId = farmerId;
    _farmerName = farmerName;
    _mobileNumber = mobileNumber;
    _vetId = vetId;
    _county = county;
    _subcounty = subcounty;
    _ward = ward;
    _totalHealthRecord = totalHealthRecord;
    _totalBreedingRecord = totalBreedingRecord;
  }

  FarmerData.fromJson(dynamic json) {
    _farmerVetId = json['farmer_vet_id'];
    _farmerId = json['farmer_id'];
    _farmerName = json['farmer_name'];
    _mobileNumber = json['mobile_number'];
    _vetId = json['vet_id'];
    _county = json['county'];
    _subcounty = json['subcounty'];
    _ward = json['ward'];
    _totalHealthRecord = json['total_health_record'];
    _totalBreedingRecord = json['total_breeding_record'];
  }

  int? _farmerVetId;
  dynamic _farmerId;
  String? _farmerName;
  String? _mobileNumber;
  int? _vetId;
  int? _totalHealthRecord;
  int? _totalBreedingRecord;
  String? _county;
  String? _subcounty;
  String? _ward;

  int? get farmerVetId => _farmerVetId;

  dynamic get farmerId => _farmerId;

  String? get farmerName => _farmerName;

  String? get mobileNumber => _mobileNumber;

  int? get vetId => _vetId;

  int? get totalHealthRecord => _totalHealthRecord;

  int? get totalBreedingRecord => _totalBreedingRecord;

  String? get county => _county;

  String? get subcounty => _subcounty;

  String? get ward => _ward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['farmer_vet_id'] = _farmerVetId;
    map['farmer_id'] = _farmerId;
    map['farmer_name'] = _farmerName;
    map['mobile_number'] = _mobileNumber;
    map['vet_id'] = _vetId;
    map['county'] = _county;
    map['subcounty'] = _subcounty;
    map['ward'] = _ward;
    map['total_health_record'] = _totalHealthRecord;
    map['total_breeding_record'] = _totalBreedingRecord;
    return map;
  }
}
