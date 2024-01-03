part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class CheckTermsConditionState extends LoginState{
  final TermsConditionStatusModel respose;

  const CheckTermsConditionState({required this.respose});

  @override
  List<Object?> get props => [respose];

}

class UpdateTermsConditionState extends LoginState{
  final CommonResponseModel respose;

  const UpdateTermsConditionState({required this.respose});

  @override
  List<Object?> get props => [respose];

}

class SetCountyState extends LoginState {
  final CountyListModel countyList;

  const SetCountyState({required this.countyList});

  @override
  List<Object?> get props => [countyList];
}

class SetSubCountyState extends LoginState {
  final SubcountyListModel subCountyList;

  const SetSubCountyState({required this.subCountyList});

  @override
  List<Object?> get props => [subCountyList];
}

class SetWardState extends LoginState {
  final WardListModel wardList;

  const SetWardState({required this.wardList});

  @override
  List<Object?> get props => [wardList];
}

class LoginResponseState extends LoginState {
  final LoginModel response;

  const LoginResponseState({required this.response});

  @override
  List<Object?> get props => [response];
}

class RegistrationResponseState extends LoginState {
  final RegistrationModel response;

  const RegistrationResponseState({required this.response});

  @override
  List<Object?> get props => [response];
}

class MpesaLoginResponseState extends LoginState {
  final MpesaLoginModel response;

  const MpesaLoginResponseState({required this.response});

  @override
  List<Object?> get props => [response];
}

class MasterLoadingState extends LoginState {
  @override
  List<Object?> get props => [];

  const MasterLoadingState();
}

class SubCountyLoadingState extends LoginState {
  @override
  List<Object?> get props => [];

  const SubCountyLoadingState();
}

class WardLoadingState extends LoginState {
  @override
  List<Object?> get props => [];

  const WardLoadingState();
}

class ChangePasswordState extends LoginState{

  final CommonResponseModel response;

  const ChangePasswordState({required this.response});

  @override
  List<Object?> get props => [response];
}

class ForgotPasswordState extends LoginState{

  final CommonResponseModel response;

  const ForgotPasswordState({required this.response});

  @override
  List<Object?> get props => [response];
}

class ErrorState extends LoginState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
