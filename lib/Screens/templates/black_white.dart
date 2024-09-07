import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
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
import '../add_resume_screen/resume_view_model.dart';



Future createPdf_B_W(ResumeModel resumeModel, String action,BuildContext context) async
{


  pw.TextStyle wsText = const pw.TextStyle(color: PdfColors.white, fontSize: 14);
  pw.TextStyle CbText = pw.TextStyle(letterSpacing: 4,color: PdfColors.black, fontSize: 36,fontWeight: pw.FontWeight.bold);
  pw.TextStyle sbText=const pw.TextStyle(color: PdfColors.black,fontSize: 12);
  pw.TextStyle mbText=const pw.TextStyle(color: PdfColors.black,fontSize: 18);
  pw.TextStyle sgText=const pw.TextStyle(color: PdfColors.grey800,fontSize: 10);




  Uint8List? address0;
  Uint8List? phoneBW0;
  Uint8List? envelope0;
  Uint8List? dot0;
  Uint8List? bottomLeft;
  Uint8List? topLeft;
  Uint8List? topRight;

  final ByteData address = await rootBundle.load('assets/images/address.png');
  address0 = address.buffer.asUint8List();

  final ByteData envelope = await rootBundle.load('assets/images/envelope.png');
  envelope0 = envelope.buffer.asUint8List();

  final ByteData phoneBW = await rootBundle.load('assets/images/phoneBW.png');
  phoneBW0 = phoneBW.buffer.asUint8List();


  final ByteData dot = await rootBundle.load('assets/images/dot_black.png');
  dot0 = dot.buffer.asUint8List();


  final ByteData bottom_Left = await rootBundle.load('assets/images/bottom_left.png');
  bottomLeft = bottom_Left!.buffer.asUint8List();

  final ByteData top_Left = await rootBundle.load('assets/images/top_left.png');
  topRight = top_Left!.buffer.asUint8List();

  final ByteData top_Right = await rootBundle.load('assets/images/top_right.png');
  topLeft = top_Right.buffer.asUint8List();

  final pdf = pw.Document();

  final addressImage = pw.MemoryImage(address0);
  final phonebwImage = pw.MemoryImage(phoneBW0);
  final envelopeImage = pw.MemoryImage(envelope0);
  final dotImage = pw.MemoryImage(dot0);

  final topLeftImage=pw.MemoryImage(topLeft);
  final topRightImage=pw.MemoryImage(topRight);
  final bottomLeftImage=pw.MemoryImage(bottomLeft);



  const pageTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    orientation: pw.PageOrientation.portrait,
    margin: pw.EdgeInsets.only(right: 10),

  );

  pw.Widget footer(pw.Context context) {
    final pageWidth = context.page.pageFormat.width;

    return pw.Container(
      margin: const pw.EdgeInsets.only(left: -100,bottom: -100),
      padding:const pw.EdgeInsets.only(right: 40,),
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

  pw.ListView certificatebuilder()
  {
    return pw.ListView.builder(
        itemCount: resumeModel.certifications.length,itemBuilder: (context,index)
    {
      final data=resumeModel.certifications[index];
      return(
          pw.Column(children: [
            pw.Container
              (
              margin: const pw.EdgeInsets.only(left: 50),
              child:pw.Row(
                  children:
                  [
                    pw.Container(width: 6,height: 4,child: pw.Image(dotImage,),),
                    pw.SizedBox(width: 5),
                    pw.Container(child: pw.Text(data.certificationName, style: sgText),constraints: const pw.BoxConstraints(maxWidth: 240))
                  ]
              ),
            ),
            pw.SizedBox(height: 10)
          ]
          )
      );
    });
  }

  pdf.addPage(
    pw.MultiPage(
      footer: (context)=>footer(context),
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Container(
              margin: const pw.EdgeInsets.only(left: 0,right: 0,top: 20,bottom: 0),
              child: pw.Partitions(children:
              [
                pw.Partition(
                    child: pw.Partition(
                        child: pw.Container(margin: const pw.EdgeInsets.only(bottom: 125),
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
                              pw.Container(
                                margin: const pw.EdgeInsets.only(top: -125, bottom: 115, right: 80),
                                child: pw.Column(
                                  children: [
                                    pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.center,
                                      children: [
                                        pw.SizedBox(width: 55),
                                        pw.Center(
                                          child: resumeModel.profile_image != null
                                              ? pw.Container(
                                            padding: const pw.EdgeInsets.all(5),
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
                                                      resumeModel.profile_image!,
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              pw.SizedBox(height: 20),

                              ///Contact/////////////

                              pw.Container(
                                  margin: const pw.EdgeInsets.only(bottom: 10,left: 20,right: 10),
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

                                          pw.Row(children: [
                                            pw.Container(width: 30,height: 30,child:pw.Image(phonebwImage,),),
                                            pw.SizedBox(width: 5),
                                            pw.Container(constraints: const pw.BoxConstraints(maxWidth: 240),child: pw.Text(
                                              resumeModel.contact?.phoneNumber.isNotEmpty == true
                                                  ? '${resumeModel.contact?.phoneNumber}'
                                                  : '',
                                              style: sbText,
                                            ),
                                            )

                                          ]),
                                          pw.Row(children: [
                                            pw.Container(width: 30,height: 30,child:pw.Image(envelopeImage,),),
                                            pw.SizedBox(width: 5),
                                            pw.Container(constraints: const pw.BoxConstraints(maxWidth: 220),child: pw.Text('${resumeModel.contact?.email}', style: sbText),)
                                          ]),
                                          pw.Row(children: [
                                            pw.Container(width: 30,height: 30,child:pw.Image(addressImage),),
                                            pw.SizedBox(width: 5),
                                            pw.Container(constraints: const pw.BoxConstraints(maxWidth: 220),child: pw.Text('${resumeModel.contact?.website}', style: sbText),)
                                          ]),
                                        ]),),


                                      ]
                                  )
                              ),


                              // Cerification
                              pw.Container( margin: const pw.EdgeInsets.only(bottom: 10,left: 20,right: 10),child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,

                                  children: [
                                    if(resumeModel.certifications.isNotEmpty)
                                    pw.Container
                                      (
                                        margin: const pw.EdgeInsets.only(bottom: 10),
                                        alignment: pw.Alignment.center,
                                        width: 270,height: 25,color: PdfColors.black,
                                        child:pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.center,mainAxisAlignment: pw.MainAxisAlignment.center,
                                            children: [
                                              pw.Text('Certification', style: wsText)
                                            ]
                                        )
                                    ),
                                    certificatebuilder(),

                                  ]
                              )
                              ),

                              pw.SizedBox(height: 20),
                              // Skills
                              if(resumeModel.skills.isNotEmpty)
                              pw.Container(margin: const pw.EdgeInsets.only(bottom: 0,left: 20,right: 10,),child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container
                                      (padding: const pw.EdgeInsets.symmetric(horizontal: 40,vertical: 20),margin: const pw.EdgeInsets.only(bottom: 10)
                                        ,width: 270,height: 25,color: PdfColors.black,
                                        child:pw.Row(
                                            crossAxisAlignment: pw.CrossAxisAlignment.center,mainAxisAlignment: pw.MainAxisAlignment.center,
                                            children: [
                                              pw.Text('Skills', style: wsText)
                                            ])
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.topLeft,
                                      margin: const pw.EdgeInsets.only(left: 50),
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
                                                    pw.Container(constraints: const pw.BoxConstraints(maxWidth: 240),child: pw.Text(
                                                      lang.skillName,

                                                      style: sgText,
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                              pw.SizedBox(height: 4),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ]
                              )
                              ),
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
                                  pw.Container(constraints: const pw.BoxConstraints(maxWidth: 210),alignment: pw.Alignment.center,child:
                                  pw.Text('${resumeModel.intro?.firstName}', style: CbText),)
                                ]),
                            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,
                                crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [pw.Container(constraints: const pw.BoxConstraints(maxWidth: 210),child:
                                pw.Text('${resumeModel.intro?.lastName}', style: CbText),)
                                ]),
                            pw.Column(children: [
                              pw.SizedBox(height: 10),
                            ]),
                            pw.Center(child: pw.Text(resumeModel.job, style: mbText),)

                          ],
                        ),
                      ),

                      pw.SizedBox(height: 5),
                      if(resumeModel.experience.isNotEmpty)
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
                      pw.SizedBox(height: 10),
                      pw.ListView.builder(
                        itemCount: resumeModel.experience.length,
                        itemBuilder: (context, index) {
                          final WE = resumeModel.experience[index];
                          return pw.Container(
                            margin: const pw.EdgeInsets.only(bottom: 10),

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





                      if(resumeModel.education.isNotEmpty)
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
                      pw.SizedBox(height:  0),
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
                                         pw.Container(constraints: const pw.BoxConstraints(maxWidth: 280),child:  pw.Text(edu.schoolTitle, style: sbText),)
                                        ],
                                      ),

                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Container(constraints: const pw.BoxConstraints(maxWidth: 280),child: pw.Container(child: pw.Text(edu.major, style: sgText, textAlign: pw.TextAlign.left),),)
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

                      if(resumeModel.languages.isNotEmpty)
                      pw.Container
                        (
                          margin: const pw.EdgeInsets.only(bottom: 10),
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
                              return pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.center,
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                                  pw.Container(
                                    //color: PdfColors.red,
                                    padding: const pw.EdgeInsets.all(0),
                                    margin: const pw.EdgeInsets.only(bottom: -13,top: -20),
                                    constraints: const pw.BoxConstraints(maxWidth: 80, maxHeight: 100),
                                    child: pw.Center(
                                      child: pw.Text(
                                        sk.language,
                                        textAlign: pw.TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Stack(
                                    alignment: pw.Alignment.center,
                                    children: [
                                      pw.Container(
                                        height: 50,
                                        width: 50,
                                        child: pw.CircularProgressIndicator(
                                          color: PdfColors.black,
                                          backgroundColor: PdfColors.grey,
                                          value: int.parse(sk.level).toDouble() / 100,
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

  final pdfData = await pdf.save();

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/Resume.pdf");
  resumeModel.resume = file;

  if (action == 'save')
  {

  }
  else if (action == 'preview')
  {



    await file.writeAsBytes(pdfData);
    final pdfDoc = await pdfx.PdfDocument.openFile(file.path);
    final page = await pdfDoc.getPage(1);

    final pdfPageImage = await page.render(
      width: page.width,
      height: page.height,
      format: pdfx.PdfPageImageFormat.png,
    );


    final img.Image? image = img.decodeImage(pdfPageImage!.bytes);
    if (image != null)
    {
      final Uint8List uint8list = Uint8List.fromList(img.encodePng(image));
      resumeModel.resume_snapshot = uint8list;

      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
      resumeViewModel.setResumeSnapshot(uint8list,resumeModel);


      await page.close();
      await pdfDoc.close();
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Template_Preview(
            resumeModel: resumeModel,
          ),
        ),
      );
    } else {
      print('Failed to decode image.');
    }
  }


  else
    {
      throw ArgumentError('Invalid action: $action');
    }
}
