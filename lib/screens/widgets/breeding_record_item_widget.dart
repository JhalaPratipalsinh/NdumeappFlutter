import 'package:flutter/material.dart';
import 'package:ndumeappflutter/resources/image_resources.dart';
import 'package:ndumeappflutter/util/common_functions.dart';

import '../../data/models/breeding_model.dart';
import '../../injection_container.dart';

class BreedingRecordItemWidget extends StatelessWidget {
  final BreedingData breedingData;

  const BreedingRecordItemWidget({required this.breedingData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Date Inseminated'.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            sl<CommonFunctions>().convertDateToDDMMMYYYY(breedingData.dateDt!),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Farmer Name'.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            breedingData.farmerName ?? '',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
