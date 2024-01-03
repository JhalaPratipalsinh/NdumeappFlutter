import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/breeding_model.dart';
import '../data/models/paid_breeding_record_model.dart';
import '../resources/color_constants.dart';
import 'blocs/breedingBloc/breeding_bloc.dart';
import 'widgets/loading_widget.dart';
import 'widgets/paid_breeding_record_item_widget.dart';

class PaidBreedingRecodListActivity extends StatefulWidget {
  const PaidBreedingRecodListActivity({Key? key}) : super(key: key);

  @override
  State<PaidBreedingRecodListActivity> createState() =>
      _PaidBreedingRecodListActivityState();
}

class _PaidBreedingRecodListActivityState
    extends State<PaidBreedingRecodListActivity> {

  final _filterByCowController = TextEditingController();
  List<PaidBreedingRecord> totalBreedingData = [];
  List<PaidBreedingRecord> tempTotalBreedingData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimaryDark,
      appBar: AppBar(
        backgroundColor: ColorConstants.colorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Paid Breeding Record',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: BlocBuilder<BreedingBloc, BreedingState>(
        builder: (_, state) {
          if (state is LoadingBreedingState) {
            return const LoadingWidget();
          } else if (state is PaidBreedingRecordListState) {
            totalBreedingData = state.response.paidBreedingRecord!;
            return Container(
              color: ColorConstants.colorPrimaryDark,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          autofocus: false,
                          controller: _filterByCowController,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.start,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                          onChanged: (String query) {
                            tempTotalBreedingData =
                                totalBreedingData.where((element) {
                              String title = element.cowName!.toLowerCase();
                              return title.contains(query);
                            }).toList();

                            setState(() {});
                          },
                          decoration: InputDecoration(
                            fillColor: ColorConstants.transparent,
                            focusColor: Colors.grey,
                            counterText: "",
                            hintStyle: const TextStyle(color: Colors.white),
                            hintText: 'Filter by Cow',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            alignLabelWithHint: true,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (_, i) {
                              return InkWell(
                                onTap: () async {
                                  /*final breeding = _filterByCowController.text.isEmpty
                                        ? totalBreedingData[i]
                                        : tempTotalBreedingData[i];
                                    moveToBreedingDetail(breeding);*/
                                },
                                child: PaidBreedingRecordItemWidget(
                                  breedingData:
                                      _filterByCowController.text.isEmpty
                                          ? totalBreedingData[i]
                                          : tempTotalBreedingData[i],
                                ),
                              );
                            },
                            itemCount: _filterByCowController.text.isEmpty
                                ? totalBreedingData.length
                                : tempTotalBreedingData.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }else if(state is HandleErrorBreedingState){
            return  Center(
              child: Text(
                state.error.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }else{
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
