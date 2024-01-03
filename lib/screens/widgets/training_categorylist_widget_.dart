import 'package:flutter/material.dart';

import '../../data/models/farmer_model.dart';
import '../../resources/color_constants.dart';

class TrainingCategoryWidget extends StatelessWidget {
  final String catName;
  const TrainingCategoryWidget({required this.catName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 10,top: 5,bottom: 5),
      child: Row(
        children: [
          Expanded(
              child: Text(
                catName,
                style: TextStyle(fontSize: 16, color: Colors.white),
              )),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 40,
          ),
        ],
      ),
    );
  }
}
