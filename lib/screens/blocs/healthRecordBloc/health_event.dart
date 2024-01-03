part of 'health_bloc.dart';

abstract class HealthEvent extends Equatable {
  const HealthEvent();
}

class AddHealthRecordEvent extends HealthEvent {
  final AddHealthRecordReqModel addHealthRecordReq;
  final bool isUpdate;

  const AddHealthRecordEvent({required this.addHealthRecordReq, this.isUpdate = false});

  @override
  List<Object?> get props => [addHealthRecordReq, isUpdate];
}

class FetchHealthRecordEvent extends HealthEvent {
  final String mobileNoOrVetId;
  final bool isMobileNo;
  final bool isVatId;
  final bool isVerified;

  const FetchHealthRecordEvent({required this.mobileNoOrVetId, required this.isMobileNo,this.isVatId=false,this.isVerified=false});

  @override
  List<Object?> get props => [mobileNoOrVetId, isMobileNo];
}

class FetchPaidHealthRecordEvent extends HealthEvent {
  final String vetId;

  const FetchPaidHealthRecordEvent({required this.vetId});

  @override
  List<Object?> get props => [vetId];
}

class FetchHealthRecordDetailEvent extends HealthEvent {
  final String healthId;

  const FetchHealthRecordDetailEvent({required this.healthId});

  @override
  List<Object?> get props => [healthId];
}

class RemoveHealthRecordEvent extends HealthEvent {
  final String healthId;

  const RemoveHealthRecordEvent({required this.healthId});

  @override
  List<Object?> get props => [healthId];
}
