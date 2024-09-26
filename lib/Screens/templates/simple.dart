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




Future<void> createPdf_simple(ResumeModel newResumeModel,String action,BuildContext context) async
{

  Uint8List? dot0;
  Uint8List? profile0;
  Uint8List? email0;
  Uint8List? www0;
  Uint8List? location0;
  Uint8List? phone0;
  Uint8List? dotBlack;


  pw.TextStyle SBText = pw.TextStyle(color: PdfColors.grey, fontSize: 10,fontWeight: pw.FontWeight.bold);
  pw.TextStyle MBText = pw.TextStyle(color: PdfColors.black, fontSize: 12, fontWeight: pw.FontWeight.bold);
  pw.TextStyle LBText = pw.TextStyle(color: PdfColors.black, fontSize: 14, fontWeight: pw.FontWeight.bold);
  pw.TextStyle TitleText = pw.TextStyle(color:  PdfColors.black, fontSize: 26, fontWeight: pw.FontWeight.bold);

  pw.TextStyle SubTitleText = pw.TextStyle(color: PdfColors.black, fontSize: 20, fontWeight: pw.FontWeight.bold);

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



  pdf.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {

        return[

         pw.Container(padding: pw.EdgeInsets.only(top: 70),child:  pw.Row(
             mainAxisAlignment: pw.MainAxisAlignment.center,
             children:
             [
               pw.Text(newResumeModel.intro!.firstName,style: TitleText),
               pw.SizedBox(width: 5),
               pw.Text(newResumeModel.intro!.lastName,style: TitleText)
             ]
         ),),
          pw.Center(child: pw.Text(newResumeModel.job,style: SubTitleText)),
         pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child:  pw.Divider(thickness: 0.5,color: PdfColors.black),),
          pw.Row( mainAxisAlignment: pw.MainAxisAlignment.center,children: [
            pw.Text(newResumeModel.contact!.address,style: SBText),
            pw.Text(' | ',style: SBText),
            pw.Text(newResumeModel.contact!.website,style: SBText),
            pw.Text(' | ',style: SBText),
            pw.Text(newResumeModel.contact!.email,style: SBText)
          ]),
          pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child:  pw.Divider(thickness: 0.5,color: PdfColors.black),),

          //summary
          pw.Container(margin: pw.EdgeInsets.only(top: 10,bottom: 10,left: 30,right: 30),constraints: pw.BoxConstraints(maxWidth: 315),child: pw.Text(newResumeModel.intro!.summary)),
          pw.SizedBox(height: 20),
          pw.Row(
            children: [
              pw.SizedBox(width: 10),
              pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child: pw.Text('Area of Expertise',style: LBText),)
            ]
          ),
          pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child:  pw.Divider(thickness: 0.5,color: PdfColors.black),),

          pw.Container(

            constraints: const pw.BoxConstraints(maxWidth: 650),
            child: pw.GridView(
              crossAxisCount: 3,
              childAspectRatio: 0.1,
              children: List.generate(
                newResumeModel.skills.length,
                    (index) {
                  final sk = newResumeModel.skills[index];
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(0),
                        margin: const pw.EdgeInsets.only(bottom: -13, top: -20),
                        constraints: const pw.BoxConstraints(),
                        child: pw.Center(
                          child: pw.Text(
                            sk.skillName,
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Row(
              children: [
                pw.SizedBox(width: 10),
                pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child: pw.Text('KEY ACHIEVEMENTS',style: LBText),)
              ]
          ),
          pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child:  pw.Divider(thickness: 0.5,color: PdfColors.black),),
          pw.Container(
              constraints: const pw.BoxConstraints(maxWidth: 315),
              child: pw.ListView.builder(
                itemCount: newResumeModel.achievements.length,
                itemBuilder: (context, index)
                {
                  final item = newResumeModel.achievements[index];
                  return pw.Container(
                    margin: pw.EdgeInsets.symmetric(horizontal: 30),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 10),
                        pw.Container(
                          constraints: const pw.BoxConstraints(maxWidth: 260),
                          child: pw.Flexible(
                              child: pw.Row(
                                children: [
                                 pw.Column(children: [
                              pw.SizedBox(height: 4),pw.Container(
                                     alignment: pw.Alignment.topLeft,
                                     width: 4,
                                     height: 8,
                                     child: pw.Image(Bdot2),
                                   ),
                                 ]),
                                 pw.SizedBox(width: 5),
                                 pw.Row(children: [
                                   pw.Text(item.name,style: MBText),
                                   pw.Text(" "+item.Descirption)
                                 ])
                                ]
                              )

                          ),
                        ),

                        pw.SizedBox(height: 8),


                      ],
                    ),
                  );
                },
              )
          ),
          pw.SizedBox(height: 20),
          pw.Row(
              children: [
                pw.SizedBox(width: 10),
                pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child: pw.Text('Professional Experience',style: LBText),)
              ]
          ),
          pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child:  pw.Divider(thickness: 0.5,color: PdfColors.black),),
          pw.Container(
              constraints: const pw.BoxConstraints(maxWidth: 215),
              child: pw.ListView.builder(
                itemCount: newResumeModel.experience.length,
                itemBuilder: (context, index)
                {
                  final item = newResumeModel.experience[index];
                  return pw.Container(
                    margin: pw.EdgeInsets.symmetric(horizontal: 30),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(constraints: const pw.BoxConstraints(maxWidth: 450),child: pw.Row(children: [pw.Text(item.position,style: MBText),pw.Text(',',style: MBText),pw.Text(item.company,style: MBText)
                            ]
                            ),
                            ),

                            pw.Text('   ${item.from} - ${item.to}' ,style: MBText ),
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
                  );
                },
              )
          ),
          pw.SizedBox(height: 20),
          //education
          pw.Row(
              children: [
                pw.SizedBox(width: 10),
                pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child: pw.Text('Education',style: LBText),)
              ]
          ),
          pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child:  pw.Divider(thickness: 0.5,color: PdfColors.black),),

          pw.ListView.builder(
            itemCount: newResumeModel.education.length,
            itemBuilder: (context, index)
            {
              final item = newResumeModel.education[index];
              return pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),
                  child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(constraints: const pw.BoxConstraints(maxWidth: 450),child: pw.Text(item.major,style: MBText ),),
                        pw.Row(children: [ pw.Text('${item.from} ',style: MBText  ),
                          pw.Text(' - ${item.to}', style: MBText ),])
                      ]),

                  pw.Container(constraints: const pw.BoxConstraints(maxWidth: 200),child: pw.Text(item.schoolTitle,style: MBText ),),
                  pw.SizedBox(height: 2),

                  pw.SizedBox(height: 5),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment:pw.MainAxisAlignment.start,
                    children: [
                      pw.Column(children: [
                        pw.SizedBox(height: 4),
                        pw.Container(
                          width: 4,
                          height: 3,
                          child: pw.Image(Bdot2),
                        ),]),
                      pw.SizedBox(width: 5),
                      pw.Column(
                          children: [
                            pw.Container(constraints: const pw.BoxConstraints(maxWidth: 200),child:  pw.Text(item.major, ),)
                          ]) ],
                  ),

                  pw.SizedBox(height: 10),
                ],
              ));
            },
          ),

          pw.Row(
              children: [
                pw.SizedBox(width: 10),
                pw.Container(margin: pw.EdgeInsets.only(left: 30,right: 30,top: 20),child: pw.Text('Additional Information',style: LBText),)
              ]
          ),
          pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child:  pw.Divider(thickness: 0.5,color: PdfColors.black),),
pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child:pw.Row(
  crossAxisAlignment: pw.CrossAxisAlignment.start,
  mainAxisAlignment:pw.MainAxisAlignment.start,
  children: [
    if(newResumeModel.languages.isNotEmpty)
    pw.Column(children:
    [
      pw.SizedBox(height: 6),
      pw.Container(
        width: 4,
        height: 3,
        child: pw.Image(Bdot2),
      ),
    ]),
    pw.SizedBox(width: 5),
    pw.Column(
        children: [
          if(newResumeModel.languages.isNotEmpty)
          pw.Container(constraints: const pw.BoxConstraints(maxWidth: 200),child:  pw.Text('Languages: ',style: MBText ),)
        ]),
    pw.Container(
      width: double.infinity,
      child: pw.Wrap(
        direction: pw.Axis.horizontal,
        children: List.generate(
          newResumeModel.languages.length,
              (index) {
            final languages = newResumeModel.languages[index];
            return pw.Text(
              '${languages.language}${index < newResumeModel.languages.length - 1 ? ', ' : ''}',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 12),
            );
          },
        ),
      ),
    ),
  ],
), ),
          pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 30),child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment:pw.MainAxisAlignment.start,children: [
                if(newResumeModel.certifications.isNotEmpty)
                pw.Column(children:
                [
                  pw.SizedBox(height: 6),
                  pw.Container(
                    width: 4,
                    height: 3,
                    child: pw.Image(Bdot2),
                  ),
                ]),
                pw.SizedBox(width: 5),
                pw.Column(
                    children: [
                      if(newResumeModel.certifications.isNotEmpty)
                      pw.Container(constraints: const pw.BoxConstraints(maxWidth: 200),
                        child:  pw.Text('Certifications: ',style: MBText ),)
                    ]),
                pw.Container(
                  width: double.infinity,
                  child: pw.Wrap(
                    direction: pw.Axis.horizontal,
                    children: List.generate(
                      newResumeModel.certifications.length,
                          (index) {
                        final certifications = newResumeModel.certifications[index];
                        return pw.Text(
                          '${certifications.certificationName}${index < newResumeModel.certifications.length - 1 ? ', ' : ''}',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                ),
              ]),)


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




