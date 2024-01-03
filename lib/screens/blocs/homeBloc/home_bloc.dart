import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/core/logger.dart';
import 'package:ndumeappflutter/data/models/add_farmer_req_model.dart';
import 'package:ndumeappflutter/data/models/common_response_model.dart';

import '../../../data/models/find_farmer_model.dart';
import '../../../repository/home_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;

  HomeBloc(this._repository) : super(const HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      try {
        late final HomeState data;

        if (event is SearchFarmerEvent) {
          emit(const HomeLoadingState());
          final possibleData = await _repository.searchFarmerAPI(
            mobileNumber: event.mobileNo,
          );
          data = possibleData.fold(
            (l) => HomeErrorState(error: l.error, statusCode: l.errorCode),
            (r) => HandleSearchState(response: r),
          );
        } else if (event is AddFarmerEvent) {
          emit(const AddFarmerLoadingState());
          final possibleData = await _repository.addFarmerAPI(
            addFarmerReq: event.addFarmerReq,
          );
          data = possibleData.fold(
            (l) => HomeErrorState(error: l.error, statusCode: l.errorCode),
            (r) => HandleSearchState(response: r),
          );
        } else if (event is UpdateFarmerEvent) {
          emit(const AddFarmerLoadingState());
          final possibleData = await _repository.updateFarmerAPI(
              farmerVetId: event.farmerVetId,
              gender: event.gender,
              county: event.county,
              subcounty: event.subCounty,
              ward: event.ward);
          data = possibleData.fold(
            (l) => HomeErrorState(error: l.error, statusCode: l.errorCode),
            (r) => UpdateFarmerState(response: r),
          );
        }
        emit(data);
      } catch (e) {
        logger.e(e);
        emit(HomeErrorState(error: e.toString(), statusCode: 0));
      }
    });
  }
}
