/// success : true
/// message : "Found"
/// isTerms : true

class TermsConditionStatusModel {
  TermsConditionStatusModel({
      bool? success, 
      String? message, 
      int? isTerms,}){
    _success = success;
    _message = message;
    _isTerms = isTerms;
}

  TermsConditionStatusModel.fromJson(dynamic json) {
    _success = json['success'] as bool;
    _message = json['message'] as String;
    _isTerms = json['terms_conditions'] as int;
  }
  bool? _success;
  String? _message;
  int? _isTerms;

  bool? get success => _success;
  String? get message => _message;
  int? get isTerms => _isTerms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['terms_conditions'] = _isTerms;
    return map;
  }

}