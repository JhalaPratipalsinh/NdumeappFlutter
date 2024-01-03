class RegistrationReqModel {
  final String vetFName;
  final String vetLName;
  final String vetSName;
  final String vetPhone;
  final String vetPassword;
  final String county;
  final String subCounty;
  final String ward;
  final String vetKvb;
  final double vetLat;
  final double vetLong;

  RegistrationReqModel(
      {required this.vetFName,
      required this.vetLName,
      required this.vetSName,
      required this.vetPhone,
      required this.vetPassword,
      required this.county,
      required this.subCounty,
      required this.ward,
      required this.vetKvb,
      required this.vetLat,
      required this.vetLong});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vet_fname'] = vetFName;
    map['vet_lname'] = vetLName;
    map['vet_sname'] = vetSName;
    map['vet_phone'] = vetPhone;
    map['vet_password'] = vetPassword;
    map['county'] = county;
    map['subcounty'] = subCounty;
    map['ward'] = ward;
    map['vet_kvb'] = vetKvb;
    map['vet_lat'] = 0.0;
    map['vet_long'] = 0.0;
    return map;
  }
}
