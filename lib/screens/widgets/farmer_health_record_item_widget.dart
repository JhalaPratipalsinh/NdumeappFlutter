// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ndumeappflutter/screens/widgets/custom_button.dart';

import '../../data/models/health_model.dart';
import '../../injection_container.dart';
import '../../resources/image_resources.dart';
import '../../util/common_functions.dart';

class FarmerHealthRecordItemWidget extends StatelessWidget {
  final HealthData healthData;
  final Function onViewClicked;

  const FarmerHealthRecordItemWidget(
      {required this.healthData, required this.onViewClicked, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.asset(ImageResources.cowAvatar),
            contentPadding: EdgeInsets.zero,
            title: Text(
              healthData.cowName!,
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(
              healthData.healthCategory!,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            trailing: ButtonWidget(
                buttonText: 'View',
                onPressButton: () async {
                  onViewClicked();
                },
                isWrap: true,
                padding: 0),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Date Treated',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            healthData.treatmentDate!.isNotEmpty ? sl<CommonFunctions>().convertDateToDDMMMYYYY(healthData.treatmentDate!):"",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16) ,
          ),
          Text(
            healthData.treatment!,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Vet Treated',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            healthData.vetName ?? '',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
