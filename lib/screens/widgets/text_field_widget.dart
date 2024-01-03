import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefixIcon;
  final TextInputType textInputType;
  final Color cursorColor;
  final Function? onChange;
  final bool obscureText;

  const TextFieldWidget(
      {required this.controller,
      required this.hint,
      required this.textInputType,
      this.prefixIcon,
      this.onChange,
      this.cursorColor = Colors.black,
      this.obscureText = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return prefixIcon == null
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextField(
              autofocus: false,
              obscureText: obscureText,
              cursorColor: cursorColor,
              controller: controller,
              keyboardType: textInputType,
              textAlign: TextAlign.center,
              onChanged: (String value) {
                if (onChange != null) {
                  onChange!(value);
                }
              },
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                focusColor: Colors.grey,
                counterText: "",
                contentPadding: EdgeInsets.zero,
                hintText: hint,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                alignLabelWithHint: true,
              ),
            ),
          )
        : TextField(
            autofocus: false,
            cursorColor: cursorColor,
            controller: controller,
            keyboardType: textInputType,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              focusColor: Colors.grey,
              counterText: "",
              contentPadding: const EdgeInsets.only(
                left: 10,
              ),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              prefixIcon: prefixIcon,
              alignLabelWithHint: true,
            ),
          );
  }
}
