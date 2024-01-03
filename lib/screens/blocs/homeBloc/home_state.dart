part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object> get props => [];
}

class HandleSearchState extends HomeState {
  final FindOrAddFarmerModel response;

  const HandleSearchState({required this.response});

  @override
  List<Object> get props => [response];
}

class HandleAddFarmerState extends HomeState {
  final FindOrAddFarmerModel response;

  const HandleAddFarmerState({required this.response});

  @override
  List<Object> get props => [response];
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();

  @override
  List<Object> get props => [];
}

class AddFarmerLoadingState extends HomeState {
  const AddFarmerLoadingState();

  @override
  List<Object> get props => [];
}

class UpdateFarmerState extends HomeState{

  CommonResponseModel response;

  UpdateFarmerState({required this.response});

  @override
  List<Object?> get props => [response];

}

class HomeErrorState extends HomeState {
  final String error;
  final int statusCode;

  const HomeErrorState({required this.error, required this.statusCode});

  @override
  List<Object> get props => [error, statusCode];
}

