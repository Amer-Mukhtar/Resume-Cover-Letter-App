


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_view_model.dart';

import '../../../Models/model_resume.dart';
import '../../../Utility/widgets/TextFieldHintRed.dart';

class ContactScreen extends StatefulWidget {
  final ResumeModel newResumeMdoel;
  final index;
  Color borderColorContact;
  ContactScreen({super.key, required this.newResumeMdoel, this.index,required this.borderColorContact});


  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  TextEditingController textControllerEmail=TextEditingController();
  TextEditingController textControllerPhoneNumber=TextEditingController();
  TextEditingController textControllerWebsite=TextEditingController();
  TextEditingController textControllerAddress=TextEditingController();
  late ResumeViewModelProvider resumeViewModel;

  void initState(){
    super.initState();



    textControllerEmail =TextEditingController(text: widget.newResumeMdoel.contact?.email);
    textControllerEmail.addListener(() {
      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
      resumeViewModel.AddEmail(widget.index, textControllerEmail.text);
      resumeViewModel.updateFullness(widget.newResumeMdoel);
    });


    textControllerPhoneNumber =TextEditingController(text: widget.newResumeMdoel.contact?.phoneNumber);
    textControllerPhoneNumber.addListener(() {
      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
      resumeViewModel.AddPhone(widget.index, textControllerPhoneNumber.text);
      resumeViewModel.updateFullness(widget.newResumeMdoel);});

    textControllerWebsite =TextEditingController(text: widget.newResumeMdoel.contact?.website);
    textControllerWebsite.addListener(() {
      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
      resumeViewModel.AddWebsite(widget.index, textControllerWebsite.text);
      resumeViewModel.updateFullness(widget.newResumeMdoel);});


    textControllerAddress =TextEditingController(text: widget.newResumeMdoel.contact?.address);
    textControllerAddress.addListener(()
    {
      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
      resumeViewModel.AddAddress(widget.index, textControllerAddress.text);
      resumeViewModel.updateFullness(widget.newResumeMdoel);});




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),

                //Email Address
                CustomTextFieldHintRed(
                  labelText: 'Email Address',
                  KeyboardType: TextInputType.emailAddress,
                  controller: textControllerEmail,
                  hintText: 'vialik@gmail.com',
                  onChanged: (value) {
                    resumeViewModel.updateFullness(widget.newResumeMdoel);
                  }, color: widget.borderColorContact,
                ),



                //Phone Number
                CustomTextFieldHintRed(
                  labelText: 'Phone Number',
                  KeyboardType: TextInputType.phone,
                  controller: textControllerPhoneNumber,
                  hintText: '+77234233254325',
                  onChanged: (value) {
                    resumeViewModel.updateFullness(widget.newResumeMdoel);
                  }, color: widget.borderColorContact,
                ),


                //Personal Website
                CustomTextFieldHintRed(
                  labelText: 'Website',
                  KeyboardType: TextInputType.url,
                  controller: textControllerWebsite,
                  hintText: 'vitalik.com',
                  onChanged: (value) {
                    resumeViewModel.updateFullness(widget.newResumeMdoel);
                  }, color: widget.borderColorContact,
                ),


                //Address
                CustomTextFieldHintRed(
                  labelText: 'Address',
                  KeyboardType: TextInputType.streetAddress,
                  controller: textControllerAddress,
                  hintText: 'Los Angeles, USA',
                  onChanged: (value) {
                    resumeViewModel.updateFullness(widget.newResumeMdoel);
                  }, color: widget.borderColorContact,
                ),
              ],),
          ),
        )
    );
  }
}
