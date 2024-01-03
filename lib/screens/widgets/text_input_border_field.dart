import 'package:flutter/material.dart';

import '../../resources/color_constants.dart';

class TextInputBorderField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isEnabled;

  const TextInputBorderField(
      {required this.controller, required this.hint, this.isEnabled = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      controller: controller,
      keyboardType: TextInputType.name,
      textAlign: TextAlign.start,
      enabled: isEnabled,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        fillColor: ColorConstants.transparent,
        focusColor: Colors.grey,
        counterText: "",
        hintStyle: const TextStyle(color: Colors.white),
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        alignLabelWithHint: true,
      ),
    );
  }
}
