import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ndumeappflutter/screens/blocs/breedingBloc/breeding_bloc.dart';
import 'package:ndumeappflutter/screens/invoice_activity.dart';
import 'package:ndumeappflutter/screens/widgets/pregnancy_status_radio_widget.dart';
import 'package:ndumeappflutter/screens/widgets/semen_radio_widget.dart';
import 'package:ndumeappflutter/screens/widgets/semen_source_radio_widget.dart';
import 'package:ndumeappflutter/util/common_functions.dart';

import '../data/models/add_breeding_record_req_model.dart';
import '../data/models/breeding_model.dart';
import '../data/sessionManager/session_manager.dart';
import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../resources/image_resources.dart';
import '../util/constants.dart';
import 'widgets/breeding_title_and_input_widget.dart';

const textStyle = TextStyle(color: Colors.white, fontSize: 16);

enum EditOrDeleteType { edit, delete }

class BreedingRecordDetailActivity extends StatefulWidget {
  final String breedingID;
  final String repeats;

  const BreedingRecordDetailActivity(
      {required this.breedingID, required this.repeats, Key? key})
      : super(key: key);

  @override
  State<BreedingRecordDetailActivity> createState() =>
      _BreedingRecordDetailActivityState();
}

class _BreedingRecordDetailActivityState
    extends State<BreedingRecordDetailActivity> {
  final cowNameController = TextEditingController();
  final inseminatedDateController = TextEditingController();
  final repeatDateController = TextEditingController();
  final aiCostController = TextEditingController();
  final confirmationDateController = TextEditingController();
  final dryingDateController = TextEditingController();
  final steamingDateController = TextEditingController();
  final calvingDateController = TextEditingController();
  final bullNameController = TextEditingController();
  final bullCodeController = TextEditingController();
  final noStrawController = TextEditingController();

  String selectedPregnancyStatus = 'No';
  String selectedSemenSource = 'SEXED';
  String selectedSemenType = 'Local Semen';

  String repeatNo = '';
  BreedingData? breedingData;

  late Uint8List imageData;

  @override
  void initState() {
    super.initState();

    getImage();
    context
        .read<BreedingBloc>()
        .add(FetchBreedingDetailEvent(breedingID: widget.breedingID));
  }

  Future<void> getImage() async {
    final ByteData image = await rootBundle.load(ImageResources.icCowLogo);

    imageData = (image).buffer.asUint8List();
  }

  void showMessage(String message) {
    sl<CommonFunctions>().showSnackBar(context: context, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BreedingBloc, BreedingState>(
      listener: (_, state) {
        if (state is HandleErrorBreedingState) {
          showMessage(state.error);
        } else if (state is HandleDeleteBreedingState) {
          showMessage(state.response.message!);
          Navigator.pop(context, 'deleted');
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.colorPrimaryDark,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorConstants.colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            widget.repeats == '0' ? 'New A.I' : 'Repeat A.I',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          actions: [
            BlocBuilder<BreedingBloc, BreedingState>(
              builder: (_, state) {
                if (state is LoadingBreedingState ||
                    state is LoadingBreedingDetailState) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }
                return InkWell(
                    onTap: () {
                      showEditBottomSheet();
                    },
                    child: const Icon(Icons.mode_edit_outlined));
              },
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: BlocBuilder<BreedingBloc, BreedingState>(
          buildWhen: (_, state) => state is HandleBreedingDetailState,
          builder: (_, state) {
            if (state is HandleBreedingDetailState) {
              breedingData = state.response;
              final data = state.response;
              if (data.dateDt != null) {
                inseminatedDateController.text =
                    sl<CommonFunctions>().convertDateToDDMMMYYYY(data.dateDt!);
              } else {
                inseminatedDateController.text = ' ';
              }
              String repeatNo = '0';
              if (data.repeats != null) {
                repeatNo = data.repeats!;
              }
              repeatDateController.text = sl<CommonFunctions>()
                  .convertDateToDDMMMYYYY(data.expectedRepeatDate!);
              aiCostController.text = data.cost!;
              confirmationDateController.text = sl<CommonFunctions>()
                  .convertDateToDDMMMYYYY(data.pregnancyDate!);
              if (data.pgStatus == null) {
                selectedPregnancyStatus = "";
              } else {
                selectedPregnancyStatus = data.pgStatus == '0' ? 'No' : 'Yes';
              }
              dryingDateController.text = sl<CommonFunctions>()
                  .convertDateToDDMMMYYYY(data.dryingDate!);
              steamingDateController.text = sl<CommonFunctions>()
                  .convertDateToDDMMMYYYY(data.strimingupDate!);
              calvingDateController.text = sl<CommonFunctions>()
                  .convertDateToDDMMMYYYY(data.expectedDateOfBirth!);
              bullNameController.text = data.bullName!;
              bullCodeController.text = data.bullCode!;
              if (data.sexType != null) {
                selectedSemenSource =
                    data.sexType!.toUpperCase().replaceAll("-", " ");
              }
              if (data.semenType != null) {
                selectedSemenType = data.semenType! == 'Local Semen'
                    ? 'Local Semen'
                    : 'Imported Semen';
              }

              if (data.noStraw != null) {
                noStrawController.text = data.noStraw!;
              }

              return Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            ImageResources.cowAvatar,
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            state.response.cowName!,
                            style: textStyle,
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      BreedingTitleAndInputWidget(
                          controller: inseminatedDateController,
                          inputText: '',
                          title: 'Date Inseminated'),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'NO OF REPEAT AIS DONE',
                        style: textStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        repeatNo,
                        style: textStyle,
                      ),
                      BreedingTitleAndInputWidget(
                          controller: repeatDateController,
                          inputText: '',
                          title: 'Repeat Date'),
                      BreedingTitleAndInputWidget(
                          controller: aiCostController,
                          inputText: '1500',
                          title: 'AI COST'),
                      BreedingTitleAndInputWidget(
                          controller: confirmationDateController,
                          inputText: 'Apr 20,2022',
                          title: 'CONFIRMATION DATE'),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'PREGNANCY STATUS',
                        style: textStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PregnancyStatusRadioWidget(
                          selectedValue: selectedPregnancyStatus,
                          onValueSelect: (String value) {
                            selectedPregnancyStatus = value;
                            updatePregnancyStatus();
                          }),
                      BreedingTitleAndInputWidget(
                          controller: dryingDateController,
                          inputText: 'Apr 20,2022',
                          title: 'DRYING DATE'),
                      BreedingTitleAndInputWidget(
                          controller: steamingDateController,
                          inputText: 'Apr 20,2022',
                          title: 'STEAMING DATE'),
                      BreedingTitleAndInputWidget(
                          controller: calvingDateController,
                          inputText: 'Apr 20,2022',
                          title: 'CALVING DATE'),
                      BreedingTitleAndInputWidget(
                          controller: bullNameController,
                          inputText: 'Bull Name',
                          title: 'BULL NAME'),
                      BreedingTitleAndInputWidget(
                          controller: bullCodeController,
                          inputText: 'Bull code',
                          title: 'BULL CODE'),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'SEMEN SOURCE',
                        style: textStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SemenSourceRadioWidget(
                          selectedValue: selectedSemenSource,
                          onValueSelect: (String value) {
                            selectedSemenSource = value;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'SEMEN TYPE',
                        style: textStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SemenRadioWidget(
                          selectedValue: selectedSemenType,
                          onValueSelect: (String value) {
                            selectedSemenType = value;
                          }),
                      BreedingTitleAndInputWidget(
                          controller: noStrawController,
                          inputText: 'No of straw',
                          title: 'NUMBER OF STRAW USED'),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            color: ColorConstants.appColor,
            padding: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Share invoice to the farmer",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      generateAndSharePDF();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: const Icon(
                        Icons.share,
                        color: ColorConstants.colorPrimaryDark,
                        size: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> generateAndSharePDF() async {
    final pdf = pw.Document();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(now);

    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(left: 15, right: 15),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.circular(15),
                      color: PdfColors.white),
                  // child: pw.ImageImage
                  child: pw.Image(pw.MemoryImage(imageData),height: 80,width: 80),
                ),
                pw.Column(
                  children: [
                    pw.Text(
                      "Invoice: #${breedingData?.id.toString()}",
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      "Vet: ${breedingData?.vetName}",
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      "Phone Number: ${breedingData?.mobile}",
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
            pw.SizedBox(
              height: 30,
            ),
            pw.Text(
              "Date: $formattedDate",
              // "Date: ${sl<CommonFunctions>().convertDateToDDMMMYYYY(breedingData!.dateDt!)}",
              style: const pw.TextStyle(fontSize: 14),
            ),
            pw.SizedBox(
              height: 20,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.SizedBox(
                  width: 40,
                  child: pw.Text("Item",
                      style: const pw.TextStyle(fontSize: 14),
                      textAlign: pw.TextAlign.center),
                ),
                pw.Expanded(
                  child: pw.Text("Description",
                      style: const pw.TextStyle(fontSize: 14),
                      textAlign: pw.TextAlign.center),
                ),
                pw.SizedBox(
                  width: 80,
                  child: pw.Text("Amount",
                      style: const pw.TextStyle(fontSize: 14),
                      textAlign: pw.TextAlign.center),
                ),
              ],
            ),
            pw.Divider(),
            for (var i = 0; i < 1; i++)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.SizedBox(
                      width: 40,
                      child: pw.Text("${(i + 1).toString()}.",
                          style: const pw.TextStyle(),
                          textAlign: pw.TextAlign.center)),
                  pw.SizedBox(
                    width: 10,
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      "Artificial Insemination for Cow ${breedingData!.cowName}",
                      style: const pw.TextStyle(),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.SizedBox(
                    width: 10,
                  ),
                  pw.SizedBox(
                      width: 80,
                      child: pw.Text(
                        "${breedingData?.cost}",
                        style: const pw.TextStyle(),
                        textAlign: pw.TextAlign.center,
                      )),
                ],
              ),
            pw.SizedBox(
              height: 10,
            ),
            pw.Divider(),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                    child: pw.Text("Total", style: const pw.TextStyle())),
                pw.Expanded(
                  child: pw.Text(
                    "Kshs. ${breedingData!.cost}",
                    style: const pw.TextStyle(),
                    textAlign: pw.TextAlign.end,
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 50,
            ),
            pw.Center(
              child: pw.Text(
                "Note: You can access your records via DigiCow App",
                style: const pw.TextStyle(),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.SizedBox(
              height: 40,
            ),
            pw.Center(
              child: pw.Text("Thank you for trusting us",
                  style: const pw.TextStyle()),
            ),
          ],
        ),
      );
    }));

    // final file = File('example.pdf');
    // await file.writeAsBytes(await pdf.save());

    // Get the app's documents directory
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();

    // Save the PDF to a file in the documents directory
    final pdfFile = File("${appDocumentsDirectory.path}/invoice.pdf");
    await pdfFile.writeAsBytes(await pdf.save());

    // Share the PDF file using the share package
    Share.shareXFiles([XFile(pdfFile.path)], text: 'Sharing PDF');
  }

  void showEditBottomSheet() async {
    EditOrDeleteType? respondType = await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (_) {
          return const EditOrDeleteWidget();
        });

    if (!mounted) return;
    if (respondType != null && breedingData != null) {
      bool canEdit = false;
      if (breedingData!.updatedAt != null) {
        canEdit = sl<CommonFunctions>()
            .dateIsLessThan24Hours(breedingData!.updatedAt!);
      }

      var userID =
          sl<SessionManager>().getUserDetails()!.data!.vetId!.toString();

      if (breedingData!.vetId ==
          sl<SessionManager>().getUserDetails()!.data!.vetId!.toString()) {
        if (canEdit) {
          if (respondType == EditOrDeleteType.edit) {
            editRecord();
          } else {
            deleteRecord();
          }
        } else {
          showMessage(respondType == EditOrDeleteType.edit
              ? 'You cannot edit the record after 24 hours'
              : "You cannot delete record after 24 hours");
        }
      } else {
        showMessage(respondType == EditOrDeleteType.edit
            ? 'You cannot edit the record because recorded by other vet.'
            : "You cannot delete record because recorded by other vet.");
      }
    }
  }

  void editRecord() async {
    await Navigator.of(context).pushNamed(editBreedingRecordDetail,
        arguments: {'breedingID': widget.breedingID});
    if (!mounted) return;
    Navigator.of(context).pop();
    //context.read<BreedingBloc>().add(FetchBreedingDetailEvent(breedingID: widget.breedingID));
  }

  void deleteRecord() async {
    final result = await sl<CommonFunctions>().showConfirmationDialog(
      context: context,
      title: 'Remove!',
      message: 'Are you sure you want to Remove this Breeding Record?',
      buttonPositiveText: 'Yes',
      buttonNegativeText: 'No',
    );

    if (!result || !mounted) {
      return;
    }
    context
        .read<BreedingBloc>()
        .add(RemoveBreedingEvent(breedingID: widget.breedingID));
  }

  void updatePregnancyStatus() {
    final data = breedingData!;
    final addBreedingRecordReq = AddBreedingRecordReqModel(
      breedingID: '${data.id}',
      cowName: data.cowName!,
      cowId: data.cowId!,
      mainDate: breedingData!.dateDt!,
      bullName: bullNameController.text,
      bullCode: bullCodeController.text,
      farmerName: data.farmerName!,
      semenType: selectedSemenType,
      sexType: selectedSemenSource,
      cost: aiCostController.text,
      noStraw: noStrawController.text,
      dryingDate: breedingData!.dryingDate!,
      expectedDOB: breedingData!.expectedDateOfBirth!,
      expectedRepeatDate: breedingData!.expectedRepeatDate!,
      mobileNo: data.mobile!,
      pregnancyDate: breedingData!.pregnancyDate!,
      recordType: 'ndume',
      pgStatus: selectedPregnancyStatus == 'No' ? '0' : '1',
      repeats: '${(int.parse(data.repeats!) + 1)}',
      strawBreed: data.strawBreed!,
      breed1: data.breed1,
      breed2: data.breed2,
      strimingDate: breedingData!.strimingupDate!,
      syncDate: breedingData!.dateDt!,
      vetID: '${sl<SessionManager>().getUserDetails()!.data!.vetId!}',
      vetName:
          '${sl<SessionManager>().getUserDetails()!.data!.vetFname!} ${sl<SessionManager>().getUserDetails()!.data!.vetSname!}',
      isVerified: '1',
      firstHeat: breedingData!.firstHeat!,
      secondHeat: breedingData!.secondHeat!,
      isRepeat: '0',
      sourceOfSemen: "",
    );

    if (!mounted) return;
    context.read<BreedingBloc>().add(AddBreedingEvent(
        addBreedingRecordReq: addBreedingRecordReq, isUpdate: true));
  }
}

class EditOrDeleteWidget extends StatelessWidget {
  const EditOrDeleteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        ListTile(
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.only(left: 18, bottom: 0),
          leading: const Icon(
            Icons.edit,
            size: 30,
            color: ColorConstants.appColor,
          ),
          title: const Text(
            'Edit',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.of(context).pop(EditOrDeleteType.edit);
          },
        ),
        const Divider(),
        ListTile(
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.only(left: 18, bottom: 10),
          leading: const Icon(
            Icons.delete,
            size: 30,
            color: ColorConstants.appColor,
          ),
          title: const Text(
            'Delete',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.of(context).pop(EditOrDeleteType.delete);
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
