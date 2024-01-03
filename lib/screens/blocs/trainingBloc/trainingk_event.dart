part of 'trainingk_bloc.dart';

abstract class TrainingkEvent extends Equatable {
  const TrainingkEvent();
}

class GetTrainingCategoryList extends TrainingkEvent{

  const GetTrainingCategoryList();

  @override
  List<Object?> get props => [];
}

class GetTrainingTopicList extends TrainingkEvent{

  final String catId;

  const GetTrainingTopicList({required this.catId});

  @override
  List<Object?> get props => [catId];
}

class GetTrainingDetail extends TrainingkEvent{

  final String trainingId;

  GetTrainingDetail(this.trainingId);

  @override
  List<Object?> get props => [trainingId];

}

class UpdateTrainingTime extends TrainingkEvent{

  final String time,trainingId;

  UpdateTrainingTime(this.time,this.trainingId);

  @override
  List<Object?> get props => [time,trainingId];

}
