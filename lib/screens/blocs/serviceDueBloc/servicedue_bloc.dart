import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ndumeappflutter/data/models/Common_response_model.dart';
import 'package:ndumeappflutter/data/models/pregnency_service_duelist_model.dart';
import 'package:ndumeappflutter/repository/serviceduelist_reposiroty.dart';

import '../../../core/logger.dart';

part 'servicedue_event.dart';

part 'servicedue_state.dart';

class ServicedueBloc extends Bloc<ServicedueEvent, ServicedueState> {
  final ServiceDueListRepository repository;

  ServicedueBloc(this.repository) : super(ServicedueInitial()) {
    on<ServicedueEvent>((event, emit) async {
      try {
        late final ServicedueState data;
        if (event is GetPregnencyDueList) {
          emit(const LoadingServiceDueState());
          final possibleData = await repository.getPregnencyDueListAPI(
              apiName: event.apiName,
              vetId: event.vetId,
              fromDate: event.fromDate,
              toDate: event.toDate);

          data = possibleData.fold(
            (l) => HandlerErrorState(message: l.error, statusCode: l.errorCode),
            (r) => PregnencyDueListState(response: r),
          );
        }else if(event is UpdateRecordStatusEvent){
          emit(const UpdatingRecordStatusState());
          final possibleData = await repository.updateRecordStatus(
              recordId: event.recordId,
              recordType: event.recordType,
              commType: event.comType,
              status: event.status);

          data = possibleData.fold(
                  (l) => HandlerErrorState(message: l.error, statusCode: l.errorCode),
                  (r) => RecordStatusUpdatedState(response: r));
        }
        emit(data);
      } catch (e) {
        logger.e(e);
        emit(HandlerErrorState(message: e.toString(), statusCode: 0));
      }
    });
  }
}
