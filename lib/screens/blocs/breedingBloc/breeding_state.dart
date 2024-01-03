part of 'breeding_bloc.dart';

abstract class BreedingState extends Equatable {
  const BreedingState();
}

class BreedingInitial extends BreedingState {
  const BreedingInitial();

  @override
  List<Object> get props => [];
}

class HandleAddBreedingState extends BreedingState {
  final AddBreedingRecordModel response;

  const HandleAddBreedingState({required this.response});

  @override
  List<Object> get props => [response];
}

class HandleBreedingListState extends BreedingState {
  final BreedingModel response;

  const HandleBreedingListState({required this.response});

  @override
  List<Object> get props => [response];
}

class HandleBreedingDetailState extends BreedingState {
  final BreedingData response;

  const HandleBreedingDetailState({required this.response});

  @override
  List<Object> get props => [response];
}

class HandleDeleteBreedingState extends BreedingState {
  final AddBreedingRecordModel response;

  const HandleDeleteBreedingState({required this.response});

  @override
  List<Object> get props => [response];
}

class LoadingBreedingState extends BreedingState {
  const LoadingBreedingState();

  @override
  List<Object> get props => [];
}

class PaidBreedingRecordListState extends BreedingState{
  final PaidBreedingRecordModel response;
  const PaidBreedingRecordListState({required this.response});

  @override
  List<Object> get props=>[response];
}

class LoadingBreedingDetailState extends BreedingState {
  const LoadingBreedingDetailState();

  @override
  List<Object> get props => [];
}

class HandleErrorBreedingState extends BreedingState {
  final String error;
  final int statusCode;

  const HandleErrorBreedingState({required this.error, this.statusCode = 0});

  @override
  List<Object> get props => [error, statusCode];
}


class LoadingFetchSourceOfSemenListState extends BreedingState {
  const LoadingFetchSourceOfSemenListState();

  @override
  List<Object> get props => [];
}

class HandleFetchSourceOfSemenListState extends BreedingState {
  final FetchSourceOfSemenListModel response;

  const HandleFetchSourceOfSemenListState({required this.response});

  @override
  List<Object> get props => [response];
}

class HandleErrorSourceOfSemenListState extends BreedingState {
  final String error;
  final int statusCode;

  const HandleErrorSourceOfSemenListState({required this.error, this.statusCode = 0});

  @override
  List<Object> get props => [error, statusCode];
}
