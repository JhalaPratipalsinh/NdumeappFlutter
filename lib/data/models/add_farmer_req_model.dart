class AddFarmerReqModel {
  final String farmerName;
  final String mobileNumber;
  final String county;
  final String subCounty;
  final String ward;
  double latitude;
  double longitude;
  final String cooperativeName;
  final String groupName;
  final String farmerType;
  final String copmobileNumber;

  AddFarmerReqModel(
      {required this.farmerName,
      required this.mobileNumber,
      required this.county,
      required this.subCounty,
      required this.ward,
      this.latitude = 0.0,
      this.longitude = 0.0,
      required this.cooperativeName,
      required this.groupName,
      required this.farmerType,
      required this.copmobileNumber});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['farmer_name'] = farmerName;
    map['mobile_number'] = mobileNumber;
    map['county'] = county;
    map['subcounty'] = subCounty;
    map['ward'] = ward;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['cooperative_name'] = cooperativeName;
    map['group_name'] = groupName;
    map['gender'] = farmerType;
    map['cop_mobilenumber'] = copmobileNumber;
    return map;
  }
}
