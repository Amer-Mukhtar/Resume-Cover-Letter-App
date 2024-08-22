import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../Models/model_resume.dart';




Future<void> createPdf_B_W(ResumeModel resumeModel) async
{
  pw.TextStyle wsText = const pw.TextStyle(color: PdfColors.white, fontSize: 14);
  pw.TextStyle CbText = pw.TextStyle(letterSpacing: 4,color: PdfColors.black, fontSize: 36,fontWeight: pw.FontWeight.bold);
  pw.TextStyle sbText=const pw.TextStyle(color: PdfColors.black,fontSize: 12);
  pw.TextStyle mbText=const pw.TextStyle(color: PdfColors.black,fontSize: 18);
  pw.TextStyle sgText=const pw.TextStyle(color: PdfColors.grey800,fontSize: 10);


  Uint8List? _address;
  Uint8List? _phoneBW;
  Uint8List? _profile;
  Uint8List? _envelope;
  Uint8List? _dot;

  Uint8List? _bottom_left;
  Uint8List? _top_left;
  Uint8List? _top_right;

  final ByteData address = await rootBundle.load('assets/images/address.png');
  _address = address.buffer.asUint8List();

  final ByteData envelope = await rootBundle.load('assets/images/envelope.png');
  _envelope = envelope.buffer.asUint8List();

  final ByteData phoneBW = await rootBundle.load('assets/images/phoneBW.png');
  _phoneBW = phoneBW.buffer.asUint8List();

  final ByteData profile = await rootBundle.load('assets/images/profile.png');
  _profile = profile.buffer.asUint8List();

  final ByteData dot = await rootBundle.load('assets/images/dot_black.png');
  _dot = dot.buffer.asUint8List();

  final ByteData bottomLeft = await rootBundle.load('assets/images/bottom_left.png');
  _bottom_left = bottomLeft.buffer.asUint8List();

  final ByteData topLeft = await rootBundle.load('assets/images/top_left.png');
  _top_right = topLeft.buffer.asUint8List();

  final ByteData topRight = await rootBundle.load('assets/images/top_right.png');
  _top_left = topRight.buffer.asUint8List();

  if (_address == null || _phoneBW == null || _profile == null || _envelope == null || _dot == null)
  {
    print("Error: One or more images are not loaded.");
    return;
  }

  final pdf = pw.Document();

  final addressImage = pw.MemoryImage(_address!);
  final phonebwImage = pw.MemoryImage(_phoneBW!);
  final envelopeImage = pw.MemoryImage(_envelope!);
  final profileImage = pw.MemoryImage(_profile!);
  final dotImage = pw.MemoryImage(_dot!);

  final topLeftImage=pw.MemoryImage(_top_left!);
  final topRightImage=pw.MemoryImage(_top_right!);
  final bottomLeftImage=pw.MemoryImage(_bottom_left!);



  const pageTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    orientation: pw.PageOrientation.portrait,
    margin: pw.EdgeInsets.only(right: 10),

  );






  pw.Widget footer(pw.Context context) {
    final pageWidth = context.page.pageFormat.width;
    final pageHeight = context.page.pageFormat.height;

    return pw.Container(
      margin: pw.EdgeInsets.only(left: -100,bottom: -100),
      padding:pw.EdgeInsets.only(right: 40,),
      width: pageWidth,
      height: 100,
      child: pw.Image(
        bottomLeftImage,
        width: 250,
        height: 250,

      ),
      alignment: pw.Alignment.bottomLeft,

    );
  }







  pdf.addPage(
    pw.MultiPage(
      footer: (context)=>footer(context),
      pageTheme: pageTheme,
      build: (pw.Context context) {

        return [
          pw.Container(
              margin: pw.EdgeInsets.only(left: 0,right: 0,top: 20,bottom: 0),
              child: pw.Partitions(children:
              [
                pw.Partition(
                    child: pw.Partition(
                        child: pw.Container(margin: pw.EdgeInsets.only(bottom: 125),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Positioned(
                                  left: 0,bottom: 0,
                                  child: pw.Container(
                                    margin: const pw.EdgeInsets.only(left: -160,bottom: -165,top: 10),
                                    alignment: pw.Alignment.topLeft,

                                    child:pw.Positioned(left: 0, bottom: 0,
                                        child: pw.Image(
                                            alignment: pw.Alignment.topLeft,
                                            topRightImage,width: 400,height: 400)
                                    ),
                                  )
                              ),
                              pw.Container(margin: const pw.EdgeInsets.only(top: -125,bottom: 115,right: 80),child: pw.Column(children:
                              [
                                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,children:
                                [
                                  pw.SizedBox(width: 55),
                                  pw.Center(
                                    child: resumeModel.profile_image != null
                                        ? pw.Container(
                                      padding: pw.EdgeInsets.all(5),
                                      decoration: pw.BoxDecoration(
                                        color: PdfColors.white,
                                        borderRadius: pw.BorderRadius.circular(65),
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
                                                File(resumeModel.profile_image!.path).readAsBytesSync(),
                                              ),
                                              fit: pw.BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                        : pw.Container(
                                      padding: pw.EdgeInsets.all(5),
                                      decoration: pw.BoxDecoration(
                                        color: PdfColors.white,
                                        borderRadius: pw.BorderRadius.circular(65),
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
                                ]
                                ),
                              ]
                              ),),

                              pw.SizedBox(height: 20),

                              ///Contact/////////////

                              pw.Container(
                                  margin: pw.EdgeInsets.only(bottom: 10,left: 20,right: 10),
                                  child: pw.Column(
                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                      children:
                                      [
                                        pw.Container
                                          (
                                            width: 270,height: 25,color: PdfColors.black,
                                            child:
                                            pw.Row(
                                                crossAxisAlignment: pw.CrossAxisAlignment.center,
                                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                                children: [
                                                  pw.Text('Contact', style: wsText,)
                                                ])
                                        ),

                                        pw.Container(

                                          margin: const pw.EdgeInsets.only(top: 5,left: 5),child: pw.Column(children: [

                                          pw.Row(children: [pw.Container(width: 30,height: 30,child:pw.Image(phonebwImage,),),
                                            pw.Text(
                                              resumeModel.contact?.phoneNumber?.isNotEmpty == true
                                                  ? '  ${resumeModel.contact?.phoneNumber}'
                                                  : '',
                                              style: sbText,
                                            ),

                                          ]),
                                          pw.Row(children: [
                                            pw.Container(width: 30,height: 30,child:pw.Image(envelopeImage,),),
                                            pw.Text('  ${resumeModel.contact?.email}', style: sbText),
                                          ]),
                                          pw.Row(children: [
                                            pw.Container(width: 30,height: 30,child:pw.Image(addressImage),),
                                            pw.Text('  ${resumeModel.contact?.website}', style: sbText),
                                          ]),
                                        ]),),


                                      ]
                                  )
                              ),


                              // Cerification
                              pw.Container( margin: pw.EdgeInsets.only(bottom: 10,left: 20,right: 10),child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,

                                  children: [
                                    pw.Container
                                      (
                                        margin: pw.EdgeInsets.only(bottom: 10),
                                        alignment: pw.Alignment.center,
                                        width: 270,height: 25,color: PdfColors.black,
                                        child:pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.center,mainAxisAlignment: pw.MainAxisAlignment.center,
                                            children: [
                                              pw.Text('Certification', style: wsText)
                                            ]
                                        )
                                    ),
                                    pw.Container(
                                        margin: const pw.EdgeInsets.only(left: 0),
                                        child: pw.ListView.builder(
                                            itemCount: resumeModel.certifications.length,itemBuilder: (context,index)
                                        {
                                          final data=resumeModel.certifications[index];
                                          return(
                                              pw.Column(children: [
                                                pw.Container
                                                  (
                                                  child:pw.Row(
                                                      children:
                                                      [
                                                        pw.Container(width: 6,height: 4,child: pw.Image(dotImage,),),
                                                        pw.SizedBox(width: 5),
                                                        pw.Text(data.certificationName, style: sgText)
                                                      ]
                                                  ),
                                                ),
                                                pw.SizedBox(height: 10)
                                              ]
                                              )
                                          );
                                        })
                                    ),
                                  ]
                              )
                              ),


                              // Language Heading
                              pw.Container(margin: pw.EdgeInsets.only(bottom: 0,left: 20,right: 10,),child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container
                                      (padding: const pw.EdgeInsets.symmetric(horizontal: 40,vertical: 20),margin: pw.EdgeInsets.only(bottom: 10)
                                        ,width: 270,height: 25,color: PdfColors.black,
                                        child:pw.Row(
                                            crossAxisAlignment: pw.CrossAxisAlignment.center,mainAxisAlignment: pw.MainAxisAlignment.center,
                                            children: [
                                              pw.Text('Skills', style: wsText)
                                            ])
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.topLeft,
                                      margin: const pw.EdgeInsets.only(left: 0),
                                      child: pw.ListView.builder(
                                        itemCount: resumeModel.skills.length,
                                        itemBuilder: (pw.Context context, int index) {
                                          final lang = resumeModel.skills[index];
                                          return pw.Column(
                                            children: [
                                              pw.Container(
                                                child: pw.Row(
                                                  children: [
                                                    pw.Container(
                                                      width: 6,
                                                      height: 4,
                                                      child: pw.Image(dotImage),
                                                    ),
                                                    pw.SizedBox(width: 5),
                                                    pw.Text(
                                                      lang.skillName,

                                                      style: sgText,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              pw.SizedBox(height: 4),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ])),
                              pw.SizedBox(height: 30),


                            ],
                          ),
                        )
                    )
                ),



                ////Right Column
                pw.Partition(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [

                      pw.Container(color: PdfColors.grey,child: pw.Positioned(
                          left: 0,bottom: 0,right: 0,
                          child: pw.Container(margin: const pw.EdgeInsets.only(right: -430,top: -130),

                            alignment: pw.Alignment.topRight,

                            width: 100,height: 100,
                            child:pw.Positioned(left: 0, bottom: 0,
                                child: pw.Image(
                                    alignment: pw.Alignment.topRight,
                                    topLeftImage,width: 300,height: 300)
                            ),
                          )
                      ),
                      ),

                      pw.Container(alignment: pw.Alignment.center,
                        margin: const pw.EdgeInsets.only(left: 25,right: 100,top: 10,bottom: 15),
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.SizedBox(height: 40),
                            pw.Row(  mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Container(alignment: pw.Alignment.center,child:
                                  pw.Text('${resumeModel.intro?.firstName}', style: CbText),)
                                ]),
                            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Text('${resumeModel.intro?.lastName}', style: CbText),
                                ]),
                            pw.Column(children: [
                              pw.SizedBox(height: 10),
                            ]),
                            pw.Center(child: pw.Text('${resumeModel.job}', style: mbText),)

                          ],
                        ),
                      ),

                      pw.SizedBox(height: 5),
                      pw.Container
                        (
                          margin: const pw.EdgeInsets.only(bottom: 20),
                          alignment: pw.Alignment.center,
                          width: 315,height: 25,color: PdfColors.black,
                          child:pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.center,mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text('Work Experience', style: wsText)
                              ]
                          )
                      ),
                      pw.ListView.builder(
                        itemCount: resumeModel.experience.length,
                        itemBuilder: (context, index) {
                          final WE = resumeModel.experience[index];
                          return pw.Container(
                            margin: pw.EdgeInsets.only(bottom: 10),

                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [

                                pw.SizedBox(width: 6),
                                pw.Container(
                                  margin: const pw.EdgeInsets.only(left: -5,bottom: -20),
                                  padding: const pw.EdgeInsets.only(top: -15),
                                  child: pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                        children: [
                                          pw.Text(WE.company, style: sbText),
                                        ],
                                      ),

                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Container(
                                            constraints: const pw.BoxConstraints(maxWidth: 280),
                                            child: pw.Text(WE.location, style: sbText, textAlign: pw.TextAlign.left),
                                          ),
                                        ],
                                      ),

                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Container(
                                            constraints: const pw.BoxConstraints(maxWidth: 280),
                                            child: pw.Text('${WE.from} - ${WE.to}', style: sbText, textAlign: pw.TextAlign.left),
                                          ),
                                        ],
                                      ),

                                      pw.Row(children:
                                      [
                                        pw.Container(constraints: const pw.BoxConstraints(maxWidth: 280),child:
                                        pw.Flexible(child: pw.Text(

                                          WE.description,
                                          style: sgText,
                                        ),)
                                        ),
                                      ]),
                                      pw.Row(children: [pw.SizedBox(height: 10),
                                        pw.SizedBox(height: 40)])

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),





                      pw.Container
                        (
                          alignment: pw.Alignment.center,
                          width: 315,height: 25,color: PdfColors.black,
                          child:pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.center,mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text('Education', style: wsText)
                              ]
                          )
                      ),
                      pw.SizedBox(height:  15),
                      pw.ListView.builder(
                        itemCount: resumeModel.education.length,
                        itemBuilder: (context, index) {
                          final edu =resumeModel.education[index];
                          return pw.Container(

                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [

                                pw.SizedBox(width: 6),
                                pw.Container(
                                  margin: const pw.EdgeInsets.only(left: -5),
                                  padding: const pw.EdgeInsets.only(top: 5),
                                  child: pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                        children: [
                                          pw.Text(edu.schoolTitle, style: sbText),
                                        ],
                                      ),

                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Container(child: pw.Text(edu.major, style: sgText, textAlign: pw.TextAlign.left),),
                                        ],
                                      ),
                                      pw.Row(children:
                                      [
                                        pw.Container(child: pw.Text('${edu.from} - ${edu.to}', style: sgText,),),
                                      ]),
                                      pw.SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      pw.Container
                        (
                          margin: pw.EdgeInsets.only(bottom: 10),
                          alignment: pw.Alignment.center,
                          width: 315,height: 25,color: PdfColors.black,
                          child:pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.center,mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text('Languages', style: wsText)
                              ]
                          )
                      ),
                      pw.Container(
                        constraints: const pw.BoxConstraints(maxWidth: 315),
                        child: pw.Wrap(
                          alignment: pw.WrapAlignment.center,
                          crossAxisAlignment: pw.WrapCrossAlignment.center,
                          children: List.generate(resumeModel.languages.length,
                                (index) {
                              final sk = resumeModel.languages[index];
                              return pw.Container(
                                constraints: const pw.BoxConstraints(maxWidth: 80, maxHeight: 100),
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                                  mainAxisAlignment: pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Container(
                                      child: pw.Flexible(
                                        child: pw.Center(
                                          child: pw.Text(
                                            sk.language,
                                            textAlign: pw.TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    pw.SizedBox(height: 10),
                                    pw.Stack(
                                      alignment: pw.Alignment.center,
                                      children: [
                                        pw.Container(
                                          height: 50,
                                          width: 50,
                                          child: pw.CircularProgressIndicator(
                                            color: PdfColors.black,
                                            backgroundColor: PdfColors.grey,
                                            value: int.parse(sk.level).toDouble(),// / 100,
                                          ),
                                        ),
                                        pw.Text(
                                          '${sk.level}%',
                                          style: const pw.TextStyle(fontSize: 12),
                                          textAlign: pw.TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )


                    ],
                  ),
                )

              ]
              ))
        ];
      },
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/example.pdf");
  await file.writeAsBytes(await pdf.save());
  await OpenFile.open(file.path);
}
