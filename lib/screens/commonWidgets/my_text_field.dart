import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextfield extends StatelessWidget {
  TextStyle? style;
  TextInputType? keyboardtype;
  TextInputAction? textInputAction;
  int? maxlength;
  TextAlign? textAlign;
  TextEditingController? textEditingController;
  InputDecoration? decoration;
  String? hint;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  String? Function(String?)? validator;
  int? maxLine;
  void Function()? ontap;
  final Function(String)? onChanged;
  bool readonly;
  List<TextInputFormatter>? inputFormatters;
  double height;
  double width;
  bool isResizable;

  MyTextfield({
    Key? key,
    this.style,
    this.keyboardtype,
    this.textInputAction,
    this.maxlength,
    this.textAlign,
    this.textEditingController,
    this.decoration,
    this.hint,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.validator,
    this.maxLine,
    this.ontap,
    this.onChanged,
    this.readonly = false,
    this.inputFormatters,
    this.height = 50,
    this.width = double.infinity,
    this.isResizable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isResizable) {
      return SizedBox(
        height: height,
        width: width,
        child: _buildTextFormField(),
      );
    } else {
      return _buildTextFormField();
    }
  }

  Widget _buildTextFormField() {
    return TextFormField(
      onTap: ontap,
      readOnly: readonly,
      style: style ??
          TextStyle(
            color: color ?? Colors.white,
            fontSize: 16,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
      keyboardType: keyboardtype ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      maxLength: maxlength,
      textAlign: textAlign ?? TextAlign.left,
      controller: textEditingController,
      cursorColor: Colors.white,
      validator: validator,
      maxLines: maxLine,
      inputFormatters: inputFormatters,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      decoration: getInputDecoration(),
    );
  }

  InputDecoration getInputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      counterText: "",
      hintText: hint,
      // labelText: hint,
      // labelStyle: const TextStyle(color: Colors.white),
      contentPadding: const EdgeInsets.all(10),
      hintStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      // labelStyle: Theme.of(getContext).textTheme.bodyText2?.copyWith(
      //       color: ColorConstants.custDarkPurple160935,
      //     ),
      // floatingLabelStyle: Theme.of(getContext).textTheme.headline2?.copyWith(
      //       color: ColorConstants.custDarkPurple160935,
      //     ),
    );
  }
}
