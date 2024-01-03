class AddHealthRecordReqModel {
  String healthID;
  dynamic cowName;
  dynamic cowId;
  String healthCategory;
  String mobileNo;
  String farmerName;
  String cost;
  String report;
  String diagnosis;
  String vetId;
  String vetName;
  String recordType;
  String treatment;
  String treatmentDate;
  String diagnosisType;
  String prognosis;
  dynamic cowData;

  AddHealthRecordReqModel(
      {this.healthID = '',
      this.cowName,
      this.cowId,
      required this.healthCategory,
      required this.mobileNo,
      required this.farmerName,
      required this.cost,
      required this.report,
      required this.diagnosis,
      required this.vetId,
      required this.vetName,
      required this.recordType,
      required this.treatment,
      required this.treatmentDate,
      required this.diagnosisType,
      required this.prognosis,
      this.cowData});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = healthID;
    map['cow_data'] = cowData;
    map['cow_name'] = cowName;
    map['cow_id'] = cowId;
    map['health_category'] = healthCategory;
    map['mobile'] = mobileNo;
    map['farmer_name'] = farmerName;
    map['cost'] = cost;
    map['report'] = report;
    map['diagnosis'] = diagnosis;
    map['vet_id'] = vetId;
    map['vet_name'] = vetName;
    map['record_type'] = recordType;
    map['treatment'] = treatment;
    map['treatment_date'] = treatmentDate;
    map['diagnosis_type'] = diagnosisType;
    map['prognosis'] = prognosis;
    return map;
  }
}
