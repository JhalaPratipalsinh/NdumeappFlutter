part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class CheckTermsConditionEvent extends LoginEvent{

  final String vetId;

  const CheckTermsConditionEvent({required this.vetId});

  @override
  List<Object?> get props => [vetId];

}

class UpdateTermsConditionEvent extends LoginEvent{

  final String vetId;

  const UpdateTermsConditionEvent({required this.vetId});

  @override
  List<Object?> get props => [vetId];
}

class GetCountyEvent extends LoginEvent {
  const GetCountyEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetSubCountyEvent extends LoginEvent {
  final String county;

  const GetSubCountyEvent(this.county);

  @override
  List<Object?> get props => [county];
}

class GetWardEvent extends LoginEvent {
  final String county;
  final String subCounty;

  const GetWardEvent(this.county, this.subCounty);

  @override
  List<Object?> get props => [county, subCounty];
}

class InitiateLoginEvent extends LoginEvent {
  final String mobileNo;
  final String password;

  const InitiateLoginEvent(this.mobileNo, this.password);

  @override
  List<Object?> get props => [mobileNo, password];
}

class MpesaLoginEvent extends LoginEvent {
  const MpesaLoginEvent();

  @override
  List<Object?> get props => [];
}

class InitiateRegistrationEvent extends LoginEvent {
  final RegistrationReqModel registrationReq;

  const InitiateRegistrationEvent(this.registrationReq);

  @override
  List<Object?> get props => [registrationReq];
}

class ChangePassworEvent extends LoginEvent{

  final String oldPass;
  final String newPass;

  const ChangePassworEvent(this.oldPass, this.newPass);

  @override
  List<Object?> get props => [oldPass, newPass];
}

class ForgotPasswordEvent extends LoginEvent{

  final String mobileno;

  const ForgotPasswordEvent(this.mobileno);

  @override
  List<Object?> get props => [mobileno];
}
