import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/breedingBloc/breeding_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/farmerBloc/farmer_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/healthRecordBloc/health_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/homeBloc/home_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/serviceDueBloc/servicedue_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/trainingBloc/trainingk_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/walletBloc/wallet_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:upgrader/upgrader.dart';

import 'core/global_nav_key.dart';
import 'core/route_generator.dart';
import 'injection_container.dart' as di;
import 'resources/color_constants.dart';
import 'screens/blocs/cowRecordBloc/cow_record_bloc.dart';
import 'screens/blocs/loginBloc/login_bloc.dart';
import 'util/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init().then((value) => runApp(const MyApp()));
  await Upgrader.clearSavedSettings();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CowRecordBloc>(create: (_) => di.sl<CowRecordBloc>()),
        BlocProvider<BreedingBloc>(create: (_) => di.sl<BreedingBloc>()),
        BlocProvider<HealthBloc>(create: (_) => di.sl<HealthBloc>()),
        BlocProvider<FarmerBloc>(create: (_) => di.sl<FarmerBloc>()),
        BlocProvider<WalletBloc>(create: (_) => di.sl<WalletBloc>()),
        BlocProvider<LoginBloc>(create: (_) => di.sl<LoginBloc>()),
        BlocProvider<HomeBloc>(create: (_) => di.sl<HomeBloc>()),
        BlocProvider<TrainingkBloc>(create: (_) => di.sl<TrainingkBloc>()),
        BlocProvider<ServicedueBloc>(create: (_) => di.sl<ServicedueBloc>()),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              title: 'Ndume',
              
              navigatorKey: GlobalNavKey.navState,
              theme: ThemeData(
                useMaterial3: false,
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle.light,
                    iconTheme: IconThemeData(color: Colors.black),
                    titleTextStyle:
                        TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 18)),
                fontFamily: 'Montserrat',
                textTheme: const TextTheme(
                    titleMedium:
                        TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16)),
                primaryColor: ColorConstants.colorPrimary,
                primarySwatch: createMaterialColor(ColorConstants.colorPrimaryDark),
                brightness: Brightness.light,
                scaffoldBackgroundColor: Colors.white,
                cardColor: Colors.grey[500],
                unselectedWidgetColor: Colors.black45,
                focusColor: Colors.black,
                /*inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.white,
                ),*/
                cardTheme: const CardTheme(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                ),
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: splashScreen,
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          }
        ),
      ),
    );
  }
}
