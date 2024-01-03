import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/addBreedingRecordActivity.dart';
import 'package:ndumeappflutter/screens/addHealthRecordTreatmentActivity.dart';
import 'package:ndumeappflutter/screens/blocs/homeBloc/home_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/loginBloc/login_bloc.dart';
import 'package:ndumeappflutter/screens/breedingRecordDetailActivity.dart';
import 'package:ndumeappflutter/screens/cubits/myfarmersChangeTabCubit/my_farmers_change_tab_cubit.dart';
import 'package:ndumeappflutter/screens/cubits/sourceOfSemenChangeCubit/source_of_semen_change_cubit.dart';
import 'package:ndumeappflutter/screens/editBreedingRecordActivity.dart';
import 'package:ndumeappflutter/screens/editHealthRecordActivity.dart';
import 'package:ndumeappflutter/screens/farmerDetailActivity.dart';
import 'package:ndumeappflutter/screens/forgotPinActivity.dart';
import 'package:ndumeappflutter/screens/homeActivity.dart';
import 'package:ndumeappflutter/screens/loginActivity.dart';
import 'package:ndumeappflutter/screens/registerCowActivity.dart';
import 'package:ndumeappflutter/screens/registrationActivity.dart';
import 'package:ndumeappflutter/screens/startActivity.dart';
import 'package:ndumeappflutter/screens/trainingDetailActivity.dart';
import 'package:ndumeappflutter/screens/viewEditBreedingActivity.dart';
import 'package:ndumeappflutter/screens/viewHealthRecordActivity.dart';
import 'package:ndumeappflutter/screens/widgets/farmersInNeedOfServiceActivity/farmers_in_need_of_service_activity.dart';
import 'package:ndumeappflutter/screens/widgets/myFarmers/widgets/farmers_in_need_of_service_widget.dart';
import 'package:ndumeappflutter/screens/withdrawActivity.dart';
import 'package:ndumeappflutter/splashActivity.dart';

import '../injection_container.dart';
import '../screens/addPregnancyStatus.dart';
import '../screens/blocs/breedingBloc/breeding_bloc.dart';
import '../screens/blocs/walletBloc/wallet_bloc.dart';
import '../screens/breedingRecordManagementActivity.dart';
import '../screens/cubits/breedingAndHealthChangeTabCubit/breeding_and_health_change_tab_cubit.dart';
import '../screens/cubits/breedingRecordChangeTabCubit/breeding_record_change_tab_cubit.dart';
import '../screens/cubits/healthRecordChangeTabCubit/health_record_change_tab_cubit.dart';
import '../screens/cubits/homeChangeWidgetCubit/home_change_widget_cubit.dart';
import '../screens/healthRecordDetailActivity.dart';
import '../screens/paidBreedingRedordListActivity.dart';
import '../screens/paidHealthRecordListActivity.dart';
import '../screens/trainingTopicListActivity.dart';
import '../screens/verifiedBreedingRecordListActivity.dart';
import '../screens/verifiedHealthRecordListActivity.dart';
import '../screens/widgets/ndume_wallet_widget.dart';
import '../util/constants.dart';

// ignore: avoid_classes_with_only_static_members
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashActivity());
      case startScreen:
        return MaterialPageRoute(builder: (_) => const StartActivity());
      case loginPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<LoginBloc>(
                create: (_) => sl<LoginBloc>(), child: const LoginActivity()));
      case forgotPassPage:
        return MaterialPageRoute(builder: (_) => const ForgotPinActivity());
      case registrationPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<LoginBloc>(
                create: (_) => sl<LoginBloc>(),
                child: const RegistrationActivity()));
      case homePage:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(create: (_) => sl<HomeBloc>()),
                  BlocProvider(create: (_) => sl<HomeChangeWidgetCubit>()),
                  BlocProvider(create: (_) => sl<HealthRecordChangeTabCubit>()),
                  BlocProvider(
                      create: (_) => sl<BreedingRecordChangeTabCubit>()),
                  BlocProvider(create: (_) => sl<MyFarmersChangeTabCubit>()),
                  BlocProvider(create: (_) => sl<LoginBloc>())
                ], child: const HomeActivity()));

      case breedingRecordManagement:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(
                      create: (_) => sl<BreedingAndHealthChangeTabCubit>()),
                ], child: const BreedingRecordManagementActivity()));
      case addBreedingRecord:
        if (args is BreedingType) {
          // return MaterialPageRoute(
          //     builder: (_) => AddBreedingRecordActivity(breedingType: args));
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(providers: [
                    BlocProvider(create: (_) => sl<SourceOFSemenChangeCubit>()),
                  ], child: AddBreedingRecordActivity(breedingType: args)));
        }
        return _errorRoute();
      case addHealthRecord:
        if (args is HealthType) {
          return MaterialPageRoute(
              builder: (_) =>
                  AddHealthRecordTreatmentActivity(healthType: args));
        }
        return _errorRoute();
      case farmerDetail:
        if (args is Map<String, dynamic>) {
          final mobile = args['mobile'];
          final farmerName = args['farmerName'];

          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                            create: (_) =>
                                sl<BreedingAndHealthChangeTabCubit>()),
                      ],
                      child: FarmerDetailActivity(
                          mobileNumber: mobile, farmerName: farmerName)));
        }
        return _errorRoute();
      case breedingRecordDetail:
        if (args is Map<String, dynamic>) {
          final breedingID = args['breedingID'];
          final repeats = args['repeats'];
          return MaterialPageRoute(
              builder: (_) => BreedingRecordDetailActivity(
                    breedingID: breedingID,
                    repeats: repeats,
                  ));
        }
        return _errorRoute();
      case healthRecordDetail:
        if (args is Map<String, dynamic>) {
          final healthID = args['healthID'];
          final healthCat = args['healthCat'];
          bool isEditable = true;
          if (args.containsKey('isEditable')) {
            isEditable = args['isEditable'];
          }
          return MaterialPageRoute(
              builder: (_) => HealthRecordDetailActivity(
                    healthId: healthID,
                    healthCat: healthCat,
                    isEditable: isEditable,
                  ));
        }
        return _errorRoute();
      case editBreedingRecordDetail:
        if (args is Map<String, dynamic>) {
          final breedingID = args['breedingID'];
          return MaterialPageRoute(
              builder: (_) =>
                  EditBreedingRecordActivity(breedingID: breedingID));
        }
        return _errorRoute();
      case editHealthRecordDetail:
        if (args is Map<String, dynamic>) {
          final healthID = args['healthID'];
          return MaterialPageRoute(
              builder: (_) => EditHealthRecordActivity(healthID: healthID));
        }
        return _errorRoute();
      case registerCow:
        return MaterialPageRoute(builder: (_) => const RegisterCowActivity());
      case viewEditBreedingRecords:
        return MaterialPageRoute(
            builder: (_) => const ViewEditBreedingActivity());
      case viewEditHealthRecords:
        if (args is Map<String, dynamic>) {
          final isEditable = args['isEditable'];
          return MaterialPageRoute(
              builder: (_) => ViewHealthRecordActivity(
                    isEditable: isEditable,
                  ));
        }
        return _errorRoute();
      case walletWithdraw:
        if (args is Map<String, dynamic>) {
          final totalBalance = args['totalBalance'];
          final minAmount = args['minAmount'];
          final maxAmount = args['maxAmount'];
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                  create: (_) => sl<LoginBloc>(),
                  child: WithdrawActivity(
                    walletAmount: totalBalance,
                    minAmount: minAmount,
                    maxAmount: maxAmount,
                  )));
        }
        return _errorRoute();
      case ndumeWallet:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => sl<WalletBloc>(),
                child: const NdumeWalletWidget()));
      case paidBreedingRecordList:
        return MaterialPageRoute(
            builder: (_) => const PaidBreedingRecodListActivity());
      case paidHealthRecordList:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(create: (_) => sl<HealthRecordChangeTabCubit>()),
                ], child: const PaidHealtRecordActivity()));
      case verifiedBreedingRecordList:
        return MaterialPageRoute(
            builder: (_) => const VerifiedBreedingRecordListActivity());
      case verifiedHealthRecordList:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(create: (_) => sl<HealthRecordChangeTabCubit>()),
                ], child: const VerifiedHealthRecordListActivity()));
      case addPregnancyStatus:
        return MaterialPageRoute(
            builder: (_) => const AddPregnancyStatusActivity());

      case farmerInNeedOfService:
        if (args is Map<String, dynamic>) {
          final String title = args['title'];
          final String fromDate = args['fromDate'];
          final String toDate = args['toDate'];
          final String apiName= args['apiName'];
          final String recordType= args['recordType'];

          return MaterialPageRoute(
              builder: (_) => FarmerInNeedOfServiceActivity(
                    title: title,
                    fromDate: fromDate,
                    toDate: toDate,
                    apiName: apiName,
                    recordType: recordType,
                  ));
        }
        return _errorRoute();
      case trainingTopicList:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
              builder: (_) => TrainingTopicListActivity(
                    cateId: args['catId'],
                    cateName: args['catName'],
                  ));
        }
        return _errorRoute();
      case trainingDetail:
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => TrainingDetailActivity(trainingId: args));
        }
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
