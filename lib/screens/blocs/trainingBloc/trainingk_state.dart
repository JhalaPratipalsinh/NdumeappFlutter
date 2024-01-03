part of 'trainingk_bloc.dart';

abstract class TrainingkState extends Equatable {
  const TrainingkState();
}

class TrainingkInitial extends TrainingkState {
  @override
  List<Object> get props => [];
}

class TrainingLoadingState extends TrainingkState{

  const TrainingLoadingState();

  @override
  List<Object?> get props => [];
}

class TrainingCategoryListState extends TrainingkState{
  final TrainingCategorylistModel response;

  const TrainingCategoryListState({required this.response});

  @override
  List<Object?> get props => [response];

}

class TrainingTopicListState extends TrainingkState{
  final TrainingTopiclistModel response;

  const TrainingTopicListState({required this.response});

  @override
  List<Object?> get props => [response];

}

class TrainingDetailState extends TrainingkState{
  final TrainingdetailModel response;

  const TrainingDetailState({required this.response});

  @override
  List<Object?> get props => [response];

}

class UpdateTrainingTimeState extends TrainingkState{
  final CommonResponseModel response;

  const UpdateTrainingTimeState({required this.response});

  @override
  List<Object?> get props => [response];

}

class HandleTrainingErrorState extends TrainingkState {
  final String error;
  final int statusCode;

  const HandleTrainingErrorState({required this.error, this.statusCode = 0});

  @override
  List<Object> get props => [error, statusCode];
}
