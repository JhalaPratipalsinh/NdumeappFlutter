import 'package:flutter/material.dart';

class PregnancyStatusRadioWidget extends StatefulWidget {
  final String selectedValue;
  final Function onValueSelect;

  const PregnancyStatusRadioWidget(
      {required this.selectedValue, required this.onValueSelect, Key? key})
      : super(key: key);

  @override
  State<PregnancyStatusRadioWidget> createState() => _PregnancyStatusRadioWidgetState();
}

class _PregnancyStatusRadioWidgetState extends State<PregnancyStatusRadioWidget> {
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
          value: 'Yes',
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
          'Yes',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          width: 20,
        ),
        Radio<String>(
          value: 'No',
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
          'No',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
