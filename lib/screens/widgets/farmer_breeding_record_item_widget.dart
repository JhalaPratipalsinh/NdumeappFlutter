import 'package:flutter/material.dart';
import 'package:ndumeappflutter/screens/widgets/custom_button.dart';

import '../../data/models/breeding_model.dart';
import '../../injection_container.dart';
import '../../resources/image_resources.dart';
import '../../util/common_functions.dart';

class FarmerBreedingRecordItemWidget extends StatelessWidget {
  final BreedingData breedingData;
  final Function onViewClicked;

  const FarmerBreedingRecordItemWidget(
      {required this.breedingData, required this.onViewClicked, Key? key})
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
              breedingData.cowName!,
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(
              breedingData.repeats == '0' ? 'New AI' : 'Repeat AI',
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
            'Date Inseminated',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            sl<CommonFunctions>().convertDateToDDMMMYYYY(breedingData.dateDt!),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Vet Name',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            breedingData.vetName ?? '',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
