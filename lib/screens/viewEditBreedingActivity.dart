import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/farmer_breeding_record_item_widget.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';

import '../data/models/breeding_model.dart';
import '../resources/color_constants.dart';
import '../util/constants.dart';
import 'blocs/breedingBloc/breeding_bloc.dart';
import 'blocs/cowRecordBloc/cow_record_bloc.dart';

class ViewEditBreedingActivity extends StatefulWidget {
  const ViewEditBreedingActivity({Key? key}) : super(key: key);

  @override
  State<ViewEditBreedingActivity> createState() => _ViewEditBreedingActivityState();
}

class _ViewEditBreedingActivityState extends State<ViewEditBreedingActivity> {
  final TextEditingController _searchController = TextEditingController();
  List<BreedingData> breedingList = [];
  List<BreedingData> tempBreedingList = [];

  @override
  void initState() {
    super.initState();
    String mobileNo = context.read<CowRecordBloc>().mobileNumber;
    context
        .read<BreedingBloc>()
        .add(FetchBreedingEvent(mobileNoOrVetId: mobileNo, isMobileNo: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimaryDark,
      appBar: AppBar(
        backgroundColor: ColorConstants.colorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'View Breeding Record',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.grey,
                counterText: "",
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Search...',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                alignLabelWithHint: true,
              ),
              controller: _searchController,
              keyboardType: TextInputType.text,
              onChanged: (String query) {
                tempBreedingList = breedingList.where((element) {
                  String title = element.cowName!.toLowerCase();
                  return title.contains(query);
                }).toList();
                setState(() {
                  tempBreedingList;
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<BreedingBloc, BreedingState>(builder: (_, state) {
            if (state is LoadingBreedingState) {
              return const LoadingWidget();
            } else if (state is HandleBreedingListState) {
              breedingList = state.response.data!;

              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      final breedingData =
                          _searchController.text.isEmpty ? breedingList[i] : tempBreedingList[i];
                      return FarmerBreedingRecordItemWidget(
                        breedingData: breedingData,
                        onViewClicked: () async {
                          await Navigator.of(context).pushNamed(breedingRecordDetail, arguments: {
                            'breedingID': '${breedingData.id}',
                            'repeats': breedingData.repeats ?? '0'
                          });
                          if (mounted) {
                            String mobileNo = context.read<CowRecordBloc>().mobileNumber;
                            context.read<BreedingBloc>().add(
                                FetchBreedingEvent(mobileNoOrVetId: mobileNo, isMobileNo: true));
                          }
                        },
                      ) /*Card(
                        color: Colors.white,
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${i + 1}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'Cow : ${breedingList[i].cowName!}'
                                        : 'Cow : ${tempBreedingList[i].cowName!}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'Date Inseminated : ${sl<CommonFunctions>().convertDateToDDMMMYYYY(breedingList[i].dateDt!)}'
                                        : 'Date Inseminated : ${sl<CommonFunctions>().convertDateToDDMMMYYYY(tempBreedingList[i].dateDt!)}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'Repeat : ${breedingList[i].repeats}'
                                        : 'Repeat : ${tempBreedingList[i].repeats}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'Expected Calving Date : ${sl<CommonFunctions>().convertDateToDDMMMYYYY(breedingList[i].expectedDateOfBirth!)}'
                                        : 'Expected Calving Date : ${sl<CommonFunctions>().convertDateToDDMMMYYYY(tempBreedingList[i].expectedDateOfBirth!)}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'Vet Name : ${breedingList[i].vetName!}'
                                        : 'Vet Name : ${tempBreedingList[i].vetName!}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )*/
                          ;
                    },
                    itemCount: _searchController.text.isEmpty
                        ? breedingList.length
                        : tempBreedingList.length),
              );
            }
            return const SizedBox.shrink();
          })
        ],
      ),
    );
  }
}
