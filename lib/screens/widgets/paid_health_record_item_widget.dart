import 'package:flutter/material.dart';

import '../../data/models/paid_health_record_model.dart';
import '../../resources/image_resources.dart';

class PaidHealthRecordItemWidget extends StatelessWidget {
  final PaidHealthRecord healthData;

  const PaidHealthRecordItemWidget({required this.healthData, Key? key}) : super(key: key);

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
              healthData.cowName!,
              style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(
              healthData.healthCategory!,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            healthData.healthCategory! == 'Treatment'
                ? 'Treated For'.toUpperCase()
                : healthData.healthCategory! == 'Vaccine'
                ? 'Vaccination Name'.toUpperCase()
                : 'Dewormer Name'.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            healthData.treatment!,
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
                      healthData.farmerName ?? '',
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
                    "Khs ${healthData.walletAmount}",
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
