/// success : true
/// message : "Found"
/// paid_health_record : [{"id":9503,"farmer_vet_id":null,"sid":null,"firebase_id":null,"cost":100,"cow_id":"36042","cow_name":"melon","diagnosis":null,"report":null,"diagnosis_type":null,"prognosis":null,"farmer_name":"valary","health_category":"Vaccine","mobile":"254716560703","record_type":"ndume","treatment":"LSD","treatment_date":"2023-02-13 00:00:00","vet_id":"802","vet_name":"VALARY","is_verified":1,"wallet_amount":5,"is_paid":1,"withdraw_id":3,"firebase_json":null,"verified_by":"Linkey","disqualified_comment":null,"created_at":"2023-02-13T11:01:43.000000Z","updated_at":"2023-04-07T08:36:44.000000Z","deleted_at":null},{"id":9504,"farmer_vet_id":null,"sid":null,"firebase_id":null,"cost":100,"cow_id":"36044","cow_name":"mbadi","diagnosis":null,"report":null,"diagnosis_type":null,"prognosis":null,"farmer_name":"valary","health_category":"Vaccine","mobile":"254716560703","record_type":"ndume","treatment":"LSD","treatment_date":"2023-02-13 00:00:00","vet_id":"802","vet_name":"VALARY","is_verified":1,"wallet_amount":5,"is_paid":1,"withdraw_id":3,"firebase_json":null,"verified_by":"Linkey","disqualified_comment":null,"created_at":"2023-02-13T11:01:43.000000Z","updated_at":"2023-04-07T08:36:44.000000Z","deleted_at":null},{"id":9790,"farmer_vet_id":null,"sid":null,"firebase_id":null,"cost":400,"cow_id":"36016","cow_name":"bat","diagnosis":"test diagnosis","report":"test general","diagnosis_type":"General Diagnosis","prognosis":"Good","farmer_name":"valary","health_category":"Treatment","mobile":"254716560703","record_type":"ndume","treatment":"test treatment","treatment_date":"2023-03-17 00:00:00","vet_id":"802","vet_name":"VALARY","is_verified":1,"wallet_amount":5,"is_paid":1,"withdraw_id":3,"firebase_json":null,"verified_by":"Linkey","disqualified_comment":null,"created_at":"2023-03-17T05:14:42.000000Z","updated_at":"2023-04-07T08:36:44.000000Z","deleted_at":null},{"id":9863,"farmer_vet_id":null,"sid":null,"firebase_id":null,"cost":600,"cow_id":"41115","cow_name":"dota","diagnosis":null,"report":null,"diagnosis_type":null,"prognosis":null,"farmer_name":"valary","health_category":"Vaccine","mobile":"254716560703","record_type":"ndume","treatment":"BQ/Anthrax","treatment_date":"2023-04-04 00:00:00","vet_id":"802","vet_name":"VALARY","is_verified":1,"wallet_amount":5,"is_paid":1,"withdraw_id":3,"firebase_json":null,"verified_by":"Linkey","disqualified_comment":null,"created_at":"2023-04-04T10:06:54.000000Z","updated_at":"2023-04-07T08:36:44.000000Z","deleted_at":null},{"id":9864,"farmer_vet_id":null,"sid":null,"firebase_id":null,"cost":600,"cow_id":"41114","cow_name":"dollar","diagnosis":null,"report":null,"diagnosis_type":null,"prognosis":null,"farmer_name":"valary","health_category":"Vaccine","mobile":"254716560703","record_type":"ndume","treatment":"BQ/Anthrax","treatment_date":"2023-04-04 00:00:00","vet_id":"802","vet_name":"VALARY","is_verified":1,"wallet_amount":5,"is_paid":1,"withdraw_id":3,"firebase_json":null,"verified_by":"Linkey","disqualified_comment":null,"created_at":"2023-04-04T10:06:55.000000Z","updated_at":"2023-04-07T08:36:44.000000Z","deleted_at":null}]

class PaidHealthRecordModel {
  PaidHealthRecordModel({
      bool? success, 
      String? message, 
      List<PaidHealthRecord>? paidHealthRecord,}){
    _success = success;
    _message = message;
    _paidHealthRecord = paidHealthRecord;
}

  PaidHealthRecordModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['paid_health_record'] != null) {
      _paidHealthRecord = [];
      json['paid_health_record'].forEach((v) {
        _paidHealthRecord?.add(PaidHealthRecord.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<PaidHealthRecord>? _paidHealthRecord;
PaidHealthRecordModel copyWith({  bool? success,
  String? message,
  List<PaidHealthRecord>? paidHealthRecord,
}) => PaidHealthRecordModel(  success: success ?? _success,
  message: message ?? _message,
  paidHealthRecord: paidHealthRecord ?? _paidHealthRecord,
);
  bool? get success => _success;
  String? get message => _message;
  List<PaidHealthRecord>? get paidHealthRecord => _paidHealthRecord;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_paidHealthRecord != null) {
      map['paid_health_record'] = _paidHealthRecord?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 9503
/// farmer_vet_id : null
/// sid : null
/// firebase_id : null
/// cost : 100
/// cow_id : "36042"
/// cow_name : "melon"
/// diagnosis : null
/// report : null
/// diagnosis_type : null
/// prognosis : null
/// farmer_name : "valary"
/// health_category : "Vaccine"
/// mobile : "254716560703"
/// record_type : "ndume"
/// treatment : "LSD"
/// treatment_date : "2023-02-13 00:00:00"
/// vet_id : "802"
/// vet_name : "VALARY"
/// is_verified : 1
/// wallet_amount : 5
/// is_paid : 1
/// withdraw_id : 3
/// firebase_json : null
/// verified_by : "Linkey"
/// disqualified_comment : null
/// created_at : "2023-02-13T11:01:43.000000Z"
/// updated_at : "2023-04-07T08:36:44.000000Z"
/// deleted_at : null

class PaidHealthRecord {
  PaidHealthRecord({
    int? id,
    int? cost,
    String? cowId,
    String? cowName,
    String? diagnosis,
    dynamic report,
    dynamic farmerName,
    String? healthCategory,
    String? mobile,
    dynamic recordType,
    String? treatment,
    String? treatmentDate,
    dynamic vetId,
    dynamic vetName,
    dynamic isVerified,
    dynamic walletAmount,
    dynamic createdAt,
    dynamic diagnosisType,
    dynamic prognosis,
  }) {
    _id = id;
    _cost = cost;
    _cowId = cowId;
    _cowName = cowName;
    _diagnosis = diagnosis;
    _report = report;
    _farmerName = farmerName;
    _healthCategory = healthCategory;
    _mobile = mobile;
    _recordType = recordType;
    _treatment = treatment;
    _treatmentDate = treatmentDate;
    _vetId = vetId;
    _vetName = vetName;
    _isVerified = isVerified;
    _walletAmount = walletAmount;
    _createdAt = createdAt;
    _diagnosisType = diagnosisType;
    _prognosis = prognosis;
  }

  PaidHealthRecord.fromJson(dynamic json) {
    _id = json['id']==null ? "":json['id'];
    _cost = json['cost']==null ? "":json['cost'];
    _cowId = json['cow_id']==null ? "" : json['cow_id'];
    _cowName = json['cow_name']== null ? "" : json['cow_name'];
    _diagnosis = json['diagnosis']== null ? "" : json['diagnosis'];
    _report = json['report']==null ? "" : json['report'];
    _farmerName = json['farmer_name'] ==null ? "" : json['farmer_name'];
    _healthCategory = json['health_category']==null ? "" : json['health_category'];
    _mobile = json['mobile']==null ? "" : json['mobile'];
    _recordType = json['record_type']==null ? "" : json['record_type'];
    _treatment = json['treatment']==null ? "" : json['treatment'];
    _treatmentDate = json['treatment_date']==null ? "" : json['treatment_date'];
    _vetId = json['vet_id']==null ? "" : json['vet_id'];
    _vetName = json['vet_name']==null ? "" : json['vet_name'];
    _isVerified = json['is_verified']==null ? "" : json['is_verified'];
    _walletAmount = json['wallet_amount']==null ? "" : json['wallet_amount'];
    _createdAt = json['created_at']==null ? "" : json['created_at'];
    _diagnosisType = json['diagnosis_type']==null ? "" : json['diagnosis_type'];
    _prognosis = json['prognosis']==null ? "" : json['prognosis'];
  }

  int? _id;
  int? _cost;
  String? _cowId;
  String? _cowName;
  String? _diagnosis;
  dynamic _report;
  dynamic _farmerName;
  String? _healthCategory;
  String? _mobile;
  dynamic _recordType;
  String? _treatment;
  String? _treatmentDate;
  dynamic _vetId;
  dynamic _vetName;
  dynamic _isVerified;
  dynamic _walletAmount;
  dynamic _createdAt;
  dynamic _diagnosisType;
  dynamic _prognosis;

  int? get id => _id;

  int? get cost => _cost;

  String? get cowId => _cowId;

  String? get cowName => _cowName;

  String? get diagnosis => _diagnosis;

  dynamic get report => _report;

  dynamic get farmerName => _farmerName;

  String? get healthCategory => _healthCategory;

  String? get mobile => _mobile;

  dynamic get recordType => _recordType;

  String? get treatment => _treatment;

  String? get treatmentDate => _treatmentDate;

  dynamic get vetId => _vetId;

  dynamic get vetName => _vetName;

  dynamic get isVerified => _isVerified;

  dynamic get walletAmount => _walletAmount;

  dynamic get createdAt => _createdAt;

  dynamic get diagnosisType => _diagnosisType;

  dynamic get prognosis => _prognosis;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cost'] = _cost;
    map['cow_id'] = _cowId;
    map['cow_name'] = _cowName;
    map['diagnosis'] = _diagnosis;
    map['report'] = _report;
    map['farmer_name'] = _farmerName;
    map['health_category'] = _healthCategory;
    map['mobile'] = _mobile;
    map['record_type'] = _recordType;
    map['treatment'] = _treatment;
    map['treatment_date'] = _treatmentDate;
    map['vet_id'] = _vetId;
    map['vet_name'] = _vetName;
    map['is_verified'] = _isVerified;
    map['wallet_amount'] = _walletAmount;
    map['created_at'] = _createdAt;
    return map;
  }
}
