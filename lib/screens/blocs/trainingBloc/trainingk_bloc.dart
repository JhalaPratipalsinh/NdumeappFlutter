import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ndumeappflutter/data/models/Common_response_model.dart';

import '../../../core/logger.dart';
import '../../../data/models/training_categorylist_model.dart';
import '../../../data/models/training_topiclist_model.dart';
import '../../../data/models/trainingdetail_model.dart';
import '../../../repository/training_repository.dart';

part 'trainingk_event.dart';

part 'trainingk_state.dart';

class TrainingkBloc extends Bloc<TrainingkEvent, TrainingkState> {
  TrainingRepository repository;

  TrainingkBloc(this.repository) : super(TrainingkInitial()) {
    on<TrainingkEvent>((event, emit) async {
      try {
        late TrainingkState data;
        if (event is GetTrainingCategoryList) {
          emit(const TrainingLoadingState());
          final possibleData = await repository.getTrainingCatListAPI();
          data = possibleData.fold(
            (l) => HandleTrainingErrorState(
                error: l.error, statusCode: l.errorCode),
            (r) => TrainingCategoryListState(response: r),
          );
        }else if(event is GetTrainingTopicList){
          emit(const TrainingLoadingState());
          final possibleData = await repository.getTrainingTopicListAPI(event.catId);
          data = possibleData.fold(
                (l) => HandleTrainingErrorState(
                error: l.error, statusCode: l.errorCode),
                (r) => TrainingTopicListState(response: r),
          );
        }else if(event is GetTrainingDetail){
          emit(const TrainingLoadingState());
          final possibleData = await repository.getTrainingDetailAPI(event.trainingId);
          data = possibleData.fold(
                (l) => HandleTrainingErrorState(
                error: l.error, statusCode: l.errorCode),
                (r) => TrainingDetailState(response: r),
          );
        }else if(event is UpdateTrainingTime){
          //emit(const TrainingLoadingState());
          final possibleData = await repository.updateTrainingTimeAPI(event.trainingId,event.time);
          data = possibleData.fold(
                (l) => HandleTrainingErrorState(
                error: l.error, statusCode: l.errorCode),
                (r) => UpdateTrainingTimeState(response: r),
          );
        }
        emit(data);
      } catch (e) {
        logger.e(e);
        emit(HandleTrainingErrorState(error: e.toString(), statusCode: 0));
      }
    });
  }

  @override
  void onTransition(Transition<TrainingkEvent, TrainingkState> transition) {
    super.onTransition(transition);
    logger.v(
        'the transition in the PaymentReceipt Bloc are : \nState : ${transition.currentState} \nEvent : ${transition.event}');
  }
}
