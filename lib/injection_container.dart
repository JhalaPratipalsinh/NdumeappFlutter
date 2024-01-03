import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:ndumeappflutter/data/repositoryImpl/farmer_repository_impl.dart';
import 'package:ndumeappflutter/data/repositoryImpl/health_repository_impl.dart';
import 'package:ndumeappflutter/data/repositoryImpl/servicedue_repository_impl.dart';
import 'package:ndumeappflutter/data/repositoryImpl/training_repository_impl.dart';
import 'package:ndumeappflutter/data/repositoryImpl/wallet_repository_impl.dart';
import 'package:ndumeappflutter/repository/serviceduelist_reposiroty.dart';
import 'package:ndumeappflutter/repository/training_repository.dart';
import 'package:ndumeappflutter/screens/blocs/farmerBloc/farmer_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/healthRecordBloc/health_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/serviceDueBloc/servicedue_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/trainingBloc/trainingk_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/walletBloc/wallet_bloc.dart';
import 'package:ndumeappflutter/screens/cubits/myfarmersChangeTabCubit/my_farmers_change_tab_cubit.dart';
import 'package:ndumeappflutter/screens/cubits/sourceOfSemenChangeCubit/source_of_semen_change_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/apiService/base_api_service.dart';
import 'data/apiService/network_api_service.dart';
import 'data/repositoryImpl/breeding_repository_impl.dart';
import 'data/repositoryImpl/cow_repository_impl.dart';
import 'data/repositoryImpl/home_repository_impl.dart';
import 'data/repositoryImpl/login_registration_repository_impl.dart';
import 'data/repositoryImpl/master_repository_impl.dart';
import 'data/sessionManager/session_manager.dart';
import 'features/location_manager.dart';
import 'repository/breeding_repository.dart';
import 'repository/cow_repository.dart';
import 'repository/farmer_repository.dart';
import 'repository/health_repository.dart';
import 'repository/home_repository.dart';
import 'repository/login_registration_repository.dart';
import 'repository/master_repository.dart';
import 'repository/wallet_repository.dart';
import 'screens/blocs/breedingBloc/breeding_bloc.dart';
import 'screens/blocs/cowRecordBloc/cow_record_bloc.dart';
import 'screens/blocs/homeBloc/home_bloc.dart';
import 'screens/blocs/loginBloc/login_bloc.dart';
import 'screens/cubits/breedingAndHealthChangeTabCubit/breeding_and_health_change_tab_cubit.dart';
import 'screens/cubits/breedingRecordChangeTabCubit/breeding_record_change_tab_cubit.dart';
import 'screens/cubits/healthRecordChangeTabCubit/health_record_change_tab_cubit.dart';
import 'screens/cubits/homeChangeWidgetCubit/home_change_widget_cubit.dart';
import 'util/common_functions.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External /* All the other required external injection are embedded here */
  await _initExternalDependencies();

  // Repository /* All the repository injection are embedded here */
  _initRepositories();

  // Bloc /* All the bloc injection are embedded here */
  _initBlocs();

  _initCubits();
}

void _initRepositories() {
  sl.registerLazySingleton<MasterRepository>(() => MasterRepositoryImpl(sl()));

  sl.registerLazySingleton<LoginRegistrationRepository>(
      () => LoginRegistrationRepositoryImpl(apiService: sl(), sessionManager: sl()));

  sl.registerLazySingleton<BaseAPIService>(
      () => NetworkAPIService(dio: sl(), connectivity: sl(), sessionManager: sl()));

  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<CowRepository>(() => CowRepositoryImpl(sl()));
  sl.registerLazySingleton<BreedingRepository>(() => BreedingRepositoryImpl(sl()));
  sl.registerLazySingleton<HealthRepository>(() => HealthRepositoryImpl(sl()));
  sl.registerLazySingleton<FarmerRepository>(() => FarmerRepositoryImpl(sl()));
  sl.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<TrainingRepository>(() => TrainingRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ServiceDueListRepository>(() => ServiceDueListRepositoryImpl(sl()));
}

void _initBlocs() {
  sl.registerFactory(() => LoginBloc(sl(), sl()));
  sl.registerFactory(() => HomeBloc(sl()));
  sl.registerFactory(() => CowRecordBloc(sl()));
  sl.registerFactory(() => BreedingBloc(sl()));
  sl.registerFactory(() => HealthBloc(sl()));
  sl.registerFactory(() => FarmerBloc(sl()));
  sl.registerFactory(() => WalletBloc(sl()));
  sl.registerFactory(() => TrainingkBloc(sl()));
  sl.registerFactory(() => ServicedueBloc(sl()));
}

void _initCubits() {
  sl.registerFactory(() => HomeChangeWidgetCubit());
  sl.registerFactory(() => BreedingRecordChangeTabCubit());
  sl.registerFactory(() => HealthRecordChangeTabCubit());
  sl.registerFactory(() => BreedingAndHealthChangeTabCubit());
  sl.registerFactory(() => MyFarmersChangeTabCubit());
  sl.registerFactory(() => SourceOFSemenChangeCubit());
}

Future<void> _initExternalDependencies() async {
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => const CommonFunctions());
  final pref = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => SessionManager(pref));
  sl.registerLazySingleton(() => LocationManager());

  final dio = Dio();

  if (!kIsWeb) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
  sl.registerLazySingleton(() => dio);
}
