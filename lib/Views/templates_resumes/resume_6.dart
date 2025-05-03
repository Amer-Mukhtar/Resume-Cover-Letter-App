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




Future<void> createPdf_Resume6(ResumeModel newResumeModel,String action,BuildContext context) async {

  Uint8List? dot0;
  Uint8List? profile0;
  Uint8List? email0;
  Uint8List? www0;
  Uint8List? location0;
  Uint8List? phone0;
  Uint8List? dotBlack;

  pw.TextStyle sText = const pw.TextStyle(color: PdfColors.white, fontSize: 10);
  pw.TextStyle sbText = pw.TextStyle(color: PdfColors.white, fontSize: 10,fontWeight: pw.FontWeight.bold);
  pw.TextStyle bText=pw.TextStyle(color: PdfColors.grey900,fontWeight: pw.FontWeight.bold,fontSize: 10);
  pw.TextStyle b2Text=const pw.TextStyle(color: PdfColors.grey800,fontSize: 12);

  pw.TextStyle lText = pw.TextStyle(color: PdfColors.white, fontSize: 20, fontWeight: pw.FontWeight.bold);

  pw.TextStyle rsText = const pw.TextStyle(color: PdfColor.fromInt(0xFF163852), fontSize: 10);
  pw.TextStyle rsbText = pw.TextStyle(color: const PdfColor.fromInt(0xFF163852), fontSize: 10,fontWeight: pw.FontWeight.bold);

  pw.TextStyle rlText = pw.TextStyle(color: const PdfColor.fromInt(0xFF163852), fontSize: 20, fontWeight: pw.FontWeight.bold);


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

  pdf.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {

        return[
          pw.Container(
            margin: const pw.EdgeInsets.only(bottom: -88),
            color: const PdfColor.fromInt(0xFF163852),
            height: 180
          ),
          pw.Partitions(children:
          [


            pw.Partition
              (
                child:pw.Container(
                  padding: const pw.EdgeInsets.only(left: 20,top: 10,bottom: 10),
                    height: 841,
                    color: const PdfColor.fromInt(0xFF163852),
                    child:pw.ConstrainedBox(
                        child:
                    pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [



                        ///Contact/////////////


                        pw.Text('CONTACT', style: lText),pw.SizedBox(
                            height: 20
                        ),

                        pw.Row(children: [
                          pw.Container(width: 14,height: 12,child:pw.Image(phoneImage,),),
                          pw.SizedBox(width: 5),
                          pw.Text(newResumeModel.contact!.phoneNumber, style: sText),
                        ]),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Container(width: 12,height: 10,child:pw.Image(emailImage,),),
                          pw.SizedBox(width: 5),
                          pw.Container(constraints: const pw.BoxConstraints(maxWidth: 200),child:  pw.Text(newResumeModel.contact!.email, style: sText),)
                        ]),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Container(width: 14,height: 12,child:pw.Image(locationImage,),),
                          pw.SizedBox(width: 5),
                          pw.Container(constraints: const pw.BoxConstraints(maxWidth: 200),child:  pw.Text(newResumeModel.contact!.address, style: sText),)
                        ]),
                        pw.SizedBox(height: 10),
                        pw.Row(children:
                        [
                          pw.Container(width: 16,height: 14,child:pw.Image(wwwImage,),),
                          pw.SizedBox(width: 5),
                          pw.Container(constraints: const pw.BoxConstraints(maxWidth: 200),child: pw.Text(newResumeModel.contact!.website, style: sText),)
                        ]
                        ),

                        pw.SizedBox(height: 10),
                        // Education
                        if(newResumeModel.education.isNotEmpty)
                          pw.Text('EDUCATION', style: lText),
                        pw.SizedBox(
                            height: 20
                        ),
                        pw.ListView.builder(
                          itemCount: newResumeModel.education.length,
                          itemBuilder: (context, index) {
                            final item = newResumeModel.education[index];
                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Row(children: [
                                  pw.Text('${item.from} ', style: sbText),
                                  pw.Text(' - ${item.to}', style: sbText),
                                ]),
                                pw.SizedBox(height: 2),
                                pw.Container(constraints: const pw.BoxConstraints(maxWidth: 200),child: pw.Text(item.schoolTitle, style: sbText),),
                                pw.SizedBox(height: 5),
                                pw.Row(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  mainAxisAlignment:pw.MainAxisAlignment.start,
                                  children: [
                                    pw.Column(children: [pw.SizedBox(height: 4),pw.Container(
                                      width: 8,
                                      height: 6,
                                      child: pw.Image(DotImage),
                                    ),]),
                                    pw.SizedBox(width: 5),
                                    pw.Column(
                                        children: [
                                          pw.Container(constraints: const pw.BoxConstraints(maxWidth: 200),child:  pw.Text(item.major, style: sText),)
                                        ]) ],
                                ),

                                pw.SizedBox(height: 10),  // Add spacing between items
                              ],
                            );
                          },
                        ),

                        pw.SizedBox(height: 10),

                        // Skills Heading
                        if(newResumeModel.skills.isNotEmpty)
                          pw.Text('SKILLS', style: lText),
                        pw.SizedBox(
                            height: 20
                        ),
                        pw.ListView.builder(
                          itemCount:newResumeModel.skills.length,
                          itemBuilder: (context, index) {

                            return pw.Column(
                                children: [
                                  pw.Row(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment:pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Column(
                                          children:
                                          [
                                            pw.SizedBox(height: 4),
                                            pw.Container(
                                              width: 8,
                                              height: 6,
                                              child: pw.Image(DotImage),
                                            ),
                                          ]
                                      ),
                                      pw.SizedBox(width: 5),
                                      pw.Column(children: [ pw.Container(constraints: const pw.BoxConstraints(maxWidth: 200),child: pw.Text(
                                        newResumeModel.skills[index].skillName,
                                        style: sText,
                                      ),)])
                                    ],
                                  ),

                                  pw.SizedBox(height: 3,)
                                ]);
                          },
                        ),


                        pw.SizedBox(height: 20),





                        // Languages heading /////////////////////////


                        if(newResumeModel.languages.isNotEmpty)
                          pw.Text('LANGUAGES', style: lText),

                        pw.SizedBox(
                          height: 20
                        ),
                        pw.ListView.builder(
                          itemCount: newResumeModel.languages.length,
                          itemBuilder: (context, index) {
                            return pw.Container(
                              width: 200,  // The container's width
                              child: pw.Column(

                                children: [
                                  pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    children:
                                    [
                                      pw.Column(
                                          children:
                                          [   pw.SizedBox(height: 4),
                                            pw.Container(
                                              width: 8,
                                              height: 6,
                                              child: pw.Image(DotImage),
                                            ),
                                          ]
                                      ),
                                      pw.SizedBox(width: 5),
                                      pw.Column(
                                          children:
                                          [
                                            pw.Container
                                              (
                                              constraints: const pw.BoxConstraints(maxWidth: 200),
                                              child: pw.Text(
                                                newResumeModel.languages[index].language,
                                                style: sText,
                                              ),
                                            ),])
                                    ],
                                  ),
                                  pw.SizedBox(height: 3),
                                ],
                              ),
                            );
                          },
                        ),pw.SizedBox(
                            height: 20
                        ),


                      ],
                    ), constraints: const pw.BoxConstraints(maxWidth: 10)
                    )
                )
            ),


            ////center colum
            pw.Partition(child:
            pw.Container(
              decoration: const pw.BoxDecoration(
                borderRadius: pw.BorderRadius.only(topRight: pw.Radius.circular(100),topLeft: pw.Radius.circular(100))
               , color: PdfColors.white,),
              padding: const pw.EdgeInsets.only(left: 20,right: 20,bottom: 10),
              height: 841,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  //profile
                  pw.SizedBox(height: 20),
                  pw.Row(children:
                  [
                    pw.Row(children:
                    [
                      pw.SizedBox(width: 0,),
                      pw.Center(
                        child: newResumeModel.profile_image != null
                            ? pw.Container(
                          padding: const pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(
                            color: PdfColors.white,
                            borderRadius: pw.BorderRadius.circular(80),
                          ),
                          width: 160,
                          height: 160,
                          child: pw.ClipOval(
                            child: pw.Container(
                              width: 160,
                              height: 160,
                              child: pw.Center(
                                child: pw.Image(
                                  pw.MemoryImage(
                                    newResumeModel.profile_image!,
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
                            borderRadius: pw.BorderRadius.circular(80),
                          ),
                          width: 160,
                          height: 160,
                          child: pw.ClipOval(
                            child: pw.Container(
                              width: 160,
                              height: 160,

                            ),
                          ),
                        ),
                      )

                    ]
                    )
                  ]
                  ),
                  pw.SizedBox(height: 20),
                  pw.Container(
                      child: pw.Container(
                        margin: const pw.EdgeInsets.only(left: 25),
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 40),
                            pw.Container(constraints: const pw.BoxConstraints(maxWidth: 200),  child: pw.Text("${newResumeModel.intro!.firstName} ${newResumeModel.intro!.lastName}",style: pw.TextStyle(fontSize: 26,color: PdfColors.grey800,fontWeight: pw.FontWeight.bold)),
                            ),
                            pw.Container(constraints: const pw.BoxConstraints(maxWidth: 250),child:  pw.Text(newResumeModel.job, style: const pw.TextStyle(fontSize: 12,color: PdfColors.grey600)),),

                          ],
                        ),
                      )
                  ),
                  pw.SizedBox(height: 20),

                  pw.Container(
                      margin: const pw.EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                      constraints: const pw.BoxConstraints(maxWidth: 280),
                      child: pw.Text(newResumeModel.intro!.summary,
                        style: b2Text,
                      )
                  ),
                ],
              ),
            ),
            ),

            ////right colum
            pw.Partition(child:
            pw.Container(
              height: 841, padding: const pw.EdgeInsets.only(left: 20,top: 10,bottom: 10),
              color: const PdfColor.fromInt(0xFF163852),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [

                  //////// Work Experience/////////////////////////////////////
                  if(newResumeModel.experience.isNotEmpty)
                    pw.Row(children:
                    [
                      pw.Text('Work Experience', style: lText)
                    ]
                    ),
                  if(newResumeModel.experience.isNotEmpty)
                    pw.Container
                      (
                        width: 315,
                        height: 2,
                        color: const PdfColor.fromInt(0xFF163852)
                    ),
                  pw.SizedBox(height:10),

                  pw.Container(
                      margin: const pw.EdgeInsets.only(right: 20),
                      padding: const pw.EdgeInsets.only(top: 20),
                      constraints: const pw.BoxConstraints(maxWidth: 215),
                      child: pw.ListView.builder(
                        itemCount: newResumeModel.experience.length,
                        itemBuilder: (context, index)
                        {
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
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                        children: [
                                          pw.Container(constraints: const pw.BoxConstraints(maxWidth: 180),child: pw.Text(item.company, style: sText),),

                                          pw.Text('   ${item.from} - ${item.to}', style: sText),
                                        ],
                                      ),

                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Container(
                                            constraints: const pw.BoxConstraints(maxWidth: 280),
                                            child: pw.Text(item.position, style: sText, textAlign: pw.TextAlign.left),
                                          ),
                                        ],
                                      ),
                                      pw.SizedBox(height: 10),
                                      pw.Container(
                                        constraints: const pw.BoxConstraints(maxWidth: 260),
                                        child: pw.Flexible(
                                            child: pw.Column(
                                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                                              children: item.description.split('\n').where((line) => line.isNotEmpty).map((line) {
                                                return pw.Padding(
                                                  padding: const pw.EdgeInsets.only(bottom: 4),
                                                  child: pw.Row(
                                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                    children: [
                                                      pw.Column(
                                                        children: [
                                                          pw.SizedBox(height: 5),
                                                          pw.Container(
                                                            alignment: pw.Alignment.topLeft,
                                                            width: 4,
                                                            height: 8,
                                                            child: pw.Image(Bdot2),
                                                          ),
                                                        ],
                                                      ),
                                                      pw.SizedBox(width: 5),
                                                      pw.Expanded(
                                                        child: pw.Text(
                                                          line,
                                                          style: sText,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            )

                                        ),
                                      ),

                                      pw.SizedBox(height: 8),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                  ),




                ],
              ),
            ),
            )

          ]
          )];
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
      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
      resumeViewModel.setResumeSnapshot(uint8list,newResumeModel);


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
  }
  else
  {
    throw ArgumentError('Invalid action: $action');
  }

}




