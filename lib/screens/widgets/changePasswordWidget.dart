import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/loginBloc/login_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';

import '../../data/sessionManager/session_manager.dart';
import '../../injection_container.dart';
import '../../resources/color_constants.dart';
import '../../util/common_functions.dart';
import '../../util/constants.dart';
import 'custom_button.dart';
import 'text_field_widget.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 50),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please enter required detail to change password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              controller: _oldPassController,
              hint: 'Enter Old password',
              textInputType: TextInputType.number,
              obscureText: true,
            ),
            TextFieldWidget(
              controller: _newPassController,
              hint: 'Enter New Password.',
              textInputType: TextInputType.number,
              obscureText: true,
            ),
            TextFieldWidget(
              controller: _confirmPassController,
              hint: 'Enter Confirm Password.',
              textInputType: TextInputType.number,
              obscureText: true,
            ),
            SizedBox(
              height: 30,
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is MasterLoadingState) {
                  return LoadingWidget();
                } else if (state is ChangePasswordState) {

                  if (state.response.success!) {

                    sl<CommonFunctions>().showSnackBar(
                        context: context, message: state.response.message!+" You have to login again.");

                    sl<SessionManager>().initiateLogout();

                    SchedulerBinding.instance.addPostFrameCallback((_) {

                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        loginPage,
                            (route) => false,
                      );
                    });


                  }else {
                    sl<CommonFunctions>().showSnackBar(
                        context: context, message: state.response.message!);
                  }
                  return ButtonWidget(
                    buttonText: 'Change password'.toUpperCase(),
                    onPressButton: () => _validation(),
                    isWrap: true,
                    buttonInnerPadding: 15,
                    buttonColor: ColorConstants.green,
                    textColor: Colors.white,
                  );
                } else {
                  return ButtonWidget(
                    buttonText: 'Change password'.toUpperCase(),
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
    if (_oldPassController.text.isEmpty) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please enter current password');
      return;
    } else if (_newPassController.text.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please enter New password');
    } else if (_newPassController.text != _confirmPassController.text) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please confirm password not match');
    } else {
      context.read<LoginBloc>().add(
          ChangePassworEvent(_oldPassController.text, _newPassController.text));
    }
  }
}
