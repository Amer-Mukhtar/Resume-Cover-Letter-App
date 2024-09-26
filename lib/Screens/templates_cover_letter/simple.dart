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
import 'package:resume_maker/Models/model_cover.dart';
import '../../Models/model_resume.dart';
import '../add_resume_screen/resume_3.dart';
import '../add_resume_screen/resume_view_model.dart';




Future<void> createPdf_simple_CL(CoverLetterModel Clmodel,String action,BuildContext context) async
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
         pw.Container(
             margin: pw.EdgeInsets.only(left: 30,right: 30,top: 50,bottom: 10),child: pw.Column(
           crossAxisAlignment: pw.CrossAxisAlignment.start,
           children: [
             pw.Container(child: pw.Text(Clmodel.firstName.toString().toUpperCase(),style: pw.TextStyle(fontSize: 50))),

             pw.Container(child: pw.Text(Clmodel.lastName.toString().toUpperCase(),style: pw.TextStyle(fontSize: 50))),
           ]
         )),
          pw.Container(margin: pw.EdgeInsets.symmetric(horizontal: 35,vertical: 20),
            child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,children: [

            pw.Container(child: pw.Text(Clmodel.email.toString(),style: pw.TextStyle(fontSize: 20))),

            pw.Container(child: pw.Text(Clmodel.phoneNumber.toString(),style: pw.TextStyle(fontSize: 20))),

            pw.Container(child: pw.Text(Clmodel.address.toString(),style: pw.TextStyle(fontSize: 20))),

          ]),),
          pw.Center(child: pw.Container(
              width: 515,height: 2,color: PdfColors.black
          )),
         pw.Container(
           margin: pw.EdgeInsets.symmetric(horizontal: 30,vertical: 25),
             constraints: pw.BoxConstraints(maxWidth: 515),
             child: pw.Text(Clmodel.summary.toString(),style: pw.TextStyle(fontSize: 16))
         ),

          pw.Container(
              margin: pw.EdgeInsets.symmetric(horizontal: 35),
              child: pw.Text("Best Regards",style: pw.TextStyle(fontSize: 16))
          ),
          pw.Container(
              margin: pw.EdgeInsets.symmetric(horizontal: 35),
              child: pw.Text(Clmodel.firstName.toString()+" "+Clmodel.lastName.toString(),
                  style: pw.TextStyle(fontSize: 16,color: PdfColors.grey800))
          ),

        ];
      },
    ),
  );



  final pdfData = await pdf.save();

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/coverletter.pdf");
 // newResumeModel.resume = file;
  await OpenFile.open("${output.path}/coverletter.pdf");
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
     // resumeViewModel.setResumeSnapshot(uint8list,newResumeModel);
      await page.close();
      await pdfDoc.close();
      Navigator.pop(context);

    } else {
      print('Failed to decode image.');
    }
  }
  else
  {
    throw ArgumentError('Invalid action: $action');
  }

}




