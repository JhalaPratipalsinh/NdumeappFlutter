import 'package:flutter/material.dart';

class SemenRadioWidget extends StatefulWidget {
  final String selectedValue;
  final Function onValueSelect;

  const SemenRadioWidget({required this.selectedValue, required this.onValueSelect, Key? key})
      : super(key: key);

  @override
  State<SemenRadioWidget> createState() => _SemenRadioWidgetState();
}

class _SemenRadioWidgetState extends State<SemenRadioWidget> {
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
          value: 'Local Semen',
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
          'Local Semen',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(
          width: 10,
        ),
        Radio<String>(
          value: 'Imported Semen',
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
          'Imported Semen',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
