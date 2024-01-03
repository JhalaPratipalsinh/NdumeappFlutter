import 'package:flutter/material.dart';

class SemenSourceRadioWidget extends StatefulWidget {
  final String selectedValue;
  final Function onValueSelect;

  const SemenSourceRadioWidget({required this.selectedValue, required this.onValueSelect, Key? key})
      : super(key: key);

  @override
  State<SemenSourceRadioWidget> createState() => _SemenSourceRadioWidgetState();
}

class _SemenSourceRadioWidgetState extends State<SemenSourceRadioWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          value: 'SEXED',
          fillColor: MaterialStateProperty.all(Colors.white),
          groupValue: selectedValue,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (value) {
            widget.onValueSelect(value);
            selectedValue = value!;
            setState(() {});
          },
        ),
        const Text(
          'SEXED',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          width: 20,
        ),
        Radio<String>(
          value: 'NON SEXED',
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
          'NON SEXED',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
