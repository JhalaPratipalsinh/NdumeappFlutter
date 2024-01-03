import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';

import '../core/logger.dart';
import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../util/common_functions.dart';
import '../util/constants.dart';
import 'blocs/loginBloc/login_bloc.dart';
import 'widgets/custom_button.dart';
import 'widgets/text_field_widget.dart';

class ForgotPinActivity extends StatefulWidget {
  const ForgotPinActivity({Key? key}) : super(key: key);

  @override
  State<ForgotPinActivity> createState() => _ForgotPinActivityState();
}

class _ForgotPinActivityState extends State<ForgotPinActivity> {
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstants.colorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Forgot Password",
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 50),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please enter your registered mobile no \n you will get SMS with new Password in you registered mobile.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              controller: _mobileController,
              hint: 'Enter mobile no.',
              textInputType: TextInputType.number,
              obscureText: false,
            ),
            SizedBox(
              height: 30,
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is MasterLoadingState) {
                  return LoadingWidget();
                } else if (state is ForgotPasswordState) {
                  if (state.response.success!) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      loginPage,
                      (route) => false,
                    );
                  } else {
                    sl<CommonFunctions>().showSnackBar(
                        context: context, message: state.response.message!);
                  }
                  return ButtonWidget(
                    buttonText: 'Forgot password'.toUpperCase(),
                    onPressButton: () => _validation(),
                    isWrap: true,
                    buttonInnerPadding: 15,
                    buttonColor: ColorConstants.green,
                    textColor: Colors.white,
                  );
                } else {
                  return ButtonWidget(
                    buttonText: 'Forgot password'.toUpperCase(),
                    onPressButton: () => _validation(),
                    isWrap: true,
                    buttonInnerPadding: 15,
                    buttonColor: ColorConstants.green,
                    textColor: Colors.white,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _validation() {

    final mobileNumber =
    sl<CommonFunctions>().checkNumberIsValid(_mobileController.text);
    logger.i('the number entered is :$mobileNumber');
    if (mobileNumber.length == 12) {
      context
          .read<LoginBloc>()
          .add(ForgotPasswordEvent(mobileNumber));

      return;
    } else {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please enter mobile number');
    }
  }
}
