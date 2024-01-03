import 'package:flutter/material.dart';

import 'text_input_border_field.dart';

const textStyle = TextStyle(color: Colors.white, fontSize: 16);

class BreedingTitleAndInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String inputText;
  final bool isEditable;
  final TextInputType inputType;
  final bool showSuffixIcon;
  final bool enableEditableInputField;

  const BreedingTitleAndInputWidget(
      {required this.controller,
      required this.inputText,
      required this.title,
      this.isEditable = false,
      this.showSuffixIcon = false,
      this.inputType = TextInputType.text,
      this.enableEditableInputField = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: textStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        !isEditable
            ? TextInputBorderField(
                controller: controller,
                hint: inputText,
                isEnabled: false,
              )
            : Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  enabled: enableEditableInputField,
                  controller: controller,
                  keyboardType: inputType,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: '',
                      border: InputBorder.none,
                      suffixIcon: showSuffixIcon
                          ? const Icon(Icons.calendar_month_sharp)
                          : const SizedBox.shrink()),
                ),
              ),
      ],
    );
  }
}
