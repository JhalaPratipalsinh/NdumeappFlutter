part of 'cow_record_bloc.dart';

abstract class CowRecordEvent extends Equatable {
  const CowRecordEvent();
}

class FetchCowRecordsEvent extends CowRecordEvent {
  final String mobileNumber;
  final bool isFetchNew;

  const FetchCowRecordsEvent({required this.mobileNumber, this.isFetchNew = true});

  @override
  List<Object?> get props => [mobileNumber, isFetchNew];
}

class FetchCowBreedsAndGroupEvent extends CowRecordEvent {
  const FetchCowBreedsAndGroupEvent();

  @override
  List<Object?> get props => [];
}

class RegisterNewCowEvent extends CowRecordEvent {
  final RegisterCowReqModel registerCowReq;

  const RegisterNewCowEvent({required this.registerCowReq});

  @override
  List<Object?> get props => [registerCowReq];
}
