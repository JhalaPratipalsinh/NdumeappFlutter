part of 'servicedue_bloc.dart';

abstract class ServicedueEvent extends Equatable {
  const ServicedueEvent();
}

class GetPregnencyDueList extends ServicedueEvent{

  final String apiName;
  final String vetId,fromDate,toDate;

  const GetPregnencyDueList({required this.apiName,required this.vetId, required this.fromDate, required this.toDate});

  @override
  // TODO: implement props
  List<Object?> get props => [apiName,vetId,fromDate,toDate];
}

class UpdateRecordStatusEvent extends ServicedueEvent{

  final String recordId,recordType,comType,status;

  const UpdateRecordStatusEvent({required this.recordId, required this.recordType, required this.comType, required this.status});

  @override
  List<Object?> get props => [recordId,recordType,comType,status];

}