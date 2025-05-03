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

Future<void> createPdf_template_10(
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
      color: const PdfColor.fromInt(0xFFC43932), fontSize: 18, fontWeight: pw.FontWeight.bold);
  pw.TextStyle rlbText = pw.TextStyle(
      color: const PdfColor.fromInt(0xFFC43932),
      fontSize: 18,
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
    margin: pw.EdgeInsets.only(right: 0),
  );


  pw.Widget footer(pw.Context context) {
    final pageWidth = context.page.pageFormat.width;

    return pw.Container(
      margin: const pw.EdgeInsets.only(left: 255,right: 0),
      padding: const pw.EdgeInsets.only(right: 0),
      width: pageWidth/2 +45,
      height: 45,
      decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFFC43932),
        borderRadius: pw.BorderRadius.only(topLeft: pw.Radius.circular(45))
      )
    );
  }

  pdf.addPage(
    pw.MultiPage(
      footer: (context)=>footer(context),
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Container(
            margin: const pw.EdgeInsets.only(left: 130),
            padding: const pw.EdgeInsets.only(top: 40, bottom: 20),
            decoration: const pw.BoxDecoration(
                borderRadius:
                    pw.BorderRadius.only(bottomLeft: pw.Radius.circular(40)),
                color: PdfColor.fromInt(0xFFC43932)),
            child: pw
                .Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.SizedBox(width: 20),
              pw.Center(
                child: newResumeModel.profile_image != null
                    ? pw.Container(
                        padding: const pw.EdgeInsets.all(1),
                        decoration: pw.BoxDecoration(
                            color: PdfColors.white,
                            borderRadius: pw.BorderRadius.circular(20)),
                        width: 130,
                        height: 130,
                        child: pw.Center(
                          child: pw.ClipRRect(
                            horizontalRadius: 20,
                            verticalRadius: 20,
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
                          color: PdfColors.white,
                          borderRadius: pw.BorderRadius.circular(10),
                        ),
                        width: 130,
                        height: 130,
                        child: pw.Center(
                          child: pw.ClipRRect(
                            horizontalRadius: 110,
                            verticalRadius: 110,
                          ),
                        ),
                      ),
              ),
              pw.SizedBox(width: 60),
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 0, top: 0),
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          constraints: const pw.BoxConstraints(maxWidth: 100),
                          child: pw.Text(
                            newResumeModel.intro!.firstName,
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
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
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
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
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
            ]),
          ),
          pw.Container(
              margin: const pw.EdgeInsets.only(top: -200, bottom: 60),
              width: 130,
              height: 2,
              color: const PdfColor.fromInt(0xFFC43932)),
          pw.Container(
            margin: const pw.EdgeInsets.only(top: -130, bottom: 10),
            decoration: const pw.BoxDecoration(
                color: PdfColors.white,
                borderRadius:
                    pw.BorderRadius.only(topRight: pw.Radius.circular(60))),
            height: 140,
            width: 130,
          ),
          pw.Partitions(children: [
            pw.Partition(
                child: pw.Container(
                    color: PdfColors.white,
                    padding:
                        const pw.EdgeInsets.only(left: 10, top: 0, bottom: 0),
                    margin:
                        const pw.EdgeInsets.only(right: 48, top: 0, left: -10,bottom: -45),

                    child: pw.ConstrainedBox(
                      constraints:
                          const pw.BoxConstraints(maxWidth: double.infinity),
                      child: pw.Column(
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.all(40),
                            margin: const pw.EdgeInsets.only(right: 30),
                            decoration: const pw.BoxDecoration(

                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                //description
                                pw.Container(
                                    width: 220,
                                    child: pw.Text('Description', style: rlText)),
                                pw.SizedBox(height: 10),
                                pw.Container(
                                  margin: pw.EdgeInsets.zero,
                                  constraints:
                                      const pw.BoxConstraints(maxWidth: 200),
                                  child: pw.Text(
                                    newResumeModel.intro!.summary,
                                    style: sText,
                                  ),
                                ),
                                pw.SizedBox(height: 20),
                                pw.Container(margin: const pw.EdgeInsets.only(left: -40),child: pw.Stack(children:
                                [
                                  pw.Container(
                                      margin: const pw.EdgeInsets.only(),
                                      height: 50,
                                      color:const PdfColor.fromInt(0xFF404447)
                                  ),

                                  pw.Container(
                                    margin: const pw.EdgeInsets.only(right: -2),
                                    padding: const pw.EdgeInsets.only(right: 2),
                                    height: 50,
                                    decoration: const pw.BoxDecoration(
                                        color: PdfColors.white,
                                        borderRadius: pw.BorderRadius.only(
                                            bottomLeft: pw.Radius.circular(50)
                                        )
                                    ),
                                  ),

                                ]),),
                                pw.Container(
                                  padding: const pw.EdgeInsets.symmetric(vertical: 20),
                                  margin: const pw.EdgeInsets.only(left: -40,right: -40),
                                    decoration: const pw.BoxDecoration(
                                        color: PdfColor.fromInt(0xFF404447),
                                      borderRadius: pw.BorderRadius.only(
                                        topRight: pw.Radius.circular(40),bottomRight: pw.Radius.circular(40)
                                      )
                                    ),
                                  child: pw.Column(children: [

                                    if(newResumeModel.skills.isNotEmpty)
                                      pw.Container
                                        (
                                          margin: const pw.EdgeInsets.only(bottom: 10,left: 40),
                                          alignment: pw.Alignment.center,
                                          width: 315,height: 25,
                                          child:pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start,mainAxisAlignment: pw.MainAxisAlignment.start,
                                              children: [
                                                pw.Text('Expertiese', style: pw.TextStyle(
                                                    color: PdfColors.white, fontSize: 18, fontWeight: pw.FontWeight.bold))
                                              ]
                                          )
                                      ),
                                    pw.Container(
                                      margin: const pw.EdgeInsets.only(left: -5,right: -40),
                                      padding: const pw.EdgeInsets.only(top: 5),
                                      constraints: const pw.BoxConstraints(maxWidth: 200),
                                      child: pw.Wrap(
                                        alignment: pw.WrapAlignment.center,
                                        crossAxisAlignment: pw.WrapCrossAlignment.center,
                                        children: List.generate(newResumeModel.skills.length,
                                              (index) {
                                            final sk = newResumeModel.skills[index];
                                            return pw.Stack(
                                              alignment: pw.Alignment.center,
                                              children: [
                                                pw.Container(
                                                  margin: const pw.EdgeInsets.only(right: 10),
                                                  height: 70,
                                                  width: 70,
                                                  child: pw.CircularProgressIndicator(
                                                    strokeWidth: 8,
                                                    color: const PdfColor.fromInt(0xFFC43932),
                                                    backgroundColor:  PdfColors.white,
                                                    value: sk.level / 100,
                                                  ),
                                                ),
                                                pw.Container(margin: const pw.EdgeInsets.only(left: -8),child: pw.Text(
                                                  sk.skillName,
                                                  style: const pw.TextStyle(fontSize: 14,color: PdfColors.white),
                                                  textAlign: pw.TextAlign.center,
                                                ),)
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ])
                                ),
                                pw.Container(
                                  margin: const pw.EdgeInsets.only(left: -40),
                                  child: pw.Stack(
                                      children:
                                      [
                                  pw.Container(
                                      margin: const pw.EdgeInsets.only(),
                                      height: 50,
                                      color:const PdfColor.fromInt(0xFF404447)
                                  ),

                                  pw.Container(
                                    margin: const pw.EdgeInsets.only(),
                                    padding: const pw.EdgeInsets.only(),
                                    height: 50,
                                    decoration: const pw.BoxDecoration(
                                        color: PdfColors.white,
                                        borderRadius: pw.BorderRadius.only(
                                            topLeft: pw.Radius.circular(50)
                                        )
                                    ),
                                  ),

                                ]),),

                                //contact

                                pw.Container(
                                  margin: const pw.EdgeInsets.only(top: -50,left: -40,right: -40),
                                  padding: const pw.EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),

                                    decoration: const pw.BoxDecoration(
                                        color:PdfColor.fromInt(0xFFD4D4D4),
                                        borderRadius: pw.BorderRadius.only(
                                            topLeft: pw.Radius.circular(50)
                                                ,topRight: pw.Radius.circular(40),bottomRight: pw.Radius.circular(40)
                                        )
                                    ),

                                    child: pw.Column(
                                  children: [
                                    pw.Container(
                                        width: 220,
                                        child: pw.Text('CONTACT', style: rlText)),
                                    pw.SizedBox(height: 10),
                                    pw.Container(
                                      margin: const pw.EdgeInsets.only(left: 0),
                                      child: pw.Column(
                                        mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Row(children: [
                                            pw.Container(
                                              width: 20,height: 20,
                                              padding: const pw.EdgeInsets.all(5),
                                              decoration: pw.BoxDecoration(
                                                  color: const PdfColor.fromInt(0xFFC43932),
                                                  borderRadius: pw.BorderRadius.circular(10)
                                              ),
                                              child:pw.Container(
                                              width: 7,
                                              height: 6,
                                              child: pw.Image(phoneImage),
                                            ),),
                                            pw.SizedBox(width: 5),
                                            pw.Text(
                                               "Phone Number",
                                                style: sText),
                                            pw.SizedBox(width: 5),
                                            pw.Text(
                                                newResumeModel.contact!.phoneNumber,
                                                style: sText),
                                          ]),
                                          pw.SizedBox(height: 10),
                                          pw.Row(children: [
                                            pw.Container(
                                              width: 20,height: 20,
                                              padding: const pw.EdgeInsets.all(5),
                                              decoration: pw.BoxDecoration(
                                                  color: const PdfColor.fromInt(0xFFC43932),
                                                  borderRadius: pw.BorderRadius.circular(10)
                                              ),
                                              child: pw.Container(
                                                padding: const pw.EdgeInsets.only(bottom: 1.5),
                                              width: 6,
                                              height: 5,
                                              child: pw.Image(emailImage),
                                            ),),
                                            pw.SizedBox(width: 5),
                                            pw.Text(
                                                "Email",
                                                style: sText),
                                            pw.SizedBox(width: 5),
                                            pw.Container(
                                              constraints: const pw.BoxConstraints(
                                                  maxWidth: 200),
                                              child: pw.Text(
                                                  newResumeModel.contact!.email,
                                                  style: sText),
                                            ),
                                          ]),
                                          pw.SizedBox(height: 10),
                                          pw.Row(children: [
                                            pw.Container(
                                              width: 20,height: 20,
                                              padding: const pw.EdgeInsets.all(5),
                                              decoration: pw.BoxDecoration(
                                                  color: const PdfColor.fromInt(0xFFC43932),
                                                  borderRadius: pw.BorderRadius.circular(10)
                                              ),
                                              child: pw.Container(

                                              width: 7,
                                              height: 6,
                                              child: pw.Image(locationImage),
                                            ),),
                                            pw.SizedBox(width: 5),
                                            pw.Text(
                                                "Address",
                                                style: sText),
                                            pw.SizedBox(width: 5),
                                            pw.Container(
                                              constraints: const pw.BoxConstraints(
                                                  maxWidth: 200),
                                              child: pw.Text(
                                                  newResumeModel.contact!.address,
                                                  style: sText),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ]
                                )),

                                pw.Container(
                                  margin: const pw.EdgeInsets.only(left: -40,bottom: 0),
                                  child: pw.Stack(children: [
                                    pw.Container( margin: const pw.EdgeInsets.only(left: 0),height: 50,color:const PdfColor.fromInt(0xFFD4D4D4) ),

                                    pw.Container(
                                      margin: const pw.EdgeInsets.only(top:0,left: 0,right: 0),
                                      height: 50,decoration: const pw.BoxDecoration(
                                        color: PdfColors.white,
                                        borderRadius: pw.BorderRadius.only(

                                            topLeft: pw.Radius.circular(50)
                                        )
                                    ),
                                    )

                                  ]),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))),

            ////right colum
            pw.Partition(
              child: pw.Container(
                margin: const pw.EdgeInsets.only(left: -40, top: -5, right: -10),
                padding: const pw.EdgeInsets.only(left: 20, top: 20),
                width: 400,
                decoration: const pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.only(
                      topLeft: pw.Radius.circular(30),
                      bottomRight: pw.Radius.circular(10)),
                  color: PdfColors.white,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    //////// Work Experience/////////////////////////////////////
                    pw.Container(child: pw.Column(children: [
                      if (newResumeModel.experience.isNotEmpty)
                        pw.Row(children: [
                          pw.Container(
                            width: 290,
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: pw.Text(
                              'WORK EXPERIENCE',
                              style: rlbText,
                            ),
                          )
                        ]),
                      pw.SizedBox(height: 8),

                      pw.Container(
                          margin: const pw.EdgeInsets.only(right: 20),
                          padding: const pw.EdgeInsets.only(top: 20),
                          constraints: const pw.BoxConstraints(maxWidth: 290),
                          child: pw.ListView.builder(
                            itemCount: newResumeModel.experience.length,
                            itemBuilder: (context, index) {
                              final item = newResumeModel.experience[index];

                              return pw.Container(
                                  margin: const pw.EdgeInsets.only(left: 0),
                                  width: 290,
                                  child: pw.Column(
                                    children: [
                                      pw.Container(
                                        margin: const pw.EdgeInsets.only(left: 5),
                                        padding:
                                        const pw.EdgeInsets.only(top: -15),
                                        child: pw.Column(
                                          crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Container(
                                              width: 300,
                                              constraints:
                                              const pw.BoxConstraints(
                                                  maxWidth: 300),
                                              child: pw.Row(
                                                mainAxisAlignment: pw
                                                    .MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  pw.Container(
                                                    constraints:
                                                    const pw.BoxConstraints(
                                                        maxWidth: 200),
                                                    child: pw.Text(item.company,
                                                        style: bText),
                                                  ),
                                                  pw.Text(
                                                      '  ${item.from} - ${item.to}',
                                                      style: b2Text),
                                                ],
                                              ),
                                            ),
                                            pw.Container(
                                              constraints:
                                              const pw.BoxConstraints(
                                                  maxWidth: 280),
                                              child: pw.Text(item.position,
                                                  style: const pw.TextStyle(
                                                      color: PdfColors.black,
                                                      fontSize: 10),
                                                  textAlign: pw.TextAlign.left),
                                            ),
                                            pw.SizedBox(height: 2),
                                            pw.Container(
                                              constraints:
                                              const pw.BoxConstraints(
                                                  maxWidth: 260),
                                              child: pw.Flexible(
                                                  child: pw.Text(item.position,
                                                      style: const pw.TextStyle(
                                                          color: PdfColors.black,
                                                          fontSize: 8),
                                                      textAlign: pw.TextAlign.left),
                                              ),
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
                        pw.Row(children: [
                          pw.Container(
                            width: 290,
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: pw.Text(
                              'EDUCATION',
                              style: rlbText,
                            ),
                          )
                        ]),
                      pw.SizedBox(height: 8),
                      pw.ListView.builder(
                        itemCount: newResumeModel.education.length,
                        itemBuilder: (context, index) {
                          final item = newResumeModel.education[index];
                          return pw.Container(
                              margin: const pw.EdgeInsets.only(left: -13),
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
                                            child: pw.Text(item.schoolTitle,
                                                style: bText),
                                          ),
                                          pw.Text('  ${item.from} - ${item.to}',
                                              style: b2Text),
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
                                          child: pw.Text(item.major,
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

                      pw.SizedBox(height: 8),

                      // Acievement
                      if (newResumeModel.achievements.isNotEmpty)
                        pw.Row(children: [
                          pw.Container(
                            width: 290,
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: pw.Text(
                              'ACHIEVEMENT',
                              style: rlbText,
                            ),
                          )
                        ]),
                      pw.SizedBox(height: 8),
                      pw.ListView.builder(
                        itemCount: newResumeModel.achievements.length,
                        itemBuilder: (context, index) {
                          final item = newResumeModel.achievements[index];
                          return pw.Container(
                              margin: const pw.EdgeInsets.only(left: -13),
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
                                            child: pw.Text(item.name,
                                                style: bText),
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
                    ]))
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
