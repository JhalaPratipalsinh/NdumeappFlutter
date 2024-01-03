import 'package:flutter/material.dart';

import '../resources/color_constants.dart';
import '../util/constants.dart';
import 'widgets/custom_button.dart';

class StartActivity extends StatefulWidget {
  const StartActivity({Key? key}) : super(key: key);

  @override
  State<StartActivity> createState() => _StartActivityState();
}

class _StartActivityState extends State<StartActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimaryDark,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 110,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset("${images}logo.png")),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 30,
          ),
          ButtonWidget(
            buttonText: "Register",
            onPressButton: () {
              Navigator.pushReplacementNamed(
                context,
                registrationPage,
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ButtonWidget(
            buttonText: "Login",
            onPressButton: () {
              Navigator.pushReplacementNamed(
                context,
                loginPage,
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
