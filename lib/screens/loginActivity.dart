import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/core/logger.dart';
import 'package:ndumeappflutter/injection_container.dart';
import 'package:ndumeappflutter/resources/color_constants.dart';
import 'package:ndumeappflutter/screens/blocs/loginBloc/login_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/custom_button.dart';
import 'package:ndumeappflutter/screens/widgets/inputfields.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';
import 'package:ndumeappflutter/util/common_functions.dart';
import 'package:ndumeappflutter/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({Key? key}) : super(key: key);

  @override
  State<LoginActivity> createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  TextEditingController mobilenoCntrl = TextEditingController();
  TextEditingController passwordCntrl = TextEditingController();
  bool isTermsCondition = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        if (state is ErrorState) {
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: state.message,
            bgColor: Colors.red,
          );

          if (state.message == "User not registered, Please register.") {
            Navigator.pushReplacementNamed(context, registrationPage);
          }
        } else if (state is LoginResponseState) {
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: state.response.message!,
          );
          if (state.response.success != null) {
            if (state.response.success!) {
              Navigator.pushReplacementNamed(context, homePage);
            }
          }
        }
      },
      child: WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(
            context,
            startScreen,
          );

          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: ColorConstants.colorPrimaryDark,
          appBar: AppBar(
            backgroundColor: ColorConstants.colorPrimary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  startScreen,
                );
              },
            ),
            centerTitle: true,
            title: const Text(
              "Vet Login",
            ),
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                    height: 110,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset("${images}logo.png")),
                const SizedBox(
                  height: 35,
                ),
                InputTextField(
                    controller: mobilenoCntrl,
                    hint: "Enter Mobile",
                    inputType: TextInputType.number,
                    inputIcon: '${icon}phone_icon.png'),
                const SizedBox(
                  height: 25,
                ),
                InputTextField(
                    controller: passwordCntrl,
                    hint: "Enter Password",
                    inputType: TextInputType.number,
                    inputIcon: '${icon}lock_icon.png',
                    obscureText: true),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, forgotPassPage);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: const Text(
                      "Forgot password?",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 16, color: Colors.yellow),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 25, left: 30),
                  child: Row(
                    children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isTermsCondition,
                        onChanged: (bool? value) {
                          setState(() {
                            isTermsCondition = value!;
                          });
                        },
                      ),
                      const Text(
                        "Terms & Condition",
                        style: TextStyle(fontSize: 14, color: Colors.white),
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
                            style:
                                TextStyle(fontSize: 14, color: Colors.yellow),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (_, state) {
                    if (state is MasterLoadingState) {
                      return const LoadingWidget();
                    }
                    return ButtonWidget(
                      buttonText: "Login",
                      onPressButton: () {
                        validateAndLogin();
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        registrationPage,
                      );
                    },
                    child: const Text("New Provider ? Register here",
                        style: TextStyle(
                            color: ColorConstants.colorPrimary,
                            fontWeight: FontWeight.bold))),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.yellow;
  }

  void validateAndLogin() {
    /* Navigator.pushReplacementNamed(context, homePage);
    return;*/
    if (mobilenoCntrl.text.isEmpty) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please enter mobile number');
      return;
    } else if (!isTermsCondition) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please accept Terms & condition');
      return;
    } else {
      final mobileNumber =
          sl<CommonFunctions>().checkNumberIsValid(mobilenoCntrl.text);
      logger.i('the number entered is :$mobileNumber');
      if (mobileNumber.length == 12) {
        if (passwordCntrl.text.length != 4) {
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: 'Please enter 4 digit no password',
          );
          return;
        }
        context
            .read<LoginBloc>()
            .add(InitiateLoginEvent(mobileNumber, passwordCntrl.text));
      } else {
        sl<CommonFunctions>().showSnackBar(
          context: context,
          message: 'Please enter valid mobile number',
        );
      }
    }
  }
}
