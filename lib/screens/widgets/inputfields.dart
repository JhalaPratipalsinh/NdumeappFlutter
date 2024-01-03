import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final bool obscureText;
  final String inputIcon;
  final Widget? prefixIcon;
  final bool isTextCenter;
  final bool isEnabled;

  const InputTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.inputType,
      required this.inputIcon,
      this.obscureText = false,
      this.isTextCenter = false,
      this.isEnabled = true,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 35),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (inputIcon.isNotEmpty) ...[
            Image.asset(
              inputIcon,
            ),
            const SizedBox(
              width: 15,
            ),
          ],
          Expanded(
            child: prefixIcon == null
                ? TextField(
                    enabled: isEnabled,
                    controller: controller,
                    keyboardType: inputType,
                    obscureText: obscureText,
                    textAlign: isTextCenter ? TextAlign.center : TextAlign.start,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: const TextStyle(color: Colors.black),
                      alignLabelWithHint: true,
                      border: InputBorder.none,
                    ),
                  )
                : TextField(
                    enabled: isEnabled,
                    controller: controller,
                    keyboardType: inputType,
                    obscureText: obscureText,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hintText: hint,
                        border: InputBorder.none,
                        prefixIcon: prefixIcon!),
                  ),
          ),
        ],
      ),
    );
  }
}
