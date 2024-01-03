import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/logger.dart';
import '../../../data/models/farmer_model.dart';
import '../../../data/models/farmer_need_service_model.dart';
import '../../../repository/farmer_repository.dart';

part 'farmer_event.dart';

part 'farmer_state.dart';

class FarmerBloc extends Bloc<FarmerEvent, FarmerState> {
  final FarmerRepository repository;

  FarmerBloc(this.repository) : super(const FarmerInitial()) {
    on<FarmerEvent>((event, emit) async {
      try {
        late final FarmerState data;
        if (event is FetchFarmersEvent) {
          emit(const LoadingFarmersState());
          final possibleData = await repository.fetchFarmersAPI(
              vetID: event.vetID, start: event.start, limit: event.limit);

          data = possibleData.fold(
            (l) => HandlerFarmersErrorState(
                message: l.error, statusCode: l.errorCode),
            (r) => HandleFarmersListState(response: r),
          );
        } else if (event is GetFarmerNeedService) {
          emit(const LoadingFarmersState());
          final possibleData = await repository.fetchFarmersNeedServiceAPI(
              vetID: event.vetId,
              fromDate: event.fromDate,
              toDate: event.toDate);
          data = possibleData.fold(
            (l) => HandlerFarmersErrorState(
                message: l.error, statusCode: l.errorCode),
            (r) => FarmerNeedServiceState(response: r),
          );
        }
        emit(data);
      } catch (e) {
        logger.e(e);
        emit(HandlerFarmersErrorState(message: e.toString(), statusCode: 0));
      }
    });
  }
}
