import 'package:flutter/material.dart';
import 'package:ndumeappflutter/core/logger.dart';
import 'package:ndumeappflutter/data/models/farmer_model.dart';
import 'package:ndumeappflutter/resources/image_resources.dart';

import '../../util/constants.dart';

class FarmersItemWidget extends StatelessWidget {
  final FarmerData farmerData;

  const FarmersItemWidget({required this.farmerData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.i(
        'the total Data : ${farmerData.totalBreedingRecord! + farmerData.totalHealthRecord!} records');

    return InkWell(
      onTap: () {
        /*final name =
            '${sl<SessionManager>().getUserDetails()!.data!.vetFname!} ${sl<SessionManager>().getUserDetails()!.data!.vetSname!}';
        context
            .read<CowRecordBloc>()
            .setFarmerVetDetails(farmerData.mobileNumber ?? '', name, '${farmerData.farmerVetId!}');*/

        Navigator.of(context).pushNamed(farmerDetail,
            arguments: {'mobile': farmerData.mobileNumber!, 'farmerName': farmerData.farmerName!});
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(ImageResources.circularAvatar),
        title: Text(
          farmerData.farmerName ?? '',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          farmerData.mobileNumber ?? '',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: Text(
          '${farmerData.totalBreedingRecord! + farmerData.totalHealthRecord!} records',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
