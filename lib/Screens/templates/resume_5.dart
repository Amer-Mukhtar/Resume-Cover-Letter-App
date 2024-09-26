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

Future<void> createPdf_template_5(
    ResumeModel newResumeModel, String action, BuildContext context) async {
  Uint8List? dot0;
  Uint8List? profile0;
  Uint8List? email0;
  Uint8List? www0;
  Uint8List? location0;
  Uint8List? phone0;
  Uint8List? dotBlack;

  pw.TextStyle sText = const pw.TextStyle(color: PdfColors.white, fontSize: 10);
  pw.TextStyle sbText = pw.TextStyle(
      color: PdfColors.white, fontSize: 10, fontWeight: pw.FontWeight.bold);
  pw.TextStyle bText = pw.TextStyle(
      color: PdfColors.grey900, fontWeight: pw.FontWeight.bold, fontSize: 10);
  pw.TextStyle b2Text =
      const pw.TextStyle(color: PdfColors.grey800, fontSize: 12);

  pw.TextStyle lText = pw.TextStyle(
      color: PdfColors.white, fontSize: 20, fontWeight: pw.FontWeight.bold);

  pw.TextStyle rsText =
      const pw.TextStyle(color: PdfColor.fromInt(0xFF2B354B), fontSize: 10);
  pw.TextStyle rsbText = pw.TextStyle(
      color: const PdfColor.fromInt(0xFF2B354B),
      fontSize: 10,
      fontWeight: pw.FontWeight.bold);

  pw.TextStyle rlText = pw.TextStyle(
    letterSpacing: 3.0,
      color: const PdfColor.fromInt(0xFF2B354B),
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
  pw.Widget buildReferencesGrid(
      pw.Context context, List<Reference> references) {
    const int crossAxisCount = 2;
    List<pw.Widget> rows = [];
    List<pw.Widget> currentRow = [];

    for (int i = 0; i < references.length; i++) {
      final reference = references[i];
      currentRow.add(
        pw.Container(
          constraints: const pw.BoxConstraints(maxWidth: 150),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(reference.name, style: const pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 5),
              pw.Row(children: [
                pw.Container(
                  constraints: const pw.BoxConstraints(maxWidth: 130),
                  child: pw.Text('${reference.company} / ${reference.position}',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey700)
                  ),
                )
              ]),
              pw.SizedBox(height: 5),
              pw.Row(children: [
                pw.Text('Phone: ',
                    style: const pw.TextStyle(
                        fontSize: 8, color: PdfColors.black)
                ),
                pw.Text(reference.phone,
                    style: const pw.TextStyle(
                        fontSize: 8, color: PdfColors.grey800)
                ),
              ]),

              pw.SizedBox(height: 5),
              pw.Row(children: [
                pw.Text('Email: ',
                    style: const pw.TextStyle(
                        fontSize: 8, color: PdfColors.black)
                ),
                pw.Text(reference.email,
                    style: const pw.TextStyle(
                        fontSize: 8, color: PdfColors.grey800)
                ),
              ])

            ],
          ),
        ),
      );

      if ((i + 1) % crossAxisCount == 0 || i == references.length - 1) {
        rows.add(
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: currentRow,
          ),
        );
        currentRow = [];
      }
    }

    return pw.Column(
      children: rows,
    );
  }

  pdf.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Container(
            width: 800,
            margin: pw.EdgeInsets.only(right: -10),
            decoration: pw.BoxDecoration(
                color: const PdfColor.fromInt(0xFF2B354B),
              borderRadius: pw.BorderRadius.only(
                  topLeft: pw.Radius.circular(10),
                  topRight: pw.Radius.circular(10))
            ),

              padding: pw.EdgeInsets.only(top: 20, bottom: 20,right: 20),
              child: pw.Column(children: [
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [

                      pw.Container(
                        constraints: const pw.BoxConstraints(maxWidth: 315),
                        child: pw.Text(newResumeModel.intro!.firstName.toUpperCase()+" "+newResumeModel.intro!.lastName.toUpperCase(),
                            style: pw.TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 26,
                                color: PdfColors.white,
                                fontWeight: pw.FontWeight.bold)),
                      ),

                    ]),
                pw.Container(
                  constraints: const pw.BoxConstraints(maxWidth: 315),
                  child: pw.Text(newResumeModel.job.toUpperCase(),
                      style: const pw.TextStyle(
                        letterSpacing: 2.0,
                          fontSize: 18, color: PdfColors.white)),
                ),
                pw.SizedBox(height: 10),
              ])),
          pw.Partitions(children:
          [
            pw.Partition(
                child: pw.Container(
                    decoration: pw.BoxDecoration(
                        color: const PdfColor.fromInt(0xFF2B354B),
                        borderRadius: pw.BorderRadius.only(bottomRight: pw.Radius.circular(10))
                    ),
                    constraints: const pw.BoxConstraints(maxWidth: 10),
                    padding: const pw.EdgeInsets.only(left: 20, top: 0, bottom: 20),
                    margin: const pw.EdgeInsets.only(right: 20,top: -20),
                    height: 770,
                    child: pw.ConstrainedBox(
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                           pw.Row(children: [
                             pw.SizedBox(width: 18)
                             ,pw.Center(
                             child: newResumeModel.profile_image != null
                                 ?pw.Container(
                               width: 170,
                               height: 170,
                               child: pw.Center(
                                 child: pw.ClipRRect(
                                   horizontalRadius: 15,
                                   verticalRadius: 15,
                                   child: pw.Image(
                                     pw.MemoryImage(
                                       newResumeModel.profile_image!,
                                     ),
                                     fit: pw.BoxFit.cover,
                                   ),
                                 ),
                               ),
                             )

                                 : pw.Container(
                               padding: const pw.EdgeInsets.all(5),
                               decoration: pw.BoxDecoration(
                                 color: const PdfColor.fromInt(0xFF2B354B),
                                 borderRadius:
                                 pw.BorderRadius.circular(0),
                               ),
                               width: 130,
                               height: 130,
                               child: pw.Container(
                                 width: 110,
                                 height: 110,
                               ),
                             ),
                           ),]),


                            ///Contact/////////////

                           pw.Container(width: 220,margin: pw.EdgeInsets.only(left: -20,right: 0),
                             padding: pw.EdgeInsets.only(left: 0,top: 5,bottom: 5),
                             decoration: pw.BoxDecoration(color: PdfColors.white,
                                 borderRadius: pw.BorderRadius.only(topRight: pw.Radius.circular(20),bottomRight: pw.Radius.circular(20))),
                             child:  pw.Row(children: [
                               pw.SizedBox(width: 50),
                               pw.Text('ABOUT ME', style: rlText)]),
                           ),
                            pw.Container(
                                margin: pw.EdgeInsets.only(bottom: 10,top: 10,left: 30),
                                constraints: const pw.BoxConstraints(maxWidth: 200),
                                child: pw.Text(
                                  newResumeModel.intro!.summary,
                                  style: sText,
                                )),

                           pw.Container(margin: pw.EdgeInsets.only(left: 30),
                             child: pw.Column(children: [

                             pw.Row(children: [
                               pw.Container(
                                 width: 14,
                                 height: 12,
                                 child: pw.Image(
                                   phoneImage,
                                 ),
                               ),
                               pw.SizedBox(width: 5),
                               pw.Text(newResumeModel.contact!.phoneNumber,
                                   style: sText),
                             ]),
                               pw.SizedBox(height:  10),
                             pw.Row(children: [
                               pw.Container(
                                 width: 12,
                                 height: 10,
                                 child: pw.Image(
                                   emailImage,
                                 ),
                               ),
                               pw.SizedBox(width: 5),
                               pw.Container(
                                 constraints:
                                 const pw.BoxConstraints(maxWidth: 200),
                                 child: pw.Text(newResumeModel.contact!.email,
                                     style: sText),
                               )
                             ]),
                               pw.SizedBox(height:  10),
                             pw.Row(children: [
                               pw.Container(
                                 width: 14,
                                 height: 12,
                                 child: pw.Image(
                                   locationImage,
                                 ),
                               ),
                               pw.SizedBox(width: 5),
                               pw.Container(
                                 constraints:
                                 const pw.BoxConstraints(maxWidth: 200),
                                 child: pw.Text(newResumeModel.contact!.address,
                                     style: sText),
                               )
                             ]),
                           ]), ),

                            pw.SizedBox(height: 10),

                            // Languages heading /////////////////////////

                            if (newResumeModel.languages.isNotEmpty)
                              pw.Container(width: 240,margin: pw.EdgeInsets.only(left: -20,right: 0),
                                padding: pw.EdgeInsets.only(left: 0,top: 5,bottom: 5),
                                decoration: pw.BoxDecoration(color: PdfColors.white,
                                    borderRadius: pw.BorderRadius.only(topRight: pw.Radius.circular(20),bottomRight: pw.Radius.circular(20))),
                                child:  pw.Row(children: [pw.SizedBox(width: 50),pw.Text('LANGUAGE', style: rlText)]),
                              ),

                            pw.ListView.builder(
                              itemCount: newResumeModel.languages.length,
                              itemBuilder: (context, index) {
                                return pw.Container(
                                  margin: pw.EdgeInsets.only(left: 30),
                                  width: 200, // The container's width
                                  child: pw.Column(
                                    children: [
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
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
                                              child: pw.Text(
                                                newResumeModel
                                                    .languages[index].language,
                                                style: sText,
                                              ),
                                            ),
                                          ])
                                        ],
                                      ),
                                      pw.SizedBox(height: 3),
                                    ],
                                  ),
                                );
                              },
                            ),
                            pw.SizedBox(height: 10),

                            // Skills Heading
                            if (newResumeModel.skills.isNotEmpty)
                              pw.Container(width: 220,margin: pw.EdgeInsets.only(left: -20,right: 0),
                                padding: pw.EdgeInsets.only(left: 0,top: 5,bottom: 5),
                                decoration: pw.BoxDecoration(color: PdfColors.white,
                                    borderRadius: pw.BorderRadius.only(topRight: pw.Radius.circular(20),bottomRight: pw.Radius.circular(20))),
                                child:  pw.Row(children: [
                                  pw.SizedBox(width: 50),
                                  pw.Text('SKILLS', style: rlText)
                                ]),
                              ),

                            pw.ListView.builder(
                              itemCount: newResumeModel.skills.length,
                              itemBuilder: (context, index) {
                                return pw.Container(margin: pw.EdgeInsets.only(left: 30),child: pw.Column(children: [
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
                                ]));
                              },
                            ),
                          ],
                        ),
                        constraints: const pw.BoxConstraints(maxWidth: 10)))),

            ////right colum
            pw.Partition(
              child: pw.Container(

                height: 755,
                margin: pw.EdgeInsets.only(left: -40,top: -5,right: -10),
                padding: pw.EdgeInsets.only(left: 20,top: 20),
                width: 400,
                decoration: pw.BoxDecoration(
                  borderRadius:
                      pw.BorderRadius.only(topLeft: pw.Radius.circular(30),bottomRight: pw.Radius.circular(10)),
                  color: PdfColors.white,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    //////// Work Experience/////////////////////////////////////
                    if (newResumeModel.experience.isNotEmpty)
                      pw.Row(children: [
                        pw.Text('EXPERIENCE', style: rlText,),
                      ]),
                    pw.SizedBox(height: 8),
                    if (newResumeModel.experience.isNotEmpty)
                      pw.Container(
                          width: 290,
                          height: 2,
                          color: const PdfColor.fromInt(0xFF2B354B)),
                    pw.SizedBox(height: 8),

                    pw.Container(
                        margin: const pw.EdgeInsets.only(right: 20),
                        padding: const pw.EdgeInsets.only(top: 20),
                        constraints: const pw.BoxConstraints(maxWidth: 290),
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

                            return pw.Container(width: 290,child: pw.Column(
                              children: [
                                pw.Container(
                                  margin: const pw.EdgeInsets.only(left: 5),
                                  padding: const pw.EdgeInsets.only(top: -15),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                    pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Container(
                                            constraints:
                                            const pw.BoxConstraints(
                                                maxWidth: 300),
                                            child: pw.Text(item.company,
                                                style: bText),
                                          ),
                                          pw.Text(
                                              '   ${item.from} - ${item.to}',
                                              style: b2Text),
                                        ],
                                      ),
                                      pw.Container(
                                        constraints:
                                        const pw.BoxConstraints(
                                            maxWidth: 280),
                                        child: pw.Text(item.position,
                                            style: pw.TextStyle(color: PdfColors.black, fontSize: 10),
                                            textAlign: pw.TextAlign.left),
                                      ),
                                      pw.SizedBox(height: 2),
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
                            ));
                          },
                        )),

                    pw.SizedBox(height: 8),
                    // Education
                    if (newResumeModel.education.isNotEmpty)
                      pw.Text('EDUCATION', style: rlText),
                    pw.SizedBox(height: 8),
                    if (newResumeModel.education.isNotEmpty)
                      pw.Container(
                          width: 290,
                          height: 2,
                          color: const PdfColor.fromInt(0xFF2B354B)),

                    pw.SizedBox(height: 8),
                    pw.ListView.builder(
                      itemCount: newResumeModel.education.length,
                      itemBuilder: (context, index) {
                        final item = newResumeModel.education[index];
                        return pw.Container(width: 290,child: pw.Column(
                          crossAxisAlignment:
                          pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,children: [
                              pw.Container(
                                constraints: const pw.BoxConstraints(
                                    maxWidth: 200),
                                child: pw.Text(item.schoolTitle,
                                    style: bText),
                              ),
                              pw.Row(children: [pw.Text('${item.from} ', style: b2Text),
                                pw.Text(' - ${item.to}', style: b2Text),])
                            ]),
                            pw.SizedBox(height: 2),


                            pw.Row(
                              crossAxisAlignment:
                              pw.CrossAxisAlignment.start,
                              mainAxisAlignment:
                              pw.MainAxisAlignment.start,
                              children: [

                                pw.Column(children: [
                                  pw.Container(
                                    constraints:
                                    const pw.BoxConstraints(
                                        maxWidth: 200),
                                    child: pw.Text(item.major,
                                        style: pw.TextStyle(color: PdfColors.grey800, fontSize: 10)),
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

                    pw.SizedBox(height: 8),

                    // Reference
                    if (newResumeModel.refrences.isNotEmpty)
                      pw.Row(children: [pw.Text('REFRENCES', style: rlText)]),
                    pw.SizedBox(height: 8),
                    if (newResumeModel.refrences.isNotEmpty)
                      pw.Container(
                          width: 290,
                          height: 2,
                          color: const PdfColor.fromInt(0xFF2B354B)),
                    pw.SizedBox(height: 8),
                    buildReferencesGrid(context, newResumeModel.refrences)
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
