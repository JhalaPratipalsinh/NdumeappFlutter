import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/farmer_model.dart';
import '../../../../data/sessionManager/session_manager.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../blocs/farmerBloc/farmer_bloc.dart';
import '../../farmers_item_widget.dart';
import '../../loading_widget.dart';

class MyFarmersDataWidget extends StatefulWidget {
  const MyFarmersDataWidget({Key? key}) : super(key: key);

  @override
  State<MyFarmersDataWidget> createState() => _MyFarmersDataWidgetState();
}

class _MyFarmersDataWidgetState extends State<MyFarmersDataWidget> {
  final _filterByNameController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<FarmerData> farmerData = [];
  List<FarmerData> tempFarmerData = [];
  bool isReferesh = false;
  int start = 0;
  int limit = 30;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onRefresh);
    final vetID = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
    context.read<FarmerBloc>().add(FetchFarmersEvent(vetID: vetID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmerBloc, FarmerState>(
      builder: (_, state) {
        if (state is LoadingFarmersState) {
          return const LoadingWidget();
          //_refreshController.refreshCompleted();
        }
        if (state is HandleFarmersListState) {
          isReferesh = false;
          farmerData.clear();
          farmerData.addAll(state.response);
          return Container(
            color: ColorConstants.colorPrimaryDark,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  autofocus: false,
                  controller: _filterByNameController,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  cursorColor: Colors.white,
                  onChanged: (String query) {
                    tempFarmerData = farmerData.where((element) {
                      String title = element.farmerName!.toLowerCase();
                      return title.contains(query);
                    }).toList();

                    setState(() {});
                  },
                  decoration: InputDecoration(
                    fillColor: ColorConstants.transparent,
                    focusColor: Colors.grey,
                    counterText: "",
                    hintStyle: const TextStyle(color: Colors.white),
                    hintText: 'Filter by Name',
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
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    '${_filterByNameController.text.isEmpty ? farmerData.length : tempFarmerData.length} Farmers',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    //controller: _scrollController,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      return FarmersItemWidget(
                        farmerData: _filterByNameController.text.isEmpty
                            ? farmerData[i]
                            : tempFarmerData[i],
                      );
                    },
                    itemCount: _filterByNameController.text.isEmpty
                        ? farmerData.length
                        : tempFarmerData.length,
                  ),
                )
              ],
            ),
          );
        }
        return const Center(
          child: Text(
            "Data not Found \n please Add some records",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  void _onRefresh() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      start = start + (limit + 1);
      final vetID = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
      isReferesh = true;
      context
          .read<FarmerBloc>()
          .add(FetchFarmersEvent(vetID: vetID, start: start, limit: limit));
    }

    //context.read<HomeBloc>().add(const FetchHomeData());
  }
}
