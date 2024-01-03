import 'package:flutter/material.dart';
import 'package:ndumeappflutter/resources/color_constants.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function onPressButton;
  final bool isWrap;
  final double padding;
  final double fontSize;
  final double buttonRadius;
  final Color buttonColor;
  final Color textColor;
  final double buttonHeight;
  final double buttonInnerPadding;

  const ButtonWidget({
    required this.buttonText,
    required this.onPressButton,
    this.isWrap = false,
    this.padding = 35,
    this.fontSize = 14,
    this.buttonRadius = 10,
    this.buttonHeight = 50,
    this.buttonInnerPadding = 5,
    this.buttonColor = ColorConstants.colorPrimary,
    this.textColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: ElevatedButton(
        style: isWrap
            ? ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonRadius),
                ),
              )
            : ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(buttonHeight),
                onPrimary: Colors.white,
                primary: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonRadius),
                ),
              ),
        onPressed: () => onPressButton(),
        child: Padding(
          padding: EdgeInsets.all(buttonInnerPadding),
          child: Text(
            buttonText,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
