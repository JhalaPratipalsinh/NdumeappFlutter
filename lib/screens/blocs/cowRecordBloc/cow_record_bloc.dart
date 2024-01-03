import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/models/register_cow_req_model.dart';

import '../../../core/logger.dart';
import '../../../data/models/cow_breeds_group_model.dart';
import '../../../data/models/cow_list_model.dart';
import '../../../data/models/register_cow_model.dart';
import '../../../repository/cow_repository.dart';

part 'cow_record_event.dart';
part 'cow_record_state.dart';

class CowRecordBloc extends Bloc<CowRecordEvent, CowRecordState> {
  final CowRepository repository;
  String mobileNumber = "";
  String farmerVetID = "";
  String farmerVetName = "";

  CowRecordBloc(this.repository) : super(const CowRecordInitial()) {
    on<CowRecordEvent>((event, emit) async {
      try {
        late final CowRecordState data;
        if (event is FetchCowRecordsEvent) {
          emit(const LoadingCowRecordsState());

          mobileNumber = event.mobileNumber;
          final possibleData = await repository.callCowRecordsAPI(
              mobileNumber: mobileNumber, fetchNewRecord: event.isFetchNew);

          data = possibleData.fold(
            (l) => CowRecordsErrorState(error: l.error, errorCode: l.errorCode),
            (r) => LoadCowRecordsState(cowRecords: r),
          );
        } else if (event is FetchCowBreedsAndGroupEvent) {
          ///the cow breeds and groups will be returned from cached storage here the data fetching will be without network call.
          final possibleData = await repository.fetchCowBreedAndGroupAPI();
          data = possibleData.fold(
            (l) => CowRecordsErrorState(error: l.error, errorCode: l.errorCode),
            (r) => LoadCowBreedsAndGroupState(cowBreedsAndGroup: r),
          );
        } else if (event is RegisterNewCowEvent) {
          emit(const LoadingRegistrationNewCowState());
          final possibleData =
              await repository.registerNewCowAPI(registerCowReq: event.registerCowReq);

          ///on success of adding or registering a cow call and cache cow records from the API.
          if (possibleData.isRight()) {
            Future.delayed(const Duration(seconds: 1)).then(
                (value) => add(FetchCowRecordsEvent(mobileNumber: mobileNumber, isFetchNew: true)));
          }

          data = possibleData.fold(
            (l) => CowRecordsErrorState(error: l.error, errorCode: l.errorCode),
            (r) => HandleRegisterNewCowState(response: r),
          );
        }

        emit(data);
      } catch (e) {
        logger.e(e);
        emit(CowRecordsErrorState(error: e.toString(), errorCode: 0));
      }
    });
  }

  void getCowBreedsAndGroup() {
    ///fetching cow breeds and group here and saving it to cache so that we no need to repeat API calls.
    repository.fetchCowBreedAndGroupAPI();
  }

  List<CowRecordsModel> fetchCowList() => repository.getCowList();

  void setFarmerVetDetails(String mobileNo, String farmerVetName, String farmerVetID) {
    mobileNumber = mobileNo;
    this.farmerVetName = farmerVetName;
    this.farmerVetID = farmerVetID;
  }

  @override
  void onTransition(Transition<CowRecordEvent, CowRecordState> transition) {
    super.onTransition(transition);
    logger.d(
        'the Event Triggered is ${transition.event} and the State Emitted is : ${transition.nextState}');
  }
}
