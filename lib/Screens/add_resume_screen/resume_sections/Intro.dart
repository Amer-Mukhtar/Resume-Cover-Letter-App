import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_view_model.dart';


import '../../../Models/model_resume.dart';
import '../../../Utility/widgets/TextFieldHintRed.dart';
import '../../../Utility/widgets/TextFieldValidator.dart';
import '../../../Utility/widgets/TextfieldSummary.dart';
import '../../../Utility/widgets/additionalOptionsButton.dart';

class IntroScreen extends StatefulWidget {

  final ResumeModel newResumeMdoel;
  final index;
  Color borderColorIntro;
   IntroScreen({super.key, required this.newResumeMdoel, this.index,required this.borderColorIntro});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
{
  TextEditingController textControllerFirstName=TextEditingController();
  TextEditingController textControllerLastName=TextEditingController();
  TextEditingController textControllerSummary=TextEditingController();
  late ResumeViewModelProvider resumeViewModel;
  @override
  void initState() {
    super.initState();
    resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
    textControllerFirstName =TextEditingController(text: widget.newResumeMdoel.intro?.firstName);
    textControllerFirstName.addListener(()
    {
      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
      resumeViewModel.AddFirstName(widget.index, textControllerFirstName.text);
      resumeViewModel.updateFullness(widget.newResumeMdoel);});



    textControllerLastName =TextEditingController(text: widget.newResumeMdoel.intro?.lastName);
    textControllerLastName.addListener(()
    {
      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
      resumeViewModel.AddLastName(widget.index, textControllerLastName.text);
      resumeViewModel.updateFullness(widget.newResumeMdoel);
    });


    textControllerSummary =TextEditingController(text: widget.newResumeMdoel.intro?.summary);
    textControllerSummary.addListener(()
    {
      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
      resumeViewModel.AddSummaryName(widget.index, textControllerSummary.text);
      resumeViewModel.updateFullness(widget.newResumeMdoel);
    });
  }


  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.black,
        body:SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Center(
                  child: Stack(
                    children: [
                      widget.newResumeMdoel.profile_image == null
                          ? Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.lerp(Colors.black, Colors.white, 0.3),//reload
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer border
                            Container(
                              width: 95.0,
                              height: 95.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                            ),
                            // Inner border
                            Container(
                              width: 90.0,
                              height: 90.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.lerp(Colors.black, Colors.white, 0.5),//
                              ),
                            ),
                            // Profile CircleAvatar
                            CircleAvatar(
                              backgroundColor: Color.lerp(Colors.black, Colors.white, 0.3),
                              radius: 43.0,
                              child: Icon(Icons.person, size: 80.0, color: Color.lerp(Colors.black, Colors.white, 0.25)),//
                            ),
                          ],
                        ),
                      )
                          : CircleAvatar(
                        radius: 50,
                        backgroundImage: MemoryImage(widget.newResumeMdoel.profile_image!),

                      ),
                      Positioned(
                        left: 70,
                        top: 70,
                        child: GestureDetector(
                          onTap: () {
                            imageSheet();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              CupertinoIcons.plus,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),




                //First Name
                CustomTextFieldHintRed(
                  labelText: 'First Name',
                  controller: textControllerFirstName,
                  KeyboardType: TextInputType.text,
                  hintText: 'Vitalik',
                  onChanged: (value) {
                    resumeViewModel.updateFullness(widget.newResumeMdoel);
                  }, color: widget.borderColorIntro,
                ),

                //Last name
                CustomTextFieldHintRed(
                  labelText: 'Last Name',
                  KeyboardType: TextInputType.text,
                  controller: textControllerLastName,
                  hintText: 'William',
                  onChanged: (value) {
                    resumeViewModel.updateFullness(widget.newResumeMdoel);
                  }, color: widget.borderColorIntro,
                ),



                CustomSummaryField(
                  height: 80.0,
                  labelText: 'Summary',
                  controller: textControllerSummary,
                  hintText: 'UI Designer based in LA',
                  onChanged: (value) {
                    resumeViewModel.updateFullness(widget.newResumeMdoel);
                  }, borderColor: widget.borderColorIntro,
                ),






              ],),
          ),
        )
    );
  }
  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      final imageBytes = await returnedImage.readAsBytes(); // Convert to Uint8List

      setState(() {
        final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
        resumeViewModel.setProfileImage(imageBytes, widget.index); // Pass Uint8List
        print('$widget.index');
        resumeViewModel.updateFullness(widget.newResumeMdoel);
      });
      Navigator.pop(context);
    }
  }
  Future _pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      final imageBytes = await returnedImage.readAsBytes();

      setState(() {
        final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);

        resumeViewModel.setProfileImage(imageBytes, widget.index); // Pass Uint8List
        resumeViewModel.updateFullness(widget.newResumeMdoel);
      });
    }
    Navigator.pop(context);
  }
  Future imageSheet()
  {
    return showModalBottomSheet(context: context,
        builder:(BuildContext context)
        {
          return FractionallySizedBox(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF454545),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(onPressed: ()
                  {
                    _pickImageFromGallery();

                  }
                    ,style: TextButton.styleFrom(padding: EdgeInsets.zero,) ,child: const ListTile(leading: Icon(FontAwesomeIcons.image,color: Colors.white,),title: Text('Gallery',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),),

                  const Divider(height: 1,color: Colors.white24,),

                  TextButton(onPressed: (){
                    _pickImageFromCamera();
                  },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero,),
                    child: const ListTile(leading: Icon(CupertinoIcons.camera,color: Colors.white,),title: Text('Camera',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),),
                ],
              ),
            ),
          );

        }
    );
  }
}
