import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropDown<T> extends StatefulWidget {
  T value;
  final List<T> itemsList;
  final Color dropdownColor;
  final Function onChanged;
  final bool isExpanded;
  final double margin;
  final List<DropdownMenuItem<T>> dropDownMenuItems;
  final bool showDropdown;


  CustomDropDown({
    required this.value,
    required this.itemsList,
    required this.dropdownColor,
    required this.onChanged,
    required this.dropDownMenuItems,
    this.isExpanded = true,
    this.showDropdown = true,
    this.margin = 35,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.margin),
      height: 45,
      decoration: BoxDecoration(
        color: widget.dropdownColor,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: DropdownButton<T>(
            icon: widget.showDropdown ? const Icon(Icons.arrow_drop_down) : const SizedBox.shrink(),
            isExpanded: widget.isExpanded,
            isDense: true,
            dropdownColor: widget.dropdownColor,
            value: widget.value,
            items: widget.dropDownMenuItems,
            onChanged: (value) => updateValue(value as T),
          ),
        ),
      ),
    );
  }

  void updateValue(T value) {
    widget.value = value;
    widget.onChanged(value);
    setState(() {});
  }
}
