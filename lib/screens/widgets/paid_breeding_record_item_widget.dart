import 'package:flutter/material.dart';

import '../../data/models/breeding_model.dart';
import '../../data/models/paid_breeding_record_model.dart';
import '../../injection_container.dart';
import '../../resources/image_resources.dart';
import '../../util/common_functions.dart';

class PaidBreedingRecordItemWidget extends StatelessWidget {

  final PaidBreedingRecord breedingData;

  const PaidBreedingRecordItemWidget({Key? key, required this.breedingData}) : super(key: key);

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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Paid Amount'.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    "Khs ${breedingData.walletAmount}",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ],
          )

        ],
      ),
    );
  }
}
