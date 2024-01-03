part of 'health_bloc.dart';

abstract class HealthState extends Equatable {
  const HealthState();
}

class HealthInitial extends HealthState {
  const HealthInitial();

  @override
  List<Object> get props => [];
}

class HandleAddHealthRecordState extends HealthState {
  final AddHealthRecordModel response;

  const HandleAddHealthRecordState({required this.response});

  @override
  List<Object> get props => [response];
}

class HandleRemoveHealthRecordState extends HealthState {
  final AddHealthRecordModel response;

  const HandleRemoveHealthRecordState({required this.response});

  @override
  List<Object> get props => [response];
}

class HandleHealthRecordListState extends HealthState {
  final List<HealthData> response;

  const HandleHealthRecordListState({required this.response});

  @override
  List<Object> get props => [response];
}

class PaidHealthRecordListState extends HealthState {
  final List<PaidHealthRecord> response;

  const PaidHealthRecordListState({required this.response});

  @override
  List<Object> get props => [response];
}

class HandleHealthRecordDetailState extends HealthState {
  final HealthData response;

  const HandleHealthRecordDetailState({required this.response});

  @override
  List<Object> get props => [response];
}

class LoadingHealthRecordState extends HealthState {
  const LoadingHealthRecordState();

  @override
  List<Object> get props => [];
}

class HandleHealthRecordErrorState extends HealthState {
  final String message;
  final int statusCode;

  const HandleHealthRecordErrorState({required this.message, this.statusCode = 0});

  @override
  List<Object> get props => [message, statusCode];
}
