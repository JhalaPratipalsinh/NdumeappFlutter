import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';
import 'package:ndumeappflutter/repository/master_repository.dart';
import 'package:ndumeappflutter/util/common_functions.dart';
import 'package:url_launcher/url_launcher.dart';

import 'injection_container.dart';
import 'resources/color_constants.dart';
import 'screens/blocs/loginBloc/login_bloc.dart';
import 'screens/widgets/custom_button.dart';
import 'util/constants.dart';

class SplashActivity extends StatefulWidget {
  const SplashActivity({Key? key}) : super(key: key);

  @override
  State<SplashActivity> createState() => _SplashActivityState();
}

class _SplashActivityState extends State<SplashActivity> {
  bool isTermsCondition = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    isLoggedIn = sl<SessionManager>().isUserLoggedIn();
    if (isLoggedIn) {
      context.read<LoginBloc>().add(CheckTermsConditionEvent(
          vetId:
              sl<SessionManager>().getUserDetails()!.data!.vetId.toString()));
    } else {
      navigateToNextScreen();
      //checkForUpdate();
    }
    //navigateToNextScreen();
  }

  void navigateToNextScreen() {
    sl<MasterRepository>().getCountyList();
    Timer(const Duration(seconds: 2), () {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(
          context,
          homePage,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          startScreen,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        /*child: const Image(
        image: AssetImage("${images}splash_image.jpg"),
        fit: BoxFit.cover,
      ),*/
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is CheckTermsConditionState) {
              if (state.respose.isTerms == 0) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  //yourcode
                  shotTermsAndCondition(context: context);
                });
              } else {
                navigateToNextScreen();
              }
            }
            return Container(
              color: Colors.white,
              child: const Image(
                image: AssetImage("${images}splash_image.jpg"),
                fit: BoxFit.cover,
              ),
            );
          },
        ));
  }

  /*Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        info?.updateAvailability == UpdateAvailability.updateAvailable
            ? () {
                InAppUpdate.performImmediateUpdate().catchError((e) {
                  //showSnack(e.toString());
                  navigateToNextScreen();
                  print(e.toString());
                });
              }
            : navigateToNextScreen();
      });
    }).catchError((e) {
      //showSnack(e.toString());
      navigateToNextScreen();
      print(e.toString());
    });
  }*/

  Future<bool> shotTermsAndCondition({required BuildContext context}) async {
    final result = await showDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: SizedBox(
            height: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 45,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    color: ColorConstants.colorPrimary,
                  ),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Text(
                          "Please Accept",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 0, bottom: 0, right: 20, left: 20),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Please accept our Terms & Condition to continue with this app",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /*Checkbox(
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: isTermsCondition,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isTermsCondition = value!;
                                  });
                                },
                              ),*/
                              const Text(
                                "Terms & Condition",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              InkWell(
                                  onTap: () async {
                                    final uri = Uri.parse(
                                        'http://customer.digicow.co.ke/TERMS_AND_CONDITIONS_FOR_DIGICOW_DAIRY_APP.htm');
                                    await launchUrl(uri);
                                  },
                                  child: const Text(
                                    "view",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.blue),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ButtonWidget(
                          buttonText: 'Accept'.toUpperCase(),
                          onPressButton: () => {
                            /*SchedulerBinding.instance.addPostFrameCallback((_) {


                          }),*/

                            context.read<LoginBloc>().add(
                                UpdateTermsConditionEvent(
                                    vetId: sl<SessionManager>()
                                        .getUserDetails()!
                                        .data!
                                        .vetId
                                        .toString())),
                            Navigator.pushReplacementNamed(
                              context,
                              homePage,
                            ),
                          },
                          padding: 0,
                          buttonHeight: 45,
                          buttonColor: ColorConstants.green,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return false;
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return ColorConstants.colorPrimaryDark;
    }
    return ColorConstants.colorPrimaryDark;
  }
}
