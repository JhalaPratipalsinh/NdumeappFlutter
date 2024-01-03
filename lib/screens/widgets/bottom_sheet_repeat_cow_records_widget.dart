import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/repeat_cow_model.dart';
import '../../resources/color_constants.dart';
import '../blocs/breedingBloc/breeding_bloc.dart';
import '../blocs/cowRecordBloc/cow_record_bloc.dart';
import 'loading_widget.dart';

class BottomSheetRepeatCowRecordsWidget extends StatefulWidget {
  final Function onCowSelected;

  const BottomSheetRepeatCowRecordsWidget({required this.onCowSelected, Key? key})
      : super(key: key);

  @override
  State<BottomSheetRepeatCowRecordsWidget> createState() =>
      _BottomSheetRepeatCowRecordsWidgetState();
}

class _BottomSheetRepeatCowRecordsWidgetState extends State<BottomSheetRepeatCowRecordsWidget> {
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
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Select Cow',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: ColorConstants.colorPrimaryDark, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<BreedingBloc, BreedingState>(
            buildWhen: (_, state) =>
                state is HandleBreedingListState || state is LoadingBreedingState,
            builder: (_, state) {
              if (state is LoadingBreedingState) {
                return const LoadingWidget();
              } else if (state is HandleBreedingListState) {
                final cowList = state.response.data!.where((element) {
                  if (element.pgStatus == null) {
                    return true;
                  }
                  if (element.createdAt != null) {
                    if (checkDataCreatedBeforeMonth(element.createdAt)) {
                      return true;
                    }
                  }
                  return element.pgStatus == '0';
                }).map((e) {
                  return RepeatCowModel(
                      breedingID: e.id!,
                      cowID: e.cowId!,
                      cowName: e.cowName!,
                      bullBreedId: e.strawBreed==null ? "": e.strawBreed!,
                      bullBreed: e.bullName!,
                      repeats: e.repeats!);
                }).toList();

                return Expanded(
                  child: ListView.separated(
                    itemCount: cowList.length,
                    itemBuilder: (_, i) {
                      return InkWell(
                        onTap: () {
                          widget.onCowSelected(cowList[i]);
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              cowList[i].cowName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(10),
          child: /*Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, registerCow);
                      },
                      child: const Text(''))),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
              ),
            ],
          )*/
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
        )
      ],
    );
  }

  bool checkDataCreatedBeforeMonth(String createdAt) {
    DateTime dt1 = DateTime.parse(createdAt);
    DateTime dt2 = DateTime.now();

    Duration diff = dt1.difference(dt2);

    if (diff.inDays >= 30) {
      return true;
    }
    return false;
  }
}
