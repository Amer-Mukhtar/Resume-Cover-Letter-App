import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdfx/pdfx.dart' as pdfx;
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import '../../Models/model_resume.dart';
import '../add_resume_screen/resume_3.dart';
import '../../ViewModels/resume_view_model.dart';

Future<void> createPdf_template_11(
    ResumeModel newResumeModel, String action, BuildContext context) async {
  Uint8List? dot0;
  Uint8List? profile0;
  Uint8List? email0;
  Uint8List? www0;
  Uint8List? location0;
  Uint8List? phone0;
  Uint8List? dotBlack;

  pw.TextStyle sText =
      const pw.TextStyle(color: PdfColor.fromInt(0xFF12A59A), fontSize: 10);
  pw.TextStyle swText =
      const pw.TextStyle(color: PdfColors.black, fontSize: 10);
  pw.TextStyle sbText = pw.TextStyle(
      color: PdfColors.white, fontSize: 10, fontWeight: pw.FontWeight.bold);
  pw.TextStyle bText = pw.TextStyle(
      color: PdfColors.grey900, fontWeight: pw.FontWeight.bold, fontSize: 10);
  pw.TextStyle b2Text =
      const pw.TextStyle(color: PdfColors.grey800, fontSize: 12);

  pw.TextStyle lText = pw.TextStyle(
      color: PdfColors.white, fontSize: 20, fontWeight: pw.FontWeight.bold);

  pw.TextStyle rsText =
      const pw.TextStyle(color: PdfColor.fromInt(0xFF163852), fontSize: 10);
  pw.TextStyle rsbText = pw.TextStyle(
      color: const PdfColor.fromInt(0xFF163852),
      fontSize: 10,
      fontWeight: pw.FontWeight.bold);

  pw.TextStyle rlText = pw.TextStyle(
      color: const PdfColor.fromInt(0xFF12A59A),
      fontSize: 20,
      fontWeight: pw.FontWeight.bold);

  final ByteData dot = await rootBundle.load('assets/icons/dot.png');
  dot0 = dot.buffer.asUint8List();

  final ByteData Bdot = await rootBundle.load('assets/icons/dot_black.png');
  dotBlack = Bdot.buffer.asUint8List();

  final ByteData profile = await rootBundle.load('assets/icons/profile.png');
  profile0 = profile.buffer.asUint8List();

  final ByteData www = await rootBundle.load('assets/icons/www.png');
  www0 = www.buffer.asUint8List();

  final ByteData phone = await rootBundle.load('assets/icons/phone.png');
  phone0 = phone.buffer.asUint8List();

  final ByteData location = await rootBundle.load('assets/icons/location.png');
  location0 = location.buffer.asUint8List();

  final ByteData email = await rootBundle.load('assets/icons/email.png');
  email0 = email.buffer.asUint8List();

  final pdf = pw.Document();

  final DotImage = pw.MemoryImage(dot0);
  final ProfileImage = pw.MemoryImage(profile0);

  final emailImage = pw.MemoryImage(email0);
  final phoneImage = pw.MemoryImage(phone0);
  final wwwImage = pw.MemoryImage(www0);
  final locationImage = pw.MemoryImage(location0);
  final Bdot2 = pw.MemoryImage(dotBlack);

  const pageTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    orientation: pw.PageOrientation.portrait,
    margin: pw.EdgeInsets.only(right: 10),
  );

  pdf.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Partitions(children: [
            pw.Partition(
                child: pw.Container(
                    constraints: const pw.BoxConstraints(maxWidth: 10),
                    padding:
                        const pw.EdgeInsets.only(left: 20, top: 20, bottom: 20),
                    margin: const pw.EdgeInsets.only(right: 20),
                    height: 841,
                    color: const PdfColor.fromInt(0xFF163852),
                    child: pw.ConstrainedBox(
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.Row(children: [
                                pw.SizedBox(
                                  width: 40,
                                ),
                                pw.Center(
                                  child: newResumeModel.profile_image != null
                                      ? pw.Container(
                                          padding: const pw.EdgeInsets.all(5),
                                          decoration: pw.BoxDecoration(
                                            color: PdfColors.white,
                                            borderRadius:
                                                pw.BorderRadius.circular(65),
                                          ),
                                          width: 130,
                                          height: 130,
                                          child: pw.ClipOval(
                                            child: pw.Container(
                                              width: 110,
                                              height: 110,
                                              child: pw.Center(
                                                child: pw.Image(
                                                  pw.MemoryImage(
                                                    newResumeModel
                                                        .profile_image!,
                                                  ),
                                                  fit: pw.BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : pw.Container(
                                          padding: const pw.EdgeInsets.all(5),
                                          decoration: pw.BoxDecoration(
                                            color: PdfColors.white,
                                            borderRadius:
                                                pw.BorderRadius.circular(65),
                                          ),
                                          width: 130,
                                          height: 130,
                                          child: pw.ClipOval(
                                            child: pw.Container(
                                              width: 110,
                                              height: 110,
                                            ),
                                          ),
                                        ), // Hides the container if no image is provided
                                )
                              ])
                            ]),
                            pw.SizedBox(height: 20),

                            pw.Container(
                              margin: const pw.EdgeInsets.only(left: -30, top: 0),
                              child: pw.Column(
                                children: [
                                  pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                        constraints: const pw.BoxConstraints(maxWidth: 100),
                                        child: pw.Text(
                                          newResumeModel.intro!.firstName,
                                          style: const pw.TextStyle(
                                            fontSize: 36,
                                            letterSpacing: 2,
                                            color: PdfColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                        constraints: const pw.BoxConstraints(maxWidth: 100),
                                        child: pw.Text(
                                          newResumeModel.intro!.lastName,
                                          style: pw.TextStyle(
                                            fontSize: 36,
                                            letterSpacing: 2,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(height: 4),
                                  pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Container(
                                        constraints: const pw.BoxConstraints(maxWidth: 250),
                                        child: pw.Text(
                                          newResumeModel.job.toUpperCase(),
                                          style: const pw.TextStyle(
                                            letterSpacing: 2,
                                            fontSize: 12,
                                            color: PdfColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            pw.SizedBox(height: 10),
                            // Education
                            if (newResumeModel.education.isNotEmpty)
                              pw.Text('Education', style: lText),

                            pw.ListView.builder(
                              itemCount: newResumeModel.education.length,
                              itemBuilder: (context, index) {
                                final item = newResumeModel.education[index];
                                return pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Row(children: [
                                      pw.Text('${item.from} ', style: sbText),
                                      pw.Text(' - ${item.to}', style: sbText),
                                    ]),
                                    pw.SizedBox(height: 2),
                                    pw.Container(
                                      constraints: const pw.BoxConstraints(
                                          maxWidth: 200),
                                      child: pw.Text(item.schoolTitle,
                                          style: sbText),
                                    ),
                                    pw.SizedBox(height: 5),
                                    pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      children: [
                                        pw.Column(children: [
                                          pw.SizedBox(height: 4),
                                          pw.Container(
                                            width: 8,
                                            height: 6,
                                            child: pw.Image(DotImage),
                                          ),
                                        ]),
                                        pw.SizedBox(width: 5),
                                        pw.Column(children: [
                                          pw.Container(
                                            constraints:
                                                const pw.BoxConstraints(
                                                    maxWidth: 200),
                                            child: pw.Text(item.major,
                                                style: sText),
                                          )
                                        ])
                                      ],
                                    ),

                                    pw.SizedBox(height: 10),
                                    // Add spacing between items
                                  ],
                                );
                              },
                            ),

                            pw.SizedBox(height: 10),

                            // Skills Heading
                            if (newResumeModel.skills.isNotEmpty)
                              pw.Text('Hard Skills', style: lText),

                            pw.ListView.builder(
                              itemCount: newResumeModel.skills.length,
                              itemBuilder: (context, index) {
                                return pw.Column(children: [
                                  pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Column(children: [
                                        pw.SizedBox(height: 4),
                                        pw.Container(
                                          width: 8,
                                          height: 6,
                                          child: pw.Image(DotImage),
                                        ),
                                      ]),
                                      pw.SizedBox(width: 5),
                                      pw.Column(children: [
                                        pw.Container(
                                          constraints: const pw.BoxConstraints(
                                              maxWidth: 200),
                                          child: pw.Text(
                                            newResumeModel
                                                .skills[index].skillName,
                                            style: sText,
                                          ),
                                        )
                                      ])
                                    ],
                                  ),
                                  pw.SizedBox(
                                    height: 3,
                                  )
                                ]);
                              },
                            ),

                          ],
                        ),
                        constraints: const pw.BoxConstraints(maxWidth: 10)))),

            ////right colum
            pw.Partition(
              child: pw.Container(
                width: 400,
                color: PdfColors.white,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(children: [
                      pw.Center(
                        child: pw.Container(
                            margin: const pw.EdgeInsets.only(left: -70, top: 110),
                            width: 220,
                            child: pw.Text('CONTACT me', style: rlText)),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Container(
                        margin: const pw.EdgeInsets.only(left: 0),
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(children: [
                              pw.Container(
                                width: 20,
                                height: 20,
                                padding: const pw.EdgeInsets.all(5),
                                decoration: pw.BoxDecoration(
                                    color: const PdfColor.fromInt(0xFF12A59A),
                                    borderRadius: pw.BorderRadius.circular(10)),
                                child: pw.Container(
                                  width: 7,
                                  height: 6,
                                  child: pw.Image(phoneImage),
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text("Phone Number", style: sText),
                              pw.SizedBox(width: 5),
                              pw.Text(newResumeModel.contact!.phoneNumber,
                                  style: swText),
                            ]),
                            pw.SizedBox(height: 4),
                            pw.Row(children: [
                              pw.Container(
                                width: 20,
                                height: 20,
                                padding: const pw.EdgeInsets.all(5),
                                decoration: pw.BoxDecoration(
                                    color: const PdfColor.fromInt(0xFF12A59A),
                                    borderRadius: pw.BorderRadius.circular(10)),
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.only(bottom: 1.5),
                                  width: 6,
                                  height: 5,
                                  child: pw.Image(emailImage),
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text("Email", style: sText),
                              pw.SizedBox(width: 5),
                              pw.Container(
                                constraints:
                                    const pw.BoxConstraints(maxWidth: 200),
                                child: pw.Text(newResumeModel.contact!.email,
                                    style: swText),
                              ),
                            ]),
                            pw.SizedBox(height: 4),
                            pw.Row(children: [
                              pw.Container(
                                width: 20,
                                height: 20,
                                padding: const pw.EdgeInsets.all(5),
                                decoration: pw.BoxDecoration(
                                    color: const PdfColor.fromInt(0xFF12A59A),
                                    borderRadius: pw.BorderRadius.circular(10)),
                                child: pw.Container(
                                  width: 7,
                                  height: 6,
                                  child: pw.Image(locationImage),
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text("Address", style: sText),
                              pw.SizedBox(width: 5),
                              pw.Container(
                                constraints:
                                    const pw.BoxConstraints(maxWidth: 200),
                                child: pw.Text(newResumeModel.contact!.address,
                                    style: swText),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ]),

                    pw.SizedBox(height: 20),
                    pw.Row(children: [pw.Text('INTRODUCTION', style: rlText)]),

                    pw.Container(
                        margin: const pw.EdgeInsets.symmetric(
                            vertical: 10, horizontal: 1),
                        constraints: const pw.BoxConstraints(maxWidth: 280),
                        child: pw.Text(
                          newResumeModel.intro!.summary,
                          style: b2Text,
                        )),

                    //////// Work Experience/////////////////////////////////////
                    if (newResumeModel.experience.isNotEmpty)
                      pw.Row(children: [
                        pw.Text('Work Experience', style: rlText)
                      ]),

                    pw.SizedBox(height: 10),

                    pw.Container(
                        margin: const pw.EdgeInsets.only(right: 20,left: 5),
                        padding: const pw.EdgeInsets.only(top: 5),
                        constraints: const pw.BoxConstraints(maxWidth: 215),
                        child: pw.ListView.builder(
                          itemCount: newResumeModel.experience.length,
                          itemBuilder: (context, index) {
                            final item = newResumeModel.experience[index];

                            return pw.Container(
                              child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(

                                    child: pw.Text(item.to,
                                      style: sText,),
                                  ),
                                  pw.Column(children: [

                                    pw.Container(
                                      margin:
                                          const pw.EdgeInsets.only(left: 30),
                                      padding:
                                          const pw.EdgeInsets.only(top: 0),
                                      child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Container(
                                            constraints:
                                                const pw.BoxConstraints(
                                                    maxWidth: 180),
                                            child: pw.Text(item.company,
                                                style: sText),
                                          ),
                                          pw.Row(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            children: [
                                              pw.Container(
                                                constraints:
                                                    const pw.BoxConstraints(
                                                        maxWidth: 280),
                                                child: pw.Text(item.position,
                                                    style: b2Text,
                                                    textAlign:
                                                        pw.TextAlign.left),
                                              ),
                                            ],
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.Container(
                                              constraints:
                                                  const pw.BoxConstraints(
                                                      maxWidth: 260),
                                              child: pw.Text(item.description)),
                                          pw.SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                            );
                          },
                        )),

                    pw.SizedBox(height: 20),

                    // Acievement
                    if (newResumeModel.achievements.isNotEmpty)
                      pw.Row(children: [
                        pw.Container(
                          width: 290,
                          padding: const pw.EdgeInsets.symmetric(
                              horizontal: 0, vertical: 2),
                          child: pw.Text(
                            'ACHIEVEMENT',
                            style: rlText,
                          ),
                        )
                      ]),
                    pw.SizedBox(height: 8),
                    pw.ListView.builder(
                      itemCount: newResumeModel.achievements.length,
                      itemBuilder: (context, index) {
                        final item = newResumeModel.achievements[index];
                        return pw.Container(
                            margin: const pw.EdgeInsets.only(left: 1),
                            width: 290,
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Container(
                                  width: 275,
                                  constraints:
                                      const pw.BoxConstraints(maxWidth: 300),
                                  child: pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Container(
                                          constraints: const pw.BoxConstraints(
                                              maxWidth: 200),
                                          child:
                                              pw.Text(item.name, style: sText),
                                        ),
                                      ]),
                                ),
                                pw.SizedBox(height: 2),

                                pw.Row(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: [
                                    pw.Column(children: [
                                      pw.Container(
                                        constraints: const pw.BoxConstraints(
                                            maxWidth: 200),
                                        child: pw.Text(item.Descirption,
                                            style: const pw.TextStyle(
                                                color: PdfColors.grey800,
                                                fontSize: 10)),
                                      )
                                    ])
                                  ],
                                ),

                                pw.SizedBox(height: 10),
                                // Add spacing between items
                              ],
                            ));
                      },
                    ),
                  ],
                ),
              ),
            )
          ])
        ];
      },
    ),
  );

  final pdfData = await pdf.save();

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/Resume.pdf");
  newResumeModel.resume = file;
  //await OpenFile.open("${output.path}/Resume.pdf");
  if (action == 'save') {
  } else if (action == 'preview') {
    await file.writeAsBytes(pdfData);
    final pdfDoc = await pdfx.PdfDocument.openFile(file.path);
    final page = await pdfDoc.getPage(1);

    final pdfPageImage = await page.render(
      width: page.width,
      height: page.height,
      format: pdfx.PdfPageImageFormat.png,
    );

    final img.Image? image = img.decodeImage(pdfPageImage!.bytes);
    if (image != null) {
      final Uint8List uint8list = Uint8List.fromList(img.encodePng(image));
      final resumeViewModel =
          Provider.of<ResumeViewModelProvider>(context, listen: false);
      resumeViewModel.setResumeSnapshot(uint8list, newResumeModel);

      await page.close();
      await pdfDoc.close();
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Template_Preview(
            resumeModel: newResumeModel,
          ),
        ),
      );
    } else {
      print('Failed to decode image.');
    }
  } else {
    throw ArgumentError('Invalid action: $action');
  }
}
