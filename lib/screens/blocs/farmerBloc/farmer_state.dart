part of 'farmer_bloc.dart';

abstract class FarmerState extends Equatable {
  const FarmerState();
}

class FarmerInitial extends FarmerState {
  const FarmerInitial();

  @override
  List<Object> get props => [];
}

class LoadingFarmersState extends FarmerState {
  const LoadingFarmersState();

  @override
  List<Object> get props => [];
}

class HandleFarmersListState extends FarmerState {
  final List<FarmerData> response;

  const HandleFarmersListState({required this.response});

  @override
  List<Object> get props => [response];
}

class FarmerNeedServiceState extends FarmerState {
  final FarmerNeedServiceModel response;

  FarmerNeedServiceState({required this.response});

  @override
  List<Object?> get props => [response];
}

class HandlerFarmersErrorState extends FarmerState {
  final String message;
  final int statusCode;

  const HandlerFarmersErrorState({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [message, statusCode];
}
