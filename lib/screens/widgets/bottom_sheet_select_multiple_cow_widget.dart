import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/models/cow_list_model.dart';
import 'package:ndumeappflutter/screens/widgets/custom_button.dart';

import '../../core/logger.dart';
import '../../resources/color_constants.dart';
import '../blocs/cowRecordBloc/cow_record_bloc.dart';
import 'loading_widget.dart';

class BottomSheetSelectMultipleCowWidget extends StatefulWidget {
  final List<CowRecordsModel> selectedCowList;

  const BottomSheetSelectMultipleCowWidget({required this.selectedCowList, Key? key})
      : super(key: key);

  @override
  State<BottomSheetSelectMultipleCowWidget> createState() =>
      _BottomSheetSelectMultipleCowWidgetState();
}

class _BottomSheetSelectMultipleCowWidgetState extends State<BottomSheetSelectMultipleCowWidget> {
  final List<CowRecordsModel> selectedCowList = [];

  @override
  void initState() {
    super.initState();
    selectedCowList.addAll(widget.selectedCowList);
    final mobileNumber = context.read<CowRecordBloc>().mobileNumber;
    context
        .read<CowRecordBloc>()
        .add(FetchCowRecordsEvent(mobileNumber: mobileNumber, isFetchNew: false));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Select Multiple Cow',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: ColorConstants.colorPrimaryDark, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<CowRecordBloc, CowRecordState>(
          buildWhen: (_, state) {
            if (state is LoadingCowRecordsState || state is LoadCowRecordsState) {
              return true;
            }
            return false;
          },
          builder: (_, state) {
            logger.d('the state for loading cow is  : $state ');
            if (state is LoadingCowRecordsState) {
              return const LoadingWidget();
            } else if (state is LoadCowRecordsState) {
              final list = state.cowRecords;
              return Expanded(
                child: ListView.separated(
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    return InkWell(
                      onTap: () {
                        //widget.onCowSelected(list[i]);
                        selectedCowList.any((element) => element.id == list[i].id);
                        if (selectedCowList.any((element) => element.id == list[i].id)) {
                          selectedCowList.remove(list[i]);
                        } else {
                          selectedCowList.add(list[i]);
                        }
                        logger.i('the data is $selectedCowList');
                        setState(() {});
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  list[i].title == null ? '' : list[i].title!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              selectedCowList.any((element) => element.id == list[i].id)
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.black,
                                    )
                                  : const SizedBox.shrink()
                            ],
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
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ButtonWidget(
          buttonText: 'Done',
          padding: 5,
          onPressButton: () {
            Navigator.pop(context, {'selectedCowList': selectedCowList});
          },
          buttonColor: ColorConstants.colorPrimaryDark,
          textColor: Colors.white,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
