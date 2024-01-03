import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ndumeappflutter/core/logger.dart';
import 'package:ndumeappflutter/resources/color_constants.dart';

import '../screens/widgets/custom_button.dart';
import 'constants.dart';

class CommonFunctions {
  const CommonFunctions();

  void showSnackBar(
      {required BuildContext context,
      required String message,
      Color bgColor = ColorConstants.colorPrimary,
      Color textColor = Colors.white,
      int duration = 2}) {
    /*final snackBar = SnackBar(
      margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: textColor, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
      ),
      backgroundColor: bgColor,
      duration: Duration(seconds: duration),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 16.0);
  }

  String checkNumberIsValid(String mobileNumber) {
    String prefix = "254";
    if (mobileNumber.startsWith("0")) {
      return prefix + mobileNumber.substring(1);
    }
    if (mobileNumber.startsWith("7")) {
      return prefix + mobileNumber;
    }
    if (mobileNumber.startsWith("+")) {
      return mobileNumber.substring(1);
    }
    if (mobileNumber.startsWith("1")) {
      return prefix + mobileNumber;
    }
    //no need to rewrite, just return the number
    return mobileNumber;
  }

  String generateDateAfterSpecificDate(DateTime selectedDate, int afterDays) {
    final date = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day + afterDays,
      selectedDate.hour,
      selectedDate.minute,
      selectedDate.second,
      selectedDate.millisecond,
      selectedDate.microsecond,
    );
    return dateAndTimeFormat.format(date);
  }

  String convertDateToDDMMMYYYY(String dateTime) {
    final DateTime dt1 = DateFormat('yyyy-MM-dd').parse(dateTime);
    final String expDateNew = dateAndTimeDDMMMYYYYFormat.format(dt1);
    return expDateNew;
  }

  Future<bool> showConfirmationDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required String buttonPositiveText,
      required String buttonNegativeText}) async {
    final result = await showDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorConstants.textColor1,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                            buttonText: buttonPositiveText,
                            padding: 0,
                            buttonHeight: 35,
                            onPressButton: () {
                              Navigator.of(context).pop(true);
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            side: const BorderSide(
                              width: 1.0,
                              color: ColorConstants.textColor1,
                            ),
                          ),
                          child: Text(
                            buttonNegativeText,
                            style: const TextStyle(color: ColorConstants.textColor1, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    return result ?? false;
  }

  bool dateIsLessThan24Hours(String dateUnderTest) {
    const dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"; //.SSS'Z'
    var now = DateFormat(dateFormat).format(DateTime.now());
    final DateTime dt1 = DateFormat(dateFormat).parse(dateUnderTest);
    final DateTime dt2 = DateFormat(dateFormat).parse(now);
    logger.i('the current date is $dt2 and the selected Date is $dt1');
    logger.i('the date difference is ${dt2.compareTo(dt1)} and ${dt2.difference(dt1).inHours}');

    // 0 denotes being equal positive value greater and negative value being less

    int difference = dt2.difference(dt1).inHours;

    /*if (dt2.compareTo(dt1) <= 0) {
      logger.i("Both date time are at same moment.");
      return true;
    }*/
    if (difference <= 24) {
      logger.i("Both date time are at same moment.");
      return true;
    }

    return false;
  }
}
