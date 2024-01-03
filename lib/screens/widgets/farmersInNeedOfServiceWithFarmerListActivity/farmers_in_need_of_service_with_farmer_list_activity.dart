import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../resources/color_constants.dart';
import '../../../util/constants.dart';
import '../../commonWidgets/my_text_field.dart';
import 'widgets/farmer_detail_list_row_widget.dart';

class FarmersInNeedOfServiceWithFarmerListActivity extends StatefulWidget {
  const FarmersInNeedOfServiceWithFarmerListActivity({Key? key})
      : super(key: key);

  @override
  State<FarmersInNeedOfServiceWithFarmerListActivity> createState() =>
      _FarmersInNeedOfServiceWithFarmerListActivityState();
}

class _FarmersInNeedOfServiceWithFarmerListActivityState
    extends State<FarmersInNeedOfServiceWithFarmerListActivity> {
  DateTime? selectedMainDate;
  final dateMMDDYYYYFormat = DateFormat('MM-dd-yyyy');

  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  final TextEditingController _farmerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimaryDark,
      appBar: AppBar(
        backgroundColor: ColorConstants.appColor,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Farmers In Need Of Service',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyTextfield(
                      hint: 'From Date',
                      textEditingController: _startDate,
                      readonly: true,
                      ontap: () {
                        selectDate(true);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: MyTextfield(
                      hint: 'To Date',
                      textEditingController: _endDate,
                      readonly: true,
                      ontap: () {
                        selectDate(false);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: ColorConstants.appColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildDetailListTile(title: "Pregnancy Diagnosis", dueCount: 5),
              const SizedBox(
                height: 10,
              ),
              _buildDetailListTile(title: "Deworming", dueCount: 3),
              const SizedBox(
                height: 10,
              ),
              _buildDetailListTile(title: "Vaccination", dueCount: 2),
              const SizedBox(
                height: 15,
              ),
              MyTextfield(
                textEditingController: _farmerName,
                hint: 'Filter by Name',
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "34 Farmers",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.separated(
                  //controller: _scrollController,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (_, i) {
                    return const FarmerDetailListRowWidget();
                  },
                  separatorBuilder: (_, i) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildDetailListTile({
    required String title,
    required int dueCount,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, farmerInNeedOfService, arguments: {
          'title': "$title due ($dueCount)",
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white, width: 0.5)),
        padding: const EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text('$dueCount Due Today',
                    style: const TextStyle(color: Colors.white, fontSize: 12))
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  void selectDate(bool isStartDate) async {
    await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate:
          selectedMainDate == null ? DateTime.now() : selectedMainDate!,
      firstDate: DateTime.now().add(const Duration(days: -100000)),
      lastDate: DateTime.now(),
    ).then((newDate) {
      if (newDate != null) {
        selectedMainDate = newDate;
        String formattedDate = dateMMDDYYYYFormat.format(newDate);
        if (isStartDate) {
          _startDate.text = formattedDate;
        } else {
          _endDate.text = formattedDate;
        }
      }
    });
  }
}
