import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ndumeappflutter/resources/color_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../resources/image_resources.dart';

class InvoiceActivity extends StatefulWidget {
  const InvoiceActivity({Key? key}) : super(key: key);

  @override
  State<InvoiceActivity> createState() => _InvoiceActivityState();
}

class _InvoiceActivityState extends State<InvoiceActivity> {
  late Uint8List imageData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }

  Future<void> getImage() async {
    final ByteData image = await rootBundle.load(ImageResources.cowIcon);

    imageData = (image).buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Image.asset(
                      ImageResources.cowIcon,
                      height: 30,
                    ),
                  ),
                  const Column(
                    children: [
                      Text(
                        "Invoice: #023",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        "Vet Francis Mejja",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        "Phone Number: 0746235476",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Date: 26/12/2023",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                    child: Text("Item",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("Description",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text("Amount",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
              const Divider(),
              for (var i = 0; i < 4; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 40,
                        child: Text("${(i + 1).toString()}.",
                            style: const TextStyle(),
                            textAlign: TextAlign.center)),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Text(
                        "Artificial Insemination for Cow Kendii",
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                        width: 80,
                        child: Text(
                          "2000",
                          style: TextStyle(),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text("Total", style: TextStyle())),
                  Expanded(
                    child: Text(
                      "Kshs. 2000",
                      style: TextStyle(),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Note: You can access your records via DigiCow App",
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text("Thank you for trusting us", style: TextStyle()),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: InkWell(
            onTap: () {
              generateAndSharePDF();
            },
            child: const Icon(
              Icons.share,
              size: 30,
              color: ColorConstants.appColor,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> generateAndSharePDF() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(left: 15, right: 15),
        child: pw.Column(
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
                      borderRadius: pw.BorderRadius.circular(15)),
                  // child: pw.ImageImage
                  child: pw.Image(pw.MemoryImage(imageData)),
                ),
                pw.Column(
                  children: [
                    pw.Text(
                      "Invoice: #023",
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      "Vet Francis Mejja",
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      "Phone Number: 0746235476",
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
              "Date: 26/12/2023",
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
            for (var i = 0; i < 4; i++)
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
                      "Artificial Insemination for Cow Kendii",
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
                        "2000",
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
                    "Kshs. 2000",
                    style: const pw.TextStyle(),
                    textAlign: pw.TextAlign.end,
                  ),
                ),
              ],
            ),
            pw.SizedBox(
              height: 50,
            ),
            pw.Text(
              "Note: You can access your records via DigiCow App",
              style: const pw.TextStyle(),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(
              height: 40,
            ),
            pw.Text("Thank you for trusting us", style: const pw.TextStyle()),
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
}
