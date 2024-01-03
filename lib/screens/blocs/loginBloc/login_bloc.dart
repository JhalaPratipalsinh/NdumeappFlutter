import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ndumeappflutter/data/models/Common_response_model.dart';
import 'package:ndumeappflutter/data/models/SubcountyListModel.dart';
import 'package:ndumeappflutter/data/models/WardListModel.dart';
import 'package:ndumeappflutter/data/models/login_model.dart';
import 'package:ndumeappflutter/data/models/mpesa_login_model.dart';
import 'package:ndumeappflutter/data/models/registration_model.dart';
import 'package:ndumeappflutter/data/models/registration_req_model.dart';
import 'package:ndumeappflutter/data/models/terms_condition_status_model.dart';
import 'package:ndumeappflutter/repository/login_registration_repository.dart';
import 'package:ndumeappflutter/repository/master_repository.dart';

import '../../../core/logger.dart';
import '../../../data/models/CountyListModel.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  MasterRepository masterRepository;
  LoginRegistrationRepository loginRepository;

  LoginBloc(this.masterRepository, this.loginRepository) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      try {
        if (event is MpesaLoginEvent) {
          final possibleData = await loginRepository.executeMpesaLoginAPI();
          final data = possibleData.fold(
              (l) => ErrorState(l.error), (r) => MpesaLoginResponseState(response: r));
          emit(data);
        } else {
          if (event is GetCountyEvent) {
            emit(const MasterLoadingState());
            final possibleData = await masterRepository.getCountyList();
            final data =
                possibleData.fold((l) => ErrorState(l.error), (r) => SetCountyState(countyList: r));
            emit(data);
          } else if (event is GetSubCountyEvent) {
            emit(const SubCountyLoadingState());
            final possibleData = await masterRepository.getSubCountyList(event.county);
            final data = possibleData.fold(
                (l) => ErrorState(l.error), (r) => SetSubCountyState(subCountyList: r));
            emit(data);
          } else if (event is GetWardEvent) {
            emit(const WardLoadingState());
            final possibleData = await masterRepository.getWardList(event.county, event.subCounty);
            final data =
                possibleData.fold((l) => ErrorState(l.error), (r) => SetWardState(wardList: r));
            emit(data);
          } else if (event is InitiateLoginEvent) {
            emit(const MasterLoadingState());
            final possibleData =
                await loginRepository.executeLoginAPI(event.mobileNo, event.password);
            final data = possibleData.fold(
                (l) => ErrorState(l.error), (r) => LoginResponseState(response: r));
            emit(data);
          } else if (event is InitiateRegistrationEvent) {
            emit(const MasterLoadingState());
            final possibleData =
                await loginRepository.executeRegistrationAPI(event.registrationReq);
            final data = possibleData.fold(
                (l) => ErrorState(l.error), (r) => RegistrationResponseState(response: r));
            emit(data);
          }else if(event is CheckTermsConditionEvent){
            emit(const MasterLoadingState());
            final possibleData =
            await masterRepository.checkTermsCondition(event.vetId);
            final data = possibleData.fold(
                    (l) => ErrorState(l.error), (r) => CheckTermsConditionState(respose: r));
            emit(data);
          }else if(event is UpdateTermsConditionEvent){
            emit(const MasterLoadingState());
            final possibleData =
            await masterRepository.updateTermsCondition(event.vetId);
            final data = possibleData.fold(
                    (l) => ErrorState(l.error), (r) => UpdateTermsConditionState(respose: r));
            emit(data);
          }else if(event is ChangePassworEvent){
            emit(const MasterLoadingState());
            final possibleData =
            await loginRepository.changePasswordAPI(event.oldPass,event.newPass);
            final data = possibleData.fold(
                    (l) => ErrorState(l.error), (r) => ChangePasswordState(response: r));
            emit(data);
          }else if(event is ForgotPasswordEvent){
            emit(const MasterLoadingState());
            final possibleData =
            await loginRepository.forgotPassword(event.mobileno);
            final data = possibleData.fold(
                    (l) => ErrorState(l.error), (r) => ForgotPasswordState(response: r));
            emit(data);
          }
        }
      } catch (e) {
        logger.e(e.toString());
        emit(ErrorState(e.toString()));
      }
    });
  }

  @override
  void onTransition(
      Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    logger.v(
        'the transition in the PaymentReceipt Bloc are : \nState : ${transition.currentState} \nEvent : ${transition.event}');
  }
}
