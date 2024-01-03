/// success : true
/// message : "Found"
/// paid_breeding_record : [{"id":26860,"farmer_vet_id":null,"sid":null,"firebase_id":null,"bull_code":"test","bull_name":"test","cost":"200","cow_id":"35764","cow_name":"test pp","drying_date":"2023-08-01 00:00:00","expected_date_of_birth":"2023-10-09 00:00:00","expected_repeat_date":"2023-01-19 00:00:00","farmer_name":"Pratipalsinh","mobile":"254708581236","no_straw":"2","pg_status":null,"pregnancy_date":"2023-04-01 00:00:00","record_type":"ndume","repeats":"0","semen_type":"Local Semen","sex_type":"Non-sexed","straw_breed":"6","strimingup_date":"2023-09-01 00:00:00","sync_at":"2023-01-01 00:00:00","vet_id":"805","vet_name":"pratipal","date_dt":"2023-01-01","is_verified":1,"wallet_amount":5,"is_paid":1,"withdraw_id":2,"firebase_json":null,"verified_by":"VIvek","disqualified_comment":null,"first_heat":"2023-10-23 00:00:00","second_heat":"2023-12-03 00:00:00","created_at":"2023-01-19T13:21:21.000000Z","updated_at":"2023-04-07T06:24:26.000000Z","deleted_at":null}]

class PaidBreedingRecordModel {
  PaidBreedingRecordModel({
      bool? success, 
      String? message, 
      List<PaidBreedingRecord>? paidBreedingRecord,}){
    _success = success;
    _message = message;
    _paidBreedingRecord = paidBreedingRecord;
}

  PaidBreedingRecordModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['paid_breeding_record'] != null) {
      _paidBreedingRecord = [];
      json['paid_breeding_record'].forEach((v) {
        _paidBreedingRecord?.add(PaidBreedingRecord.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<PaidBreedingRecord>? _paidBreedingRecord;
PaidBreedingRecordModel copyWith({  bool? success,
  String? message,
  List<PaidBreedingRecord>? paidBreedingRecord,
}) => PaidBreedingRecordModel(  success: success ?? _success,
  message: message ?? _message,
  paidBreedingRecord: paidBreedingRecord ?? _paidBreedingRecord,
);
  bool? get success => _success;
  String? get message => _message;
  List<PaidBreedingRecord>? get paidBreedingRecord => _paidBreedingRecord;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_paidBreedingRecord != null) {
      map['paid_breeding_record'] = _paidBreedingRecord?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 26860
/// farmer_vet_id : null
/// sid : null
/// firebase_id : null
/// bull_code : "test"
/// bull_name : "test"
/// cost : "200"
/// cow_id : "35764"
/// cow_name : "test pp"
/// drying_date : "2023-08-01 00:00:00"
/// expected_date_of_birth : "2023-10-09 00:00:00"
/// expected_repeat_date : "2023-01-19 00:00:00"
/// farmer_name : "Pratipalsinh"
/// mobile : "254708581236"
/// no_straw : "2"
/// pg_status : null
/// pregnancy_date : "2023-04-01 00:00:00"
/// record_type : "ndume"
/// repeats : "0"
/// semen_type : "Local Semen"
/// sex_type : "Non-sexed"
/// straw_breed : "6"
/// strimingup_date : "2023-09-01 00:00:00"
/// sync_at : "2023-01-01 00:00:00"
/// vet_id : "805"
/// vet_name : "pratipal"
/// date_dt : "2023-01-01"
/// is_verified : 1
/// wallet_amount : 5
/// is_paid : 1
/// withdraw_id : 2
/// firebase_json : null
/// verified_by : "VIvek"
/// disqualified_comment : null
/// first_heat : "2023-10-23 00:00:00"
/// second_heat : "2023-12-03 00:00:00"
/// created_at : "2023-01-19T13:21:21.000000Z"
/// updated_at : "2023-04-07T06:24:26.000000Z"
/// deleted_at : null
class PaidBreedingRecord {
  PaidBreedingRecord({
    int? id,
    String? bullCode,
    String? bullName,
    String? cost,
    String? cowId,
    String? cowName,
    String? dryingDate,
    String? expectedDateOfBirth,
    String? expectedRepeatDate,
    String? farmerName,
    String? mobile,
    String? noStraw,
    String? pgStatus,
    String? pregnancyDate,
    String? recordType,
    String? repeats,
    String? semenType,
    String? sexType,
    String? strawBreed,
    String? strimingupDate,
    String? syncAt,
    String? vetId,
    String? vetName,
    String? dateDt,
    dynamic isVerified,
    dynamic walletAmount,
    String? firstHeat,
    String? secondHeat,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
  }) {
    _id = id;
    _bullCode = bullCode;
    _bullName = bullName;
    _cost = cost;
    _cowId = cowId;
    _cowName = cowName;
    _dryingDate = dryingDate;
    _expectedDateOfBirth = expectedDateOfBirth;
    _expectedRepeatDate = expectedRepeatDate;
    _farmerName = farmerName;
    _mobile = mobile;
    _noStraw = noStraw;
    _pgStatus = pgStatus;
    _pregnancyDate = pregnancyDate;
    _recordType = recordType;
    _repeats = repeats;
    _semenType = semenType;
    _sexType = sexType;
    _strawBreed = strawBreed;
    _strimingupDate = strimingupDate;
    _syncAt = syncAt;
    _vetId = vetId;
    _vetName = vetName;
    _dateDt = dateDt;
    _isVerified = isVerified;
    _walletAmount = walletAmount;
    _firstHeat = firstHeat;
    _secondHeat = secondHeat;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  PaidBreedingRecord.fromJson(dynamic json) {
    _id = json['id'];
    _bullCode = json['bull_code'];
    _bullName = json['bull_name'];
    _cost = json['cost'];
    _cowId = json['cow_id'];
    _cowName = json['cow_name'];
    _dryingDate = json['drying_date'];
    _expectedDateOfBirth = json['expected_date_of_birth'];
    _expectedRepeatDate = json['expected_repeat_date'];
    _farmerName = json['farmer_name'];
    _mobile = json['mobile'];
    _noStraw = json['no_straw'];
    if (json['pg_status'] != null) {
      _pgStatus = json['pg_status'];
    }
    _pregnancyDate = json['pregnancy_date'];
    _recordType = json['record_type'];
    _repeats = json['repeats'];
    _semenType = json['semen_type'];
    _sexType = json['sex_type'];
    _strawBreed = json['straw_breed'];
    _strimingupDate = json['strimingup_date'];
    _syncAt = json['sync_at'];
    _vetId = json['vet_id'];
    _vetName = json['vet_name'];
    _dateDt = json['date_dt'];
    _isVerified = json['is_verified'];
    _walletAmount = json['wallet_amount'];
    _firstHeat = json['first_heat'];
    _secondHeat = json['second_heat'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }

  int? _id;
  String? _bullCode;
  String? _bullName;
  String? _cost;
  String? _cowId;
  String? _cowName;
  String? _dryingDate;
  String? _expectedDateOfBirth;
  String? _expectedRepeatDate;
  String? _farmerName;
  String? _mobile;
  String? _noStraw;
  String? _pgStatus;
  String? _pregnancyDate;
  String? _recordType;
  String? _repeats;
  String? _semenType;
  String? _sexType;
  String? _strawBreed;
  String? _strimingupDate;
  String? _syncAt;
  String? _vetId;
  String? _vetName;
  String? _dateDt;
  dynamic _isVerified;
  dynamic _walletAmount;
  String? _firstHeat;
  String? _secondHeat;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;

  int? get id => _id;

  String? get bullCode => _bullCode;

  String? get bullName => _bullName;

  String? get cost => _cost;

  String? get cowId => _cowId;

  String? get cowName => _cowName;

  String? get dryingDate => _dryingDate;

  String? get expectedDateOfBirth => _expectedDateOfBirth;

  String? get expectedRepeatDate => _expectedRepeatDate;

  String? get farmerName => _farmerName;

  String? get mobile => _mobile;

  String? get noStraw => _noStraw;

  String? get pgStatus => _pgStatus;

  String? get pregnancyDate => _pregnancyDate;

  String? get recordType => _recordType;

  String? get repeats => _repeats;

  String? get semenType => _semenType;

  String? get sexType => _sexType;

  String? get strawBreed => _strawBreed;

  String? get strimingupDate => _strimingupDate;

  String? get syncAt => _syncAt;

  String? get vetId => _vetId;

  String? get vetName => _vetName;

  String? get dateDt => _dateDt;

  dynamic get isVerified => _isVerified;

  dynamic get walletAmount => _walletAmount;

  String? get firstHeat => _firstHeat;

  String? get secondHeat => _secondHeat;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['bull_code'] = _bullCode;
    map['bull_name'] = _bullName;
    map['cost'] = _cost;
    map['cow_id'] = _cowId;
    map['cow_name'] = _cowName;
    map['drying_date'] = _dryingDate;
    map['expected_date_of_birth'] = _expectedDateOfBirth;
    map['expected_repeat_date'] = _expectedRepeatDate;
    map['farmer_name'] = _farmerName;
    map['mobile'] = _mobile;
    map['no_straw'] = _noStraw;
    map['pg_status'] = _pgStatus;
    map['pregnancy_date'] = _pregnancyDate;
    map['record_type'] = _recordType;
    map['repeats'] = _repeats;
    map['semen_type'] = _semenType;
    map['sex_type'] = _sexType;
    map['straw_breed'] = _strawBreed;
    map['strimingup_date'] = _strimingupDate;
    map['sync_at'] = _syncAt;
    map['vet_id'] = _vetId;
    map['vet_name'] = _vetName;
    map['date_dt'] = _dateDt;
    map['is_verified'] = _isVerified;
    map['wallet_amount'] = _walletAmount;
    map['first_heat'] = _firstHeat;
    map['second_heat'] = _secondHeat;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }
}
