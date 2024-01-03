import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logger.dart';
import '../../../data/models/add_health_record_model.dart';
import '../../../data/models/add_health_record_req_model.dart';
import '../../../data/models/health_model.dart';
import '../../../data/models/paid_health_record_model.dart';
import '../../../repository/health_repository.dart';

part 'health_event.dart';
part 'health_state.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final HealthRepository repository;

  HealthBloc(this.repository) : super(const HealthInitial()) {
    on<HealthEvent>((event, emit) async {
      try {
        late final HealthState data;
        if (event is AddHealthRecordEvent) {
          emit(const LoadingHealthRecordState());
          final possibleData = event.isUpdate
              ? await repository.updateHealthRecordAPI(
                  addHealthRecordReqModel: event.addHealthRecordReq)
              : await repository.addHealthRecordAPI(
                  addHealthRecordReqModel: event.addHealthRecordReq);

          data = possibleData.fold(
            (l) => HandleHealthRecordErrorState(message: l.error, statusCode: l.errorCode),
            (r) => HandleAddHealthRecordState(response: r),
          );
        } else if (event is RemoveHealthRecordEvent) {
          emit(const LoadingHealthRecordState());
          final possibleData =
              await repository.removeHealthRecordDetailAPI(healthId: event.healthId);

          data = possibleData.fold(
            (l) => HandleHealthRecordErrorState(message: l.error, statusCode: l.errorCode),
            (r) => HandleRemoveHealthRecordState(response: r),
          );
        } else if (event is FetchHealthRecordEvent) {
          emit(const LoadingHealthRecordState());
          final possibleData = await repository.fetchHealthRecordAPI(
              mobileNoOrVetId: event.mobileNoOrVetId, isMobileNo: event.isMobileNo,isVatId:event.isVatId,isVerified: event.isVerified);

          data = possibleData.fold(
            (l) => HandleHealthRecordErrorState(message: l.error, statusCode: l.errorCode),
            (r) => HandleHealthRecordListState(response: r),
          );
        } else if (event is FetchHealthRecordDetailEvent) {
          emit(const LoadingHealthRecordState());
          final possibleData =
              await repository.fetchHealthRecordDetailAPI(healthId: event.healthId);

          data = possibleData.fold(
            (l) => HandleHealthRecordErrorState(message: l.error, statusCode: l.errorCode),
            (r) => HandleHealthRecordDetailState(response: r),
          );
        }else if (event is FetchPaidHealthRecordEvent) {
          emit(const LoadingHealthRecordState());
          final possibleData =
          await repository.getPaidHealthRecordAPI(vetId: event.vetId);

          data = possibleData.fold(
                (l) => HandleHealthRecordErrorState(message: l.error, statusCode: l.errorCode),
                (r) => PaidHealthRecordListState(response: r),
          );
        }
        emit(data);
      } catch (e) {
        logger.e(e);
        emit(HandleHealthRecordErrorState(message: e.toString(), statusCode: 0));
      }
    });
  }
}
