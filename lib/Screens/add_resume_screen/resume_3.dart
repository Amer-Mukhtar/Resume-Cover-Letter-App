import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../Models/model_resume.dart';

class Template_Preview extends StatefulWidget {

  ResumeModel resumeModel;
  Template_Preview({super.key,required this.resumeModel});

  @override
  State<Template_Preview> createState() => _Template_PreviewState();
}

class _Template_PreviewState extends State<Template_Preview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        height: 100,
        color: Color.lerp(Colors.black,Colors.white,0.1),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () {

              share();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  'Share ',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 16),
                ),
                SizedBox(width: 5),
                Icon(CupertinoIcons.share, color: Colors.white),

              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color.lerp(Colors.black,Colors.white,0),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  spreadRadius: 14,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            margin: const EdgeInsets.all(16.0),
            child: widget.resumeModel.resume_snapshot != null
                ? Image.memory(
              widget.resumeModel.resume_snapshot!,
              fit: BoxFit.cover, // Adjust the fit as needed
            )
                : const Center(
              child: Text(
                'No Image Available',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

        ),
      ),
    );
  }
  void share() async {
    final filePath = widget.resumeModel.resume?.path;
    if (filePath != null && File(filePath).existsSync()) {
      final xfile = XFile(filePath);
      await Share.shareXFiles([xfile], text: 'Check out my resume!');
    } else {
      print('File does not exist');
    }
  }


}

