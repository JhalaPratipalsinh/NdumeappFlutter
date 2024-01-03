import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/serviceDueBloc/servicedue_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/serviceDueBloc/servicedue_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/models/pregnency_service_duelist_model.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../util/common_functions.dart';

class FarmersInNeedOfServiceListRowWidget extends StatefulWidget {
  final PregnencyDue data;
  final String recordType;

  const FarmersInNeedOfServiceListRowWidget(
      {Key? key, required this.data, required this.recordType})
      : super(key: key);

  @override
  State<FarmersInNeedOfServiceListRowWidget> createState() =>
      _FarmersInNeedOfServiceListRowWidgetState();
}

class _FarmersInNeedOfServiceListRowWidgetState
    extends State<FarmersInNeedOfServiceListRowWidget> {
  @override
  Widget build(BuildContext context) {
    const spaceBetweenSizedBox = SizedBox(
      height: 5,
    );
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          _buildRow(leading: 'Name : ', trailing: widget.data.farmerName!),
          _buildRow(leading: 'Phone Number : ', trailing: widget.data.mobile!),
          _buildRow(leading: 'Cow Name : ', trailing: widget.data.cowName!),
          widget.data.date != null
              ? _buildRow(
                  leading: 'Date Of Service : ', trailing: widget.data.date!)
              : _buildRow(
                  leading: 'Date Of Service : ',
                  trailing: widget.data.treatmentDate!),
          spaceBetweenSizedBox,
          _buildRowButtons(
              widget.data!.id.toString(), widget.recordType, context),
          /*BlocBuilder<ServicedueBloc, ServicedueState>(
            buildWhen: (previous, current) =>
                previous != current &&
                (current is UpdatingRecordStatusState ||
                    current is RecordStatusUpdatedState),
            builder: (context, state) {
              if (state is UpdatingRecordStatusState) {
                return LoadingWidget();
              } else if (state is RecordStatusUpdatedState) {
                if(state.response!.success!) {
                  launchUrl(Uri.parse("tel:${widget.data.mobile!}"));
                }
                sl<CommonFunctions>().showSnackBar(
                  context: context,
                  message: state.response.message!,
                );
                return _buildRowButtons(
                    widget.data!.id.toString(), widget.recordType, context);

              } else {
                return _buildRowButtons(
                    widget.data!.id.toString(), widget.recordType, context);
              }
            },
          )*/
        ],
      ),
    );
  }

  Widget _buildRow({required String leading, required String trailing}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          leading,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
        ),
        Expanded(
          child: Text(
            trailing,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  Widget _buildRowButtons(
      String recordId, String recordType, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            context.read<ServicedueBloc>().add(UpdateRecordStatusEvent(
                recordId: recordId,
                recordType: recordType,
                comType: "sms",
                status: "1"));

            launchUrl(Uri.parse(
                "sms:${widget.data.mobile!}?body=Hello Mr, ${widget.data.farmerName} your cow ${widget.data.cowName} for pregancy scanning. Please let me know when you will be available?"));
          },
          child: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: ColorConstants.appColor,
                borderRadius: BorderRadius.circular(5)),
            child: const Text(
              'Send SMS',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            context.read<ServicedueBloc>().add(UpdateRecordStatusEvent(
                recordId: recordId,
                recordType: recordType,
                comType: "call",
                status: "1"));

            launchUrl(Uri.parse("tel:${widget.data.mobile!}"));
          },
          child: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: ColorConstants.appColor,
                borderRadius: BorderRadius.circular(5)),
            child: const Text(
              'Call',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
