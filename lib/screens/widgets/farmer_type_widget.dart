import 'package:flutter/material.dart';
import 'package:ndumeappflutter/resources/color_constants.dart';

class FarmerTypeWidget extends StatefulWidget {
  final String selectedValue;

  final Function onValueSelect;

  const FarmerTypeWidget({required this.selectedValue, required this.onValueSelect, Key? key})
      : super(key: key);

  @override
  State<FarmerTypeWidget> createState() => _FarmerTypeWidgetState();
}

class _FarmerTypeWidgetState extends State<FarmerTypeWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Radio<String>(
          value: 'Male',
          fillColor: MaterialStateProperty.all(ColorConstants.appColor),
          groupValue: selectedValue,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (value) {
            widget.onValueSelect(value);

            setState(() {
              selectedValue = value!;
            });
          },
        ),
        const Text(
          'Male',
          style: TextStyle(color: ColorConstants.textColor1, fontSize: 14),
        ),
        const SizedBox(
          width: 5,
        ),
        Radio<String>(
          value: 'Female',
          groupValue: selectedValue,
          fillColor: MaterialStateProperty.all(ColorConstants.appColor),
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (value) {
            selectedValue = value!;
            widget.onValueSelect(value);
            setState(() {});
          },
        ),
        const Text(
          'Female',
          style: TextStyle(color: ColorConstants.textColor1, fontSize: 14),
        ),
        const SizedBox(
          width: 5,
        ),
        Radio<String>(
          value: 'Institution',
          groupValue: selectedValue,
          fillColor: MaterialStateProperty.all(ColorConstants.appColor),
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (value) {
            selectedValue = value!;
            widget.onValueSelect(value);
            setState(() {});
          },
        ),
        const Text(
          'Institution',
          style: TextStyle(color: ColorConstants.textColor1, fontSize: 14),
        ),
      ],
    );
  }
}
