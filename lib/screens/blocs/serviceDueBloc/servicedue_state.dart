part of 'servicedue_bloc.dart';

abstract class ServicedueState extends Equatable {
  const ServicedueState();
}

class ServicedueInitial extends ServicedueState {
  @override
  List<Object> get props => [];
}

class LoadingServiceDueState extends ServicedueState {
  const LoadingServiceDueState();

  @override
  List<Object> get props => [];
}

class PregnencyDueListState extends ServicedueState {
  final PregnencyServiceDuelistModel response;

  const PregnencyDueListState({required this.response});

  @override
  List<Object> get props => [response];
}

class UpdatingRecordStatusState extends ServicedueState {
  const UpdatingRecordStatusState();

  @override
  List<Object?> get props => [];
}

class RecordStatusUpdatedState extends ServicedueState {
  final CommonResponseModel response;

  const RecordStatusUpdatedState({required this.response});

  @override
  List<Object?> get props => [response];
}

class HandlerErrorState extends ServicedueState {
  final String message;
  final int statusCode;

  const HandlerErrorState({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [message, statusCode];
}
