import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resume_maker/Models/model_resume.dart';

List timeline_List=[{
  'title':'Borcelle Studio',
  'subtitle':'Marketing Manager & Specialist',
  'time':'2030-PRESENT'
}];

List timeline_exp=[{
  'exp':'Developed and maintained relationships with partners,agencies and vendors to support marketing intitiatives',
  'exp':'Developed and maintained relationships with partners,agencies and vendors to support marketing intitiatives',

}];


Future<void> createPdf_blue(ResumeModel newResumeMdoel) async {

  Uint8List? _dot;
  Uint8List? _profile;
  Uint8List? _email;
  Uint8List? _www;
  Uint8List? _location;
  Uint8List? _phone;
  Uint8List? _dot_black;

  pw.TextStyle sText = const pw.TextStyle(color: PdfColors.white, fontSize: 10);
  pw.TextStyle sbText = pw.TextStyle(color: PdfColors.white, fontSize: 10,fontWeight: pw.FontWeight.bold);
  pw.TextStyle bText=pw.TextStyle(color: PdfColors.grey900,fontWeight: pw.FontWeight.bold,fontSize: 10);
  pw.TextStyle b2Text=const pw.TextStyle(color: PdfColors.grey800,fontSize: 12);

  pw.TextStyle lText = pw.TextStyle(color: PdfColors.white, fontSize: 20, fontWeight: pw.FontWeight.bold);

  pw.TextStyle rsText = const pw.TextStyle(color: PdfColor.fromInt(0xFF163852), fontSize: 10);
  pw.TextStyle rsbText = pw.TextStyle(color: const PdfColor.fromInt(0xFF163852), fontSize: 10,fontWeight: pw.FontWeight.bold);

  pw.TextStyle rlText = pw.TextStyle(color: const PdfColor.fromInt(0xFF163852), fontSize: 20, fontWeight: pw.FontWeight.bold);


  final ByteData dot = await rootBundle.load('assets/images/dot.png');
  _dot = dot.buffer.asUint8List();

  final ByteData Bdot = await rootBundle.load('assets/images/dot_black.png');
  _dot_black = Bdot.buffer.asUint8List();

  final ByteData profile = await rootBundle.load('assets/images/profile.png');
  _profile = profile.buffer.asUint8List();

  final ByteData www = await rootBundle.load('assets/images/www.png');
  _www = www.buffer.asUint8List();

  final ByteData phone = await rootBundle.load('assets/images/phone.png');
  _phone = phone.buffer.asUint8List();

  final ByteData location = await rootBundle.load('assets/images/location.png');
  _location = location.buffer.asUint8List();

  final ByteData email = await rootBundle.load('assets/images/email.png');
  _email = email.buffer.asUint8List();

  if (_dot == null || _profile == null) {
    return;
  }

  final pdf = pw.Document();

  final DotImage = pw.MemoryImage(_dot!);
  final ProfileImage = pw.MemoryImage(_profile!);

  final emailImage = pw.MemoryImage(_email!);
  final phoneImage = pw.MemoryImage(_phone!);
  final wwwImage = pw.MemoryImage(_www!);
  final locationImage = pw.MemoryImage(_location!);
  final Bdot2 = pw.MemoryImage(_dot_black!);


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
          pw.Container(child:
          pw.Partitions(children:
          [
            pw.Partition
              (
                child:pw.Container(
                  padding: pw.EdgeInsets.only(left: 20,top: 20,bottom: 20),
                  margin: pw.EdgeInsets.only(right: 20),
                  height: 841,
                  color: PdfColor.fromInt(0xFF163852),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(children:
                      [
                        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center,children:
                        [pw.SizedBox(width: 40,),
                          pw.Center(
                            child: newResumeMdoel.profile_image != null
                                ? pw.Container(
                              padding: pw.EdgeInsets.all(5),
                              decoration: pw.BoxDecoration(
                                color: PdfColors.white,
                                borderRadius: pw.BorderRadius.circular(65), // Adjusted for the outer container
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
                                        File(newResumeMdoel.profile_image!.path).readAsBytesSync(),
                                      ),
                                      fit: pw.BoxFit.cover, // Ensure the image covers the oval
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
                            ),  // Hides the container if no image is provided
                          )

                        ]
                        )
                      ]
                      ),
                      pw.SizedBox(height: 20),

                      ///Contact/////////////


                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            ///contact
                            pw.Text('Contact', style: lText),
                          ]),
                      pw.Container(
                          width: 190,
                          height: 2,
                          color: PdfColors.white),
                      pw.Row(children: [pw.Container(width: 14,height: 12,child:pw.Image(phoneImage,),),
                        ///phone number
                        pw.Text('  ${newResumeMdoel.contact!.phoneNumber}', style: sText),
                      ]),
                      pw.Row(children: [
                        pw.Container(width: 12,height: 10,child:pw.Image(emailImage,),),
                        pw.Text('  ${newResumeMdoel.contact!.email}', style: sText),
                      ]),
                      pw.Row(children: [
                        pw.Container(width: 14,height: 12,child:pw.Image(locationImage,),),
                        pw.Text('  ${newResumeMdoel.contact!.address}', style: sText),
                      ]),
                      pw.Row(children:
                      [pw.Container(width: 16,height: 14,child:pw.Image(wwwImage,),),
                        pw.Text('  ${newResumeMdoel.contact!.website}', style: sText),
                      ]
                      ),

                      pw.SizedBox(height: 10),
// Education
                      pw.Text('Education', style: lText),
                      pw.Container(
                        width: 190,
                        height: 2,
                        color: PdfColors.white,
                      ),
                      pw.ListView.builder(
                        itemCount: newResumeMdoel.education.length,
                        itemBuilder: (context, index) {
                          final item = newResumeMdoel.education[index];
                          return pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                             pw.Row(children: [
                               pw.Text('${item.from} ', style: sbText),
                               pw.Text(' - ${item.to}', style: sbText),
                             ]),
                              pw.Text('  ${item.schoolTitle}', style: sbText),
                              pw.Row(
                                children: [
                                  pw.Container(
                                    width: 8,
                                    height: 6,
                                    child: pw.Image(DotImage),
                                  ),
                                  pw.Text('  ${item.major}', style: sText),
                                ],
                              ),

                                pw.Row(
                                  children: [
                                    //pw.Container(width: 8, height: 6, child: pw.Image(DotImage),),
                                    //pw.Text(item., style: sText),
                                  ],
                                ),
                              pw.SizedBox(height: 10),  // Add spacing between items
                            ],
                          );
                        },
                      ),

                      pw.SizedBox(height: 10),

                      // Skills Heading
                      pw.Text('Skills', style: lText),
                      pw.Container(
                        width: 190,
                        height: 2,
                        color: PdfColors.white,
                      ),
                      pw.ListView.builder(
                        itemCount:newResumeMdoel.skills.length,
                        itemBuilder: (context, index) {

                          return pw.Row(
                            children: [
                              pw.Container(
                                width: 8,
                                height: 6,
                                child: pw.Image(DotImage),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(newResumeMdoel.skills[index].skillName, style: sText),
                            ],
                          );
                        },
                      ),


                      pw.SizedBox(height: 10),





                      // Languages heading /////////////////////////


                      pw.Text('Languages', style: lText),
                      pw.Container(
                        width: 190,
                        height: 2,
                        color: PdfColors.white,
                      ),
                      pw.ListView.builder(
                        itemCount: newResumeMdoel.languages.length,
                        itemBuilder: (context, index) {
                          return pw.Row(
                            children: [
                              pw.Container(
                                width: 8,
                                height: 6,
                                child: pw.Image(DotImage),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(newResumeMdoel.languages[index].language, style: sText),
                            ],
                          );
                        },
                      ),

                    ],
                  ),
                )
            ),





            ////right colum
            pw.Partition(child:
            pw.Container(
              width: 400,
              //margin: const pw.EdgeInsets.all(20),
              //padding: pw.EdgeInsets.only(right: 20),
              color: PdfColors.white,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                //mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.Container(
                      child: pw.Container(
                        margin: pw.EdgeInsets.only(left: 25),
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 40),
                            pw.Row(children: [
                              pw.Text(newResumeMdoel.intro!.firstName, style: pw.TextStyle(fontSize: 26,color: PdfColors.grey800,fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(width: 5),
                              pw.Text(newResumeMdoel.intro!.lastName, style: const pw.TextStyle(fontSize: 26,color: PdfColor.fromInt(0xFF163852))),
                            ]),
                            pw.Row(children: [
                              pw.Text(newResumeMdoel.job, style: const pw.TextStyle(fontSize: 12,color: PdfColors.grey600)),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                margin: const pw.EdgeInsets.only(top: 5),
                                width: 50,
                                height: 2,
                                color: const PdfColor.fromInt(0xFF163852),
                              ),
                            ]),
                          ],
                        ),
                      )
                  ),
                  pw.SizedBox(height: 20),
                  pw.Row(children: [
                    pw.Text('Profile', style: rlText)
                  ]),
                  pw.Container(
                      width: 315,
                      height: 2,
                      color: const PdfColor.fromInt(0xFF163852)),
                  pw.Container(
                      margin: const pw.EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                      constraints: const pw.BoxConstraints(maxWidth: 280),
                      child: pw.Flexible(child: pw.Text(newResumeMdoel.intro!.summary,
                        style: b2Text,
                      ),
                      )
                  ),

//////// Work Experience/////////////////////////////////////
                  pw.Row(children:
                  [
                    pw.Text('Work Experience', style: rlText)
                  ]
                  ),
                  pw.Container
                    (
                      width: 315,
                      height: 2,
                      color: const PdfColor.fromInt(0xFF163852)
                  ),
                  pw.SizedBox(height:10),

////Work Experience/////////
                  pw.Container(
                      margin: pw.EdgeInsets.only(right: 20),
                      constraints: pw.BoxConstraints(maxWidth: 215),
                      child: pw.ListView.builder(
                        itemCount: newResumeMdoel.experience.length,
                        itemBuilder: (context, index) {
                          final item = newResumeMdoel.experience[index];
                          int baseHeight = 50;
                          double descriptionLines = newResumeMdoel.experience
                              .where((desc) => desc.company == item.company).length * 2.8;
                          int descrip = descriptionLines.toInt();

                          double lineHeight = (baseHeight + (descrip) * 10);
                          print('$lineHeight');
                          int linescount =0;
                          return pw.Container(


                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                        padding: const pw.EdgeInsets.all(0),
                                        margin: pw.EdgeInsets.all(0),
                                        width: 6,
                                        height: 6,

                                        decoration: pw.BoxDecoration(color: PdfColors.black,shape: pw.BoxShape.circle)
                                    ),
                                    pw.Container(
                                      margin: const pw.EdgeInsets.all(0),
                                      padding: const pw.EdgeInsets.symmetric(horizontal: 0),
                                      width: 1,
                                      height: lineHeight,
                                      color: PdfColors.black,
                                    ),
                                  ],
                                ),
                                pw.SizedBox(width: 6),
                                pw.Container(
                                  margin: pw.EdgeInsets.only(left: 5),
                                  padding: pw.EdgeInsets.only(top: -15),
                                  child: pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                        children: [
                                          pw.Text(item.company, style: bText),
                                          pw.SizedBox(width: 100),
                                          pw.Text('${item.from} - ${item.to}', style: b2Text),
                                        ],
                                      ),

                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Container(
                                            child: pw.Text(item.position, style: b2Text, textAlign: pw.TextAlign.left),
                                          ),
                                        ],
                                      ),
                                      pw.SizedBox(height: 10),
                                      pw.Container(

                                        child: pw.ListView.builder(
                                          itemCount: newResumeMdoel.experience.length,
                                          itemBuilder: (context, index) {
                                            final item=newResumeMdoel.experience[index];
                                             return pw.Row(
                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                children:
                                                [
                                                  pw.Column(children: [
                                                    pw.SizedBox(height: 5),
                                                    pw.Container(
                                                      width: 4,
                                                      height: 8,
                                                      child: pw.Image(Bdot2),
                                                    ),
                                                  ]
                                                  ),
                                                  pw.SizedBox(width: 5,height: 0),
                                                  pw.Container(
                                                      constraints: pw.BoxConstraints(maxWidth: 260),
                                                      child: pw.Flexible(child: pw.Text(
                                                        item.description,
                                                        style: b2Text,
                                                      ),)
                                                  ),

                                                ],
                                              );

                                          },
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

                  pw.SizedBox(height:20),


// Reference
                  pw.Row(children:
                  [
                    pw.Text('Certifications', style: rlText)
                  ]),
                  pw.Container(
                      width: 315,
                      height: 2,
                      color: const PdfColor.fromInt(0xFF163852)
                  ),
                  pw.SizedBox(height:  10),
                  pw.ListView.builder(
                    itemCount: newResumeMdoel.certifications.length,
                    itemBuilder: (context, index) {
                      final item=newResumeMdoel.certifications[index];
                      return pw.Row(
                        children: [
                          pw.Container(
                            width: 8,
                            height: 6,
                            child: pw.Image(Bdot2),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(item.certificationName, style: b2Text),
                        ],
                      );
                    },
                  ),


                ],
              ),
            ),
            )

          ]
          )
          )];
      },
    ),
  );




  final output = await getTemporaryDirectory();
  final file = File("${output.path}/example.pdf");
  await file.writeAsBytes(await pdf.save());
  await OpenFile.open(file.path);
}




