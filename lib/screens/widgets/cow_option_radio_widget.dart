import 'package:flutter/material.dart';

class CowOptionRadioWidget extends StatefulWidget {
  final String selectedValue;
  final Function onValueSelect;

  const CowOptionRadioWidget({required this.selectedValue, required this.onValueSelect, Key? key})
      : super(key: key);

  @override
  State<CowOptionRadioWidget> createState() => _SemenRadioWidgetState();
}

class _SemenRadioWidgetState extends State<CowOptionRadioWidget> {
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          width: 35,
        ),
        Radio<String>(
          value: 'Single Cow',
          fillColor: MaterialStateProperty.all(Colors.white),
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
          'Single Cow',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          width: 20,
        ),
        Radio<String>(
          value: 'Multiple Cow',
          groupValue: selectedValue,
          fillColor: MaterialStateProperty.all(Colors.white),
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
          'Multiple Cow',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
