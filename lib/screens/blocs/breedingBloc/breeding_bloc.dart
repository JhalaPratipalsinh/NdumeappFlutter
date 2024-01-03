import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/models/add_breeding_record_model.dart';
import 'package:ndumeappflutter/data/models/add_breeding_record_req_model.dart';

import '../../../core/logger.dart';
import '../../../data/models/breeding_model.dart';
import '../../../data/models/paid_breeding_record_model.dart';
import '../../../data/models/source_of_semen_list_model.dart';
import '../../../repository/breeding_repository.dart';

part 'breeding_event.dart';

part 'breeding_state.dart';

class BreedingBloc extends Bloc<BreedingEvent, BreedingState> {
  final BreedingRepository repository;

  BreedingBloc(this.repository) : super(const BreedingInitial()) {
    on<BreedingEvent>((event, emit) async {
      try {
        late final BreedingState data;
        if (event is AddBreedingEvent) {
          emit(const LoadingBreedingState());
          final possibleData = event.isUpdate
              ? await repository.updateBreedingRecordAPI(
                  addBreedingRecordReq: event.addBreedingRecordReq)
              : await repository.addBreedingRecordAPI(
                  addBreedingRecordReq: event.addBreedingRecordReq);

          data = possibleData.fold(
            (l) => HandleErrorBreedingState(
                error: l.error, statusCode: l.errorCode),
            (r) => HandleAddBreedingState(response: r),
          );
        } else if (event is FetchBreedingEvent) {
          emit(const LoadingBreedingState());
          final possibleData = await repository.fetchBreedingRecordsAPI(
              mobileNoOrVetId: event.mobileNoOrVetId,
              isMobileNo: event.isMobileNo,
              isVatId: event.isVatId,isVerified: event.isVerified);

          data = possibleData.fold(
            (l) => HandleErrorBreedingState(
                error: l.error, statusCode: l.errorCode),
            (r) => HandleBreedingListState(response: r),
          );
        } else if (event is FetchBreedingDetailEvent) {
          emit(const LoadingBreedingDetailState());
          final possibleData = await repository.getBreedingDetailAPI(
              breedingID: event.breedingID);
          data = possibleData.fold(
            (l) => HandleErrorBreedingState(
                error: l.error, statusCode: l.errorCode),
            (r) => HandleBreedingDetailState(response: r),
          );
        } else if (event is RemoveBreedingEvent) {
          emit(const LoadingBreedingState());
          final possibleData =
              await repository.removeBreedingAPI(breedingID: event.breedingID);
          data = possibleData.fold(
            (l) => HandleErrorBreedingState(
                error: l.error, statusCode: l.errorCode),
            (r) => HandleDeleteBreedingState(response: r),
          );
        } else if (event is FatchPaidBreedingListEvent) {
          emit(const LoadingBreedingState());
          final possibleData =
              await repository.getPaidBreedingListAPI(vatId: event.vatId);
          data = possibleData.fold(
            (l) => HandleErrorBreedingState(
                error: l.error, statusCode: l.errorCode),
            (r) => PaidBreedingRecordListState(response: r),
          );
        }
        else if (event is FetchSourceOfSemenListEvent) {
          emit(const LoadingFetchSourceOfSemenListState());
          final possibleData =
              await repository.fetchSourceOfSemenListAPI(semenType: event.semenType);
          data = possibleData.fold(
            (l) => HandleErrorSourceOfSemenListState(
                error: l.error, statusCode: l.errorCode),
            (r) => HandleFetchSourceOfSemenListState(response: r),
          );
        }
        emit(data);
      } catch (e) {
        logger.e(e);
        emit(HandleErrorBreedingState(error: e.toString(), statusCode: 0));
      }
    });
  }

  @override
  void onTransition(
      Transition<BreedingEvent, BreedingState> transition) {
    super.onTransition(transition);
    logger.v(
        'the transition in the PaymentReceipt Bloc are : \nState : ${transition.currentState} \nEvent : ${transition.event}');
  }
}
