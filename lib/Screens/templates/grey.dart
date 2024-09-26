import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:pdfx/pdfx.dart' as pdfx;
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import '../../Models/model_resume.dart';
import '../add_resume_screen/resume_3.dart';
import '../add_resume_screen/resume_view_model.dart';

Future<void> createPdf_grey(
    ResumeModel newResumeModel, String action, BuildContext context) async {
  Uint8List? dot0;
  Uint8List? profile0;
  Uint8List? email0;
  Uint8List? www0;
  Uint8List? location0;
  Uint8List? phone0;
  Uint8List? dotBlack;

  pw.TextStyle sText = const pw.TextStyle(color: PdfColors.black, fontSize: 10);
  pw.TextStyle sbText = pw.TextStyle(
      color: PdfColors.black, fontSize: 10, fontWeight: pw.FontWeight.bold);
  pw.TextStyle bText = pw.TextStyle(
      color: PdfColors.grey900, fontWeight: pw.FontWeight.bold, fontSize: 10);
  pw.TextStyle b2Text =
      const pw.TextStyle(color: PdfColors.grey800, fontSize: 12);

  pw.TextStyle lText = pw.TextStyle(
      color: PdfColors.grey900, fontSize: 16, fontWeight: pw.FontWeight.bold,letterSpacing: 2.0);

  pw.TextStyle rsText =
      const pw.TextStyle(color: PdfColor.fromInt(0xFF163852), fontSize: 10);
  pw.TextStyle rsbText = pw.TextStyle(
      color: const PdfColor.fromInt(0xFF163852),
      fontSize: 10,
      fontWeight: pw.FontWeight.bold);

  pw.TextStyle rlText = pw.TextStyle(
      color: PdfColors.black,
      fontSize: 20,
      fontWeight: pw.FontWeight.bold);

  final ByteData dot = await rootBundle.load('assets/images/dot.png');
  dot0 = dot.buffer.asUint8List();

  final ByteData Bdot = await rootBundle.load('assets/images/dot_black.png');
  dotBlack = Bdot.buffer.asUint8List();

  final ByteData profile = await rootBundle.load('assets/images/profile.png');
  profile0 = profile.buffer.asUint8List();

  final ByteData www = await rootBundle.load('assets/images/www.png');
  www0 = www.buffer.asUint8List();

  final ByteData phone = await rootBundle.load('assets/images/phone.png');
  phone0 = phone.buffer.asUint8List();

  final ByteData location = await rootBundle.load('assets/images/location.png');
  location0 = location.buffer.asUint8List();

  final ByteData email = await rootBundle.load('assets/images/email.png');
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
  pw.Widget buildReferencesList(pw.Context context, List<Reference> references) {
    return pw.ListView.builder(
      itemCount: references.length,
      itemBuilder: (context, index) {
        final reference = references[index];
        return pw.Container(
          padding: pw.EdgeInsets.all(8),
          constraints: const pw.BoxConstraints(maxWidth: 180),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(reference.name, style:  pw.TextStyle(fontSize: 10,font: pw.Font.helveticaBold(), )),
              pw.SizedBox(height: 5),
              pw.Container(
                constraints: const pw.BoxConstraints(maxWidth: 130),
                child: pw.Text('${reference.company}}',
                    style: const pw.TextStyle(
                        fontSize: 8, color: PdfColors.grey900)),
              ),
              pw.SizedBox(height: 5),
              pw.Text('Phone: ${reference.phone}',
                  style: const pw.TextStyle(
                      fontSize: 8, color: PdfColors.grey900)),
              pw.SizedBox(height: 5),
              pw.Text('Email: ${reference.email}',
                  style: const pw.TextStyle(
                      fontSize: 8, color: PdfColors.grey900)),
            ],
          ),
        );
      },
    );
  }


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
                    color: PdfColors.grey,
                    child: pw.ConstrainedBox(
                        child: pw.Column(

                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            ///Contact/////////////
                           pw.Container(
                               margin: pw.EdgeInsets.only(left: -20,top: -20),
                             padding: pw.EdgeInsets.only(left: 20,top: 28,bottom: 28),
                             color: PdfColors.white,
                             child: pw.Row(children: [
                              pw.Container(padding: pw.EdgeInsets.all(10),color: PdfColors.grey,child:  pw.Column(children: [
                                pw.Container(
                                  width: 14,
                                  height: 12,
                                  child: pw.Image(
                                    phoneImage,
                                  ),
                                ),
                                pw.SizedBox(height: 8,),
                                pw.Container(
                                  width: 12,
                                  height: 10,
                                  child: pw.Image(
                                    emailImage,
                                  ),
                                ),
                                pw.SizedBox(height: 8,),
                                pw.Container(
                                  width: 14,
                                  height: 12,
                                  child: pw.Image(
                                    locationImage,
                                  ),
                                ),
                              ])),
                              pw.SizedBox(width: 5),

                               pw.Container(child: pw.Column(
                                   crossAxisAlignment: pw.CrossAxisAlignment.start,children: [
                                 pw.Text(newResumeModel.contact!.phoneNumber,
                                     style: sText),
                                 pw.SizedBox(height: 8),
                                 pw.Container(
                                   constraints:
                                   const pw.BoxConstraints(maxWidth: 200),
                                   child: pw.Text(newResumeModel.contact!.email,
                                       style: sText),
                                 ),
                                 pw.SizedBox(height: 8),
                                 pw.Container(
                                   constraints:
                                   const pw.BoxConstraints(maxWidth: 200),
                                   child: pw.Text(newResumeModel.contact!.address,
                                       style: sText),
                                 )
                               ]))
                             ])
                           ),



                            // Education
                            pw.SizedBox(height: 10),
                            if (newResumeModel.education.isNotEmpty)
                              pw.Text('EDUCATION', style: lText),
                            pw.SizedBox(height: 10),
                            pw.ListView.builder(
                              itemCount: newResumeModel.education.length,
                              itemBuilder: (context, index) {
                                final item = newResumeModel.education[index];
                                return pw.Column(
                                  crossAxisAlignment:
                                  pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                      constraints:
                                      const pw.BoxConstraints(
                                          maxWidth: 200),
                                      child: pw.Text(item.major,
                                          style: sText),
                                    ),
                                    pw.SizedBox(height: 5),
                                    pw.Row(children: [
                                      pw.Text(item.schoolTitle+': ${item.from} - ${item.to}', style: const pw.TextStyle(
                                          fontSize: 12, color: PdfColors.grey900)),

                                    ]),
                                    pw.SizedBox(height: 4),
                                    // Add spacing between items
                                  ],
                                );
                              },
                            ),




                            // Skills Heading
                            pw.SizedBox(height: 10),
                            if (newResumeModel.refrences.isNotEmpty)
                              pw.Container(
                                width: 220,
                                height: 2,
                                color: PdfColors.grey600,),
                            if (newResumeModel.skills.isNotEmpty)
                              pw.SizedBox(height: 10),
                              pw.Text('SKILLS', style: lText),
                            pw.SizedBox(height: 10),
                            pw.ListView.builder(
                              itemCount: newResumeModel.skills.length,
                              itemBuilder: (context, index) {
                                return pw.Row(
                                  crossAxisAlignment:
                                  pw.CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  pw.MainAxisAlignment.start,
                                  children: [


                                    pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start,children: [
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Container(
                                        constraints: const pw.BoxConstraints(
                                            maxWidth: 200),
                                        child: pw.Text(
                                          newResumeModel
                                              .skills[index].skillName,
                                          style: sText,
                                        ),
                                      ),
                                      pw.SizedBox(height: 6),
                                      pw.Stack(
                                        children: [
                                          pw.Container(
                                              decoration: pw.BoxDecoration(

                                                  color: PdfColors.black,
                                                  borderRadius: pw.BorderRadius.circular(4)
                                              ),
                                            height: 8,width: 200
                                              ,
                                          ),
                                          pw.Container(
                                            decoration: pw.BoxDecoration(
                                                color: PdfColors.white,
                                              borderRadius: pw.BorderRadius.circular(4)
                                            ),
                                              height: 8,width: newResumeModel.skills[index].level*2
                                          ),

                                        ]
                                      ),


                                    ]
                                    )
                                  ],
                                );
                              },
                            ),




                         



                            // Reference
                            pw.SizedBox(height: 15),
                            if (newResumeModel.refrences.isNotEmpty)
                              pw.Container(
                                width: 220,
                                height: 2,
                                color: PdfColors.grey600,),
                            pw.SizedBox(height: 15),
                            if (newResumeModel.refrences.isNotEmpty)
                              pw.Row(children: [
                                pw.Text('REFRENCES', style: lText)
                              ]),

                            pw.SizedBox(height: 10),
                            pw.ListView.builder(
                              itemCount: newResumeModel.refrences.length,
                              itemBuilder: (context, index) {
                                final reference = newResumeModel.refrences[index];
                                return pw.Container(
                                  padding: pw.EdgeInsets.all(8),
                                  width: 220,
                                  constraints: const pw.BoxConstraints(maxWidth: 180),
                                  child: pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(reference.name, style:  pw.TextStyle(fontSize: 10,font: pw.Font.helveticaBold(), )),
                                      pw.SizedBox(height: 5),
                                      pw.Container(
                                        constraints: const pw.BoxConstraints(maxWidth: 130),
                                        child: pw.Text('${reference.company}}',
                                            style: const pw.TextStyle(
                                                fontSize: 8, color: PdfColors.grey900)),
                                      ),
                                      pw.SizedBox(height: 5),
                                      pw.Text('Phone: ${reference.phone}',
                                          style: const pw.TextStyle(
                                              fontSize: 8, color: PdfColors.grey900)),
                                      pw.SizedBox(height: 5),
                                      pw.Text('Email: ${reference.email}',
                                          style: const pw.TextStyle(
                                              fontSize: 8, color: PdfColors.grey900)),
                                    ],
                                  ),
                                );
                              },
                            ),
                            pw.SizedBox(height: 10),
                            if (newResumeModel.refrences.isNotEmpty)
                              pw.Container(
                                width: 220,
                                height: 2,
                                color: PdfColors.grey600,),
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
                    //heading
                    pw.Container(
                      margin: pw.EdgeInsets.only(top: 40),
                        child: pw.Row(children:
                        [
                          pw.Column(
                            children: [pw.Container(margin: pw.EdgeInsets.only(left: -20,right: 10),color: PdfColors.grey,width: 0.5,height: 60)]
                          ),
                          pw.SizedBox(width: 10),
                          pw.Column(
                            children: [
                              pw.Row(children: [
                                pw.Container(
                                  constraints:
                                  const pw.BoxConstraints(maxWidth: 200),
                                  child: pw.Text(newResumeModel.intro!.firstName+" "+newResumeModel.intro!.lastName,
                                      style: const pw.TextStyle(
                                          fontSize: 26,
                                          color: PdfColors.black)),
                                ),

                              ]),
                              pw.SizedBox(height: 5),
                              pw.Row(children: [
                                pw.Container(
                                  margin: pw.EdgeInsets.only(left: -20),
                                  constraints:
                                  const pw.BoxConstraints(maxWidth: 250),
                                  child: pw.Text(newResumeModel.job.toUpperCase(),
                                      style: const pw.TextStyle(
                                          fontSize: 12, color: PdfColors.grey700)
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ])),
                    pw.SizedBox(height: 20),
                    pw.Container(
                      width: 315,
                      height: 2,
                      color: PdfColors.grey300,),
                    pw.SizedBox(height: 10),
                    pw.Row(children: [pw.Text('PROFILE', style: lText)]),

                    pw.Container(
                        margin: const pw.EdgeInsets.symmetric(
                            vertical: 10, horizontal: 0),
                        constraints: const pw.BoxConstraints(maxWidth: 280),
                        child: pw.Text(
                          newResumeModel.intro!.summary,
                          style: b2Text,
                        )),

                    //////// Work Experience/////////////////////////////////////
                    pw.SizedBox(height: 10),
                    if (newResumeModel.experience.isNotEmpty)
                      pw.Container(
                          width: 315,
                          height: 2,
                          color: PdfColors.grey300,),
                    if (newResumeModel.experience.isNotEmpty)
                      pw.SizedBox(height: 10),
                    if (newResumeModel.experience.isNotEmpty)
                      pw.Row(children: [pw.Text('EXPERIENCE', style: lText)]),

                    pw.SizedBox(height: 10),

                    pw.Container(
                        margin: const pw.EdgeInsets.only(right: 20),
                        padding: const pw.EdgeInsets.only(top: 20),
                        constraints: const pw.BoxConstraints(maxWidth: 215),
                        child: pw.ListView.builder(
                          itemCount: newResumeModel.experience.length,
                          itemBuilder: (context, index) {
                            final item = newResumeModel.experience[index];
                            int baseHeight = 50;

                            List<String> lines = item.description.split('\n');

                            if (lines.isNotEmpty && lines.first.isEmpty) {
                              lines.removeAt(0);
                            }
                            if (lines.isNotEmpty && lines.last.isEmpty) {
                              lines.removeLast();
                            }

                            double descriptionLines = lines.length * 1.5;
                            int descrip = descriptionLines.toInt();

                            double lineHeight = baseHeight + (descrip * 10);
                            print('$lineHeight');

                            return pw.Container(
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [

                                  pw.SizedBox(width: 6),
                                  pw.Container(
                                    margin: const pw.EdgeInsets.only(left: 5),
                                    padding: const pw.EdgeInsets.only(top: -15),
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      children: [
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceEvenly,
                                          children: [
                                            pw.Container(
                                              constraints:
                                                  const pw.BoxConstraints(
                                                      maxWidth: 180),
                                              child: pw.Text(item.company,
                                                  style: bText),
                                            ),
                                            pw.Text(
                                                '   ${item.from} - ${item.to}',
                                                style: b2Text),
                                          ],
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
                                                  textAlign: pw.TextAlign.left),
                                            ),
                                          ],
                                        ),
                                        pw.SizedBox(height: 10),
                                        pw.Container(
                                          constraints: const pw.BoxConstraints(
                                              maxWidth: 260),
                                          child: pw.Flexible(
                                              child: pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: item.description
                                                .split('\n')
                                                .where(
                                                    (line) => line.isNotEmpty)
                                                .map((line) {
                                              return pw.Padding(
                                                padding:
                                                    const pw.EdgeInsets.only(
                                                        bottom: 4),
                                                child: pw.Row(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Column(
                                                      children: [
                                                        pw.SizedBox(height: 5),
                                                        pw.Container(
                                                          alignment: pw
                                                              .Alignment
                                                              .topLeft,
                                                          width: 4,
                                                          height: 8,
                                                          child:
                                                              pw.Image(Bdot2),
                                                        ),
                                                      ],
                                                    ),
                                                    pw.SizedBox(width: 5),
                                                    pw.Expanded(
                                                      child: pw.Text(
                                                        line,
                                                        style: b2Text,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          )),
                                        ),
                                        pw.SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
                    pw.SizedBox(height: 10),
                    if (newResumeModel.experience.isNotEmpty)
                      pw.Container(
                        width: 315,
                        height: 2,
                        color: PdfColors.grey300,),
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
  if (action == 'save')
  {
  }
  else if (action == 'preview') {
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
