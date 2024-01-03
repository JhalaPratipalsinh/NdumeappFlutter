part of 'cow_record_bloc.dart';

abstract class CowRecordState extends Equatable {
  const CowRecordState();
}

class CowRecordInitial extends CowRecordState {
  const CowRecordInitial();

  @override
  List<Object> get props => [];
}

class LoadCowRecordsState extends CowRecordState {
  final List<CowRecordsModel> cowRecords;

  const LoadCowRecordsState({required this.cowRecords});

  @override
  List<Object> get props => [cowRecords];
}

class LoadCowBreedsAndGroupState extends CowRecordState {
  final CowBreedsGroupModel cowBreedsAndGroup;

  const LoadCowBreedsAndGroupState({required this.cowBreedsAndGroup});

  @override
  List<Object> get props => [cowBreedsAndGroup];
}

class HandleRegisterNewCowState extends CowRecordState {
  final RegisterCowModel response;

  const HandleRegisterNewCowState({required this.response});

  @override
  List<Object> get props => [response];
}

class LoadingCowRecordsState extends CowRecordState {
  const LoadingCowRecordsState();

  @override
  List<Object> get props => [];
}

class LoadingRegistrationNewCowState extends CowRecordState {
  const LoadingRegistrationNewCowState();

  @override
  List<Object> get props => [];
}

class CowRecordsErrorState extends CowRecordState {
  final String error;
  final int errorCode;

  const CowRecordsErrorState({required this.error, this.errorCode = 0});

  @override
  List<Object> get props => [error, errorCode];
}
