
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:resume_maker/Models/model_resume.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_view_model.dart';
import '../../Utility/widgets/AlertSnackBar.dart';
import '../../Utility/widgets/TextFieldHintRed.dart';
import '../../Utility/widgets/TextFieldValidator.dart';
import '../../Utility/widgets/TextfieldSummary.dart';
import '../../Utility/widgets/additionalOptionsButton.dart';
import '../../Utility/widgets/reorderButton.dart';
import '../../Utility/widgets/textFieldSummaryNON.dart';
import '../templates/black_white.dart';
import '../templates/blue.dart';


String _errorText='';

List photo= [
  {'image':'assets/images/template1.png',
    'title':'Black & White'},
  {'image':'assets/images/template2.png',
    'title': 'Black & Blue'},
];
Color background=Colors.black;
Color text=Colors.white;


class Resume_Details extends StatefulWidget
{
  final ResumeModel newResumeMdoel;
  final index;
   const Resume_Details({super.key, required this.newResumeMdoel, this.index});

  @override
  State<Resume_Details> createState() => _Resume_DetailsState();
}

class _Resume_DetailsState extends State<Resume_Details> with SingleTickerProviderStateMixin  {
  late ResumeViewModelProvider resumeViewModel;


  late TabController _tabController;
// Intro
   TextEditingController textControllerFirstName=TextEditingController();
   TextEditingController textControllerLastName=TextEditingController();
   TextEditingController textControllerSummary=TextEditingController();

// Contact
   TextEditingController textControllerEmail=TextEditingController();
   TextEditingController textControllerPhoneNumber=TextEditingController();
   TextEditingController textControllerWebsite=TextEditingController();
   TextEditingController textControllerAddress=TextEditingController();

// Experience
   TextEditingController textControllerCompany=TextEditingController();
   TextEditingController textControllerPosition=TextEditingController();
   TextEditingController textControllerLocation=TextEditingController();
   TextEditingController textControllerEFrom=TextEditingController();
   TextEditingController textControllerETo=TextEditingController();
   TextEditingController textControllerDescription=TextEditingController();

// Education
   TextEditingController textControllerSchoolTitle=TextEditingController();
   TextEditingController textControllerMajor=TextEditingController();
   TextEditingController textControllerEduFrom=TextEditingController();
   TextEditingController textControllerEduTo=TextEditingController();

// Skill
   TextEditingController textControllerSkillName=TextEditingController();

// Language
   TextEditingController textControllerLanguage=TextEditingController();
   TextEditingController textControllerLevel=TextEditingController();

// Certification
   TextEditingController textControllerCertificationTitle=TextEditingController();


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



    textControllerEmail =TextEditingController(text: widget.newResumeMdoel.contact?.address);
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


    textControllerAddress =TextEditingController(text: widget.newResumeMdoel.contact?.email);
    textControllerAddress.addListener(()
    {
    final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
      resumeViewModel.AddAddress(widget.index, textControllerAddress.text);
    resumeViewModel.updateFullness(widget.newResumeMdoel);});






    _tabController = TabController(length: 9, vsync: this);
   // _tabController.addListener(_handleTabChange);
 }
 late final ResumeViewModelProvider view;

  @override
  void dispose() {
    textControllerCompany.dispose();
    textControllerPosition.dispose();
    textControllerLocation.dispose();
    textControllerEFrom.dispose();
    textControllerETo.dispose();
    textControllerDescription.dispose();
    textControllerSchoolTitle.dispose();
    textControllerMajor.dispose();
    textControllerEduFrom.dispose();
    textControllerEduTo.dispose();
    textControllerSkillName.dispose();
    textControllerLanguage.dispose();
    textControllerLevel.dispose();
    textControllerCertificationTitle.dispose();
    _tabController.dispose();
    super.dispose();
  }


  Color _borderColorIntro = Colors.grey;
  Color _borderColorContact = Colors.grey;
  Color? _profileAvatarOuterBorder = Color.lerp(Colors.black, Colors.white, 0.3);

  void _handleTabChange(int index) {
    print('herwe');
    if (index == 0)
    {
      print('1');
      setState(()
      {
        _borderColorIntro = Colors.red;
        ScaffoldMessenger.of(context).showSnackBar(
          AlertSnackBar('Required fields cannot be left empty.',Colors.red,Colors.white),
        );

      });

      Future.delayed(Duration(seconds: 3), () {
        setState(()
        {
          _borderColorIntro = Colors.grey;
        });
      });
    }
    else if (index == 1)
    {

      print('1');
      setState(()
      {
        _borderColorContact = Colors.red;
        ScaffoldMessenger.of(context).showSnackBar(
          AlertSnackBar('Required fields cannot be left empty.',Colors.red,Colors.white),
        );
      });

      Future.delayed(Duration(seconds: 3), () {
        setState(()
        {
          _borderColorContact = Colors.grey;
        });
      });
    }
    else if(index==5)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          AlertSnackBar('Skill cannot be left empty.',Colors.red,Colors.white),
        );
      }
    else if(index==6)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        AlertSnackBar('Language cannot be left empty.',Colors.red,Colors.white),
      );
    }
  }
  File ? _select;
  bool Cdate=false;

  @override
  Widget build(BuildContext context)
  {

    print('here');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Personal Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10,right: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white60),
            ),
            child: IconButton(onPressed: (){setState(()
            {
              Navigator.pop(context);
            });},
              icon: const Icon(CupertinoIcons.arrow_left,
                color: Colors.white,
                size: 15,),
            ),
          ),
        ),
      ),
      body: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          height: 100,
          color: Colors.black87,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(10)),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 15),
              ),
              onPressed: () {
                _tabController.animateTo((_tabController.index + 1) % 9);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: const Icon(CupertinoIcons.arrow_right,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            child: DefaultTabController(
              length: 9,
              child: Column(children:
              [
                TabBar(
                    controller:_tabController,
                  isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorColor: Colors.blueAccent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent),
                    unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15),
                    tabs: [
                      Tab(
                        child: Container(
                          child: const Row(children:
                          [
                            Icon(FontAwesomeIcons.addressCard,size: 20,),
                            SizedBox(width: 10,),
                            Text('Intro')
                          ],),
                        ),
                      ),//intro
                      Tab(
                        child: Container(
                          child: const Row(children: [
                            Icon(FontAwesomeIcons.envelope,size: 20,),
                            SizedBox(width: 10,),
                            Text('Contact')
                          ],),
                        ),
                      ),//Contact
                      Tab(
                        child: Container(
                          child: const Row(children: [
                            Icon(FontAwesomeIcons.graduationCap,size: 20,),
                            SizedBox(width: 10,),
                            Text('Education')
                          ],),
                        ),
                      ),//Education
                      Tab(
                        child: Container(
                          child: const Row(children: [
                            Icon(FontAwesomeIcons.briefcase,size: 20,),
                            SizedBox(width: 10,),
                            Text('Experience')
                          ],
                          ),
                        ),
                      ),//Experience
                      Tab(
                        child: Container(
                          child: const Row(children: [
                            Icon(FontAwesomeIcons.addressCard,size: 20,),
                            SizedBox(width: 10,),
                            Text('Certification')
                          ],),
                        ),
                      ),//Certification
                      Tab(
                        child: Container(
                          child: const Row(children: [
                            Icon(FontAwesomeIcons.addressCard,size: 20,),
                            SizedBox(width: 10,),
                            Text('Skill Higlight')
                          ],),
                        ),
                      ),//Skill Highlight
                      Tab(
                        child: Container(
                          child: const Row(children: [
                            Icon(FontAwesomeIcons.language,size: 20,),
                            SizedBox(width: 10,),
                            Text('Languages')
                          ],),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Row(children: [
                            Icon(CupertinoIcons.doc_circle,size: 20,),
                            SizedBox(width: 10,),
                            Text('Refrences')
                          ],),
                        ),
                      ),////Languages
                      Tab(
                        child: Container(
                          child: const Row(children: [
                            Icon(CupertinoIcons.doc,size: 20,),
                            SizedBox(width: 10,),
                            Text('Templates')
                          ],),
                        ),
                      ),//Templates


                    ]
                ),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children:
                    [
                      ///Intro
                      Scaffold(
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
                                            color: _profileAvatarOuterBorder,//reload
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
                                    }, color: _borderColorIntro,
                                  ),

                                  //Last name
                                  CustomTextFieldHintRed(
                                    labelText: 'Last Name',
                                    KeyboardType: TextInputType.text,
                                    controller: textControllerLastName,
                                    hintText: 'William',
                                    onChanged: (value) {
                                      resumeViewModel.updateFullness(widget.newResumeMdoel);
                                    }, color: _borderColorIntro,
                                  ),



                                  CustomSummaryField(
                                    height: 80.0,
                                    labelText: 'Summary',
                                    controller: textControllerSummary,
                                    hintText: 'UI Designer based in LA',
                                    onChanged: (value) {
                                      resumeViewModel.updateFullness(widget.newResumeMdoel);
                                    }, borderColor: _borderColorIntro,
                                  ),
                                ],),
                            ),
                          )
                      ),

                      ///Contact
                      Scaffold(
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
                                    }, color: _borderColorContact,
                                  ),



                                  //Phone Number
                                  CustomTextFieldHintRed(
                                    labelText: 'Phone Number',
                                    KeyboardType: TextInputType.phone,
                                    controller: textControllerPhoneNumber,
                                    hintText: '+77234233254325',
                                    onChanged: (value) {
                                      resumeViewModel.updateFullness(widget.newResumeMdoel);
                                    }, color: _borderColorContact,
                                  ),


                                  //Personal Website
                                  CustomTextFieldHintRed(
                                    labelText: 'Website',
                                    KeyboardType: TextInputType.url,
                                    controller: textControllerWebsite,
                                    hintText: 'vitalik.com',
                                    onChanged: (value) {
                                      resumeViewModel.updateFullness(widget.newResumeMdoel);
                                    }, color: _borderColorContact,
                                  ),


                                  //Address
                                  CustomTextFieldHintRed(
                                    labelText: 'Address',
                                    KeyboardType: TextInputType.streetAddress,
                                    controller: textControllerAddress,
                                    hintText: 'Los Angeles, USA',
                                    onChanged: (value) {
                                      resumeViewModel.updateFullness(widget.newResumeMdoel);
                                    }, color: _borderColorContact,
                                  ),




                                ],),
                            ),
                          )
                      ),

                      //Education
                      Scaffold(
                  floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                  floatingActionButton: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            EducationSheet();
                          });
                        },
                        icon: const Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  body:Container(
                    color: Colors.black,
                    child: widget.newResumeMdoel.education.isEmpty? Container(
                      width: double.infinity,
                      key: const ValueKey('empty'),
                      color: Colors.black,alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: const Icon(
                                FontAwesomeIcons.userGraduate,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No education added',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ) :Container(
                      color: Colors.black,
                      child: ReorderableListView(
                        onReorder: (int oldIndex, int newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            final item = widget.newResumeMdoel.education.removeAt(oldIndex);
                            widget.newResumeMdoel.education.insert(newIndex, item);
                                                  });
                        },
                        children: [

                            for (int index = 0; index < widget.newResumeMdoel.education.length; index++)
                              Container(
                                key: ValueKey(widget.newResumeMdoel.education[index].schoolTitle),
                                color: Colors.black,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.white24,
                                          width:1,

                                        ),),
                                      margin: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF454545),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(constraints: const BoxConstraints(maxWidth: 250),child: Text(
                                                  widget.newResumeMdoel.education[index].schoolTitle,
                                                  style: const TextStyle(color: Colors.white,),maxLines: 1,overflow: TextOverflow.ellipsis,
                                                ),),
                                                AdditonalOptions(onPressed: () { Education_dot(index); },)

                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Major',
                                                      style: TextStyle(color: Colors.white60, fontSize: 10),
                                                    ),
                                                    Container(constraints: const BoxConstraints(maxWidth: 250),child: Text(
                                                      widget.newResumeMdoel.education[index].major,
                                                      style: const TextStyle(color: Colors.white),
                                                      maxLines: 1,overflow: TextOverflow.ellipsis,
                                                    ),)

                                                  ],
                                                ),
                                                reorderButton(context)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),

                      //Experience
                      Scaffold(
                    floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                    floatingActionButton: Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              experienceSheet();
                            });
                          },
                          icon: const Icon(
                            CupertinoIcons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    body: Container(
                      color: Colors.black,
                      child: widget.newResumeMdoel.experience.isEmpty
                          ? Container(
                        width: double.infinity,color: Colors.black,
                        key: const ValueKey('empty'),alignment: Alignment.center,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.blue[900],
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.briefcase,
                                  color: Colors.blue,
                                  size: 80,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'No experience added',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      )
                          : ReorderableListView(

                        onReorder: (int oldIndex, int newIndex) {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          setState(() {
                            final item = widget.newResumeMdoel.experience.removeAt(oldIndex);
                            widget.newResumeMdoel.experience.insert(newIndex, item);
                          });
                        },
                        children: [
                          for (int index = 0; index < widget.newResumeMdoel.experience.length; index++)
                            Container(
                              key: ValueKey('experience_$index'),
                              color: Colors.black,
                              child: Column(
                                children: [

                                  const SizedBox(height: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.white24,
                                        width:1,
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF454545),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                 Container(constraints: const BoxConstraints(maxWidth: 250),
                                                   child:  Text(
                                                   widget.newResumeMdoel.experience[index].company ?? '',
                                                   style: const TextStyle(color: Colors.white),
                                                   maxLines: 1,overflow: TextOverflow.ellipsis,
                                                 ),),
                                                ],
                                              ),
                                              AdditonalOptions(onPressed: () { experience_dot(index); },)

                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Position',
                                                    style: TextStyle(color: Colors.white60, fontSize: 10),
                                                  ),
                                                  Row(
                                                    children: [

                                                      Container(constraints: const BoxConstraints(maxWidth: 250),child:Text(
                                                        widget.newResumeMdoel.experience[index].position ?? '',
                                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                                      maxLines: 1,overflow:TextOverflow.ellipsis
                                                      ),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              reorderButton(context)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),

                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Description',
                                                  style: TextStyle(color: Colors.white60, fontSize: 10,),
                                                ),
                                                Text(
                                                  widget.newResumeMdoel.experience[index].description ?? ' ',
                                                  style: const TextStyle(color: Colors.white),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                )

                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                  ,
                      //Certification
                      Scaffold(
                        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                        floatingActionButton: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                certificationSheet();
                              },
                              icon: const Icon(
                                CupertinoIcons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        body: Container(
                          color: Colors.black,
                          child: widget.newResumeMdoel.certifications.isEmpty?
                          Container(
                            width: double.infinity,
                            key: const ValueKey('empty'),
                           alignment: Alignment.center,
                            color: Colors.black,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[900],
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.briefcase,
                                      color: Colors.blue,
                                      size: 80,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'No certifications added',
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ) :ReorderableListView(
                            onReorder: (int oldIndex, int newIndex) {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              setState(() {
                                final item = widget.newResumeMdoel.certifications.removeAt(oldIndex);
                                widget.newResumeMdoel.certifications.insert(newIndex, item);
                              });
                            },
                            children: [

                                for (int index = 0; index < widget.newResumeMdoel.certifications.length; index++)
                                  Container(
                                    key: ValueKey('certification_$index'), // Unique key based on index
                                    color: Colors.black,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        Container(

                                          margin: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white24,
                                                      width:1,
                                                    ),
                                                  color: const Color(0xFF454545),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(constraints: const BoxConstraints(maxWidth: 250),child: Text(
                                                      widget.newResumeMdoel.certifications[index].certificationName ?? '',
                                                      style: const TextStyle(color: Colors.white),
                                                      maxLines: 1,overflow: TextOverflow.ellipsis,
                                                    ),),
                                                    AdditonalOptions(onPressed: () { certification_dot(index); },)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),

                      //Skill Highlight
                      Scaffold(
                  floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                  floatingActionButton: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          SkillSheet(); // Pass the viewModel here
                        },
                        icon: const Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  body:Container(
                    color: Colors.black,
                    child: widget.newResumeMdoel.skills.isEmpty ?
                    Container(
                    height: MediaQuery.of(context).size.height,
                                  color: Colors.black,
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  key: const ValueKey('empty'),
                                  margin: const EdgeInsets.only(top: 0),
                                  child: Align( // Use Align to center the Column
                                    alignment: Alignment.center,
                                    child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Ensure the column sizes to its children
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.addressCard,
                            color: Colors.blue,
                            size: 80,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'No Skills added',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                                    ),
                                  ),
                                ) : ReorderableListView(
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final item = widget.newResumeMdoel.skills.removeAt(oldIndex);
                          widget.newResumeMdoel.skills.insert(newIndex, item);
                        });
                      },
                      children: <Widget>[



                          for (int index = 0; index < widget.newResumeMdoel.skills.length; index++)
                            Container(
                              key: ValueKey('language_$index'), // Unique key based on index
                              color: Colors.black,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(border: Border.all(
                                      color: Colors.white24,
                                      width:1,
                                    ),borderRadius: BorderRadius.circular(20)
                                    ),
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: const BoxDecoration(

                                            color: Color(0xFF454545),
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                             Container(constraints: const BoxConstraints(maxWidth: 250),child: Text(
                                               widget.newResumeMdoel.skills[index].skillName ?? '',
                                               style: const TextStyle(color: Colors.white),
                                             maxLines:1,
                                               overflow:TextOverflow.ellipsis

                                             ),),
                                              AdditonalOptions(onPressed: (){
                                                skillDot(index);
                                              },)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    'Level',
                                                    style: TextStyle(color: Colors.white60, fontSize: 14),
                                                  ),
                                                  Text(
                                                    widget.newResumeMdoel.skills[index].level ?? '',
                                                    style: const TextStyle(color: Colors.white, fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
                ),

                     //Languages
                      Scaffold(
                    floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                    floatingActionButton: Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            lanuageSheet();
                          },
                          icon: const Icon(
                            CupertinoIcons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    body: Container(
                      color: Colors.black,
                      child: widget.newResumeMdoel.languages.isEmpty
                          ? Center(
                            child: Container(
                            color: Colors.black,
                            width: double.infinity,
                            key: const ValueKey('empty'),
                            margin: const EdgeInsets.only(bottom: 30),
                            child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:
                              [
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.language,
                                    color: Colors.blue,
                                    size: 80,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'No Languages added',
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                                                    ),
                                                  ),
                          )
                          : ReorderableListView(
                        onReorder: (int oldIndex, int newIndex) {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          setState(() {
                            final item = widget.newResumeMdoel.languages.removeAt(oldIndex);
                            widget.newResumeMdoel.languages.insert(newIndex, item);
                          });
                        },
                        children: [
                          for (int index = 0; index < widget.newResumeMdoel.languages.length; index++)
                            Container(
                              key: ValueKey('language_$index'), // Unique key based on index
                              color: Colors.black,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(border: Border.all(
                                      color: Colors.white24,
                                      width:1,
                                    ),borderRadius: BorderRadius.circular(20)
                                    ),
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: const BoxDecoration(
                                              
                                            color: Color(0xFF454545),
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(constraints: const BoxConstraints(maxWidth: 250),child: Text(
                                                  widget.newResumeMdoel.languages[index].language ?? '',
                                                  style: const TextStyle(color: Colors.white),
                                                  maxLines:1,
                                                  overflow:TextOverflow.ellipsis

                                              ),),

                                              AdditonalOptions(onPressed: () { languageDot(index); },)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    'Level',
                                                    style: TextStyle(color: Colors.white60, fontSize: 14),
                                                  ),
                                                  Text(
                                                    widget.newResumeMdoel.languages[index].level ?? '',
                                                    style: const TextStyle(color: Colors.white, fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                      //references
                      Scaffold(
                        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
                        floatingActionButton: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                refrenceSheet();
                              },
                              icon: const Icon(
                                CupertinoIcons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        body: Container(
                          color: Colors.black,
                          child: widget.newResumeMdoel.refrences.isEmpty
                              ? Container(
                            alignment: Alignment.center,
                                color: Colors.black,
                                height: MediaQuery.of(context).size.height,
                                width: double.infinity,
                                key: const ValueKey('empty'),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[900],
                                          borderRadius: BorderRadius.circular(60),
                                        ),
                                        child: const Icon(
                                          CupertinoIcons.doc_circle,
                                          color: Colors.blue,
                                          size: 80,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'No Refrences added',
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              )

                              : ReorderableListView(
                            onReorder: (int oldIndex, int newIndex)
                            {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              setState(() {
                                final item = widget.newResumeMdoel.refrences.removeAt(oldIndex);
                                widget.newResumeMdoel.refrences.insert(newIndex, item);
                              });
                            },
                            children: [
                              for (int index = 0; index < widget.newResumeMdoel.refrences.length; index++)
                                Container(
                                  key: ValueKey('Refrences_$index'), // Unique key based on index
                                  color: Colors.black,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white24,
                                                    width:1,
                                                  ),
                                                color: const Color(0xFF454545),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(constraints: const BoxConstraints(maxWidth: 250),child: Text(
                                                      widget.newResumeMdoel.refrences[index].name ?? '',
                                                      style: const TextStyle(color: Colors.white),
                                                      maxLines:1,
                                                      overflow:TextOverflow.ellipsis

                                                  ),),


                                                  AdditonalOptions(onPressed: () { refrenceDot(index); },)
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      ///template
                      Scaffold(
                        body: Container(
                          color: Colors.black,
                          child: GridView.builder
                            (
                            itemCount: photo.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,crossAxisSpacing: 0
                            ),
                            itemBuilder: (context ,index)

                            {
                              return GestureDetector(
                                 onTap:  (){

                                   if (widget.newResumeMdoel.intro!.firstName.isEmpty ||
                                       widget.newResumeMdoel.intro!.lastName.isEmpty ||
                                       widget.newResumeMdoel.intro!.summary.isEmpty
                                   ) {

                                     _handleTabChange(0);
                                     _tabController.animateTo(0);
                                   }


                                   else if(widget.newResumeMdoel.contact!.email.isEmpty||widget.newResumeMdoel.contact!.phoneNumber.isEmpty||widget.newResumeMdoel.contact!.website.isEmpty||widget.newResumeMdoel.contact!.address.isEmpty)
                                     {
                                       _handleTabChange(1);
                                       _tabController.animateTo(1);

                                     }
                                   else if(widget.newResumeMdoel.skills.isEmpty)
                                   {

                                     _handleTabChange(5);
                                     _tabController.animateTo(5);
                                     print('skills');

                                   }
                                   else if(widget.newResumeMdoel.languages.isEmpty)
                                   {

                                     _handleTabChange(6);
                                     _tabController.animateTo(6);
                                   }
                                   else
                                   {

                                     handleTap(index, context);
                                   }


                                 },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                            width: MediaQuery.of(context).size.width * 0.4,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: AssetImage(photo[index]['image'] ?? ' '),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              //shade
                                              child: Container(
                                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [Colors.black87, Colors.transparent],
                                                    stops: [0.0, 0.2],
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text(
                                                          photo[index]['title'] ?? '',
                                                          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 15),
                                                        ),
                                                        const Icon(
                                                          CupertinoIcons.profile_circled,
                                                          color: Colors.orange,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )


                                    )
                                  ],
                                ),
                              );

                            },
                          ),
                        ),

                      )
                    ]
                ),
              ),

              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void handleTap(int index, BuildContext context) {
    if (widget.newResumeMdoel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resume model is null!')),
      );
      return;
    }

    // Create a key for the dialog
    final GlobalKey<State> dialogKey = GlobalKey<State>();

    // Show the loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          key: dialogKey,

        color: Colors.black.withOpacity(0.1),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white,),
          ),
        );
      },
    );

    // Generate the PDF
    Future<void> generatePdf() async {
      try {
        await (index.isEven
            ? createPdf_B_W(widget.newResumeMdoel, 'preview', context)
            : createPdf_blue(widget.newResumeMdoel,'preview', context));
      } catch (e)
      {
        print('Error generating PDF: $e');
      }
    }

    // Start PDF generation
    generatePdf();
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

  Future educationSheetEdit(int index) {
    final formKey = GlobalKey<FormState>();
    final textControllerSchoolTitle = TextEditingController(text: widget.newResumeMdoel.education[index].schoolTitle);
    final textControllerMajor = TextEditingController(text: widget.newResumeMdoel.education[index].major);
    final textControllerEduFrom = TextEditingController(text: widget.newResumeMdoel.education[index].from);
    final textControllerEduTo = TextEditingController(text: widget.newResumeMdoel.education[index].to);

    bool Cdate = false;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF454545),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),

                        CustomTextFieldValidate(
                          labelText: 'Which School did you attend',
                          controller: textControllerSchoolTitle,
                          hintText: 'School Name',
                          onChanged: (String value) {},
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'School cannot be empty';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        CustomTextFieldValidate(
                          labelText: 'Major',
                          controller: textControllerMajor,
                          hintText: 'Major',
                          onChanged: (String value) {},
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Major cannot be empty';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFieldValidate(
                                labelText: 'From',
                                inputFormatter: [LengthLimitingTextInputFormatter(4)],
                                controller: textControllerEduFrom,
                                hintText: '2012',
                                onChanged: (String value) {},
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'From cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: CustomTextFieldValidate(
                                enable:  !Cdate,
                                labelText: 'To',
                                controller: textControllerEduTo,
                                inputFormatter: [LengthLimitingTextInputFormatter(4)],
                                hintText: '2016',
                                onChanged: (String value) {},
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (!Cdate && (value == null || value.isEmpty)) {
                                    return 'To cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Text('Present', style: TextStyle(color: Colors.white)),
                            const SizedBox(width: 10),
                            FlutterSwitch(
                              width: 50,
                              activeIcon: const Icon(CupertinoIcons.check_mark),
                              value: Cdate,
                              activeColor: Colors.blue,
                              showOnOff: false,
                              onToggle: (val) {
                                setState(() {
                                  Cdate = val;
                                });
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                              print('her');
                              if (formKey.currentState?.validate() ?? false) {
                                print('jer');
                                if (Cdate) {
                                  final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                  resumeViewModel.editEducation(widget.index, index, Education(
                                      schoolTitle: textControllerSchoolTitle.text,
                                      major: textControllerMajor.text,
                                      from: textControllerEduFrom.text,
                                      to: 'PRESENT'));
                                  resumeViewModel.updateFullness(widget.newResumeMdoel);
                                } else {
                                  final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                  resumeViewModel.editEducation(widget.index, index, Education(
                                      schoolTitle: textControllerSchoolTitle.text,
                                      major: textControllerMajor.text,
                                      from: textControllerEduFrom.text,
                                      to: textControllerEduTo.text));
                                  resumeViewModel.updateFullness(widget.newResumeMdoel);
                                }

                                textControllerSchoolTitle.clear();
                                textControllerMajor.clear();
                                textControllerEduFrom.clear();
                                textControllerEduTo.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Save', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future Education_dot(index)
  {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: Color(0xFF454545),
          ),
          width: double.infinity,
          child: FractionallySizedBox(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF454545),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: ()
                    {
                      setState(() {
                        educationSheetEdit(index);
                      });
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const ListTile(
                      leading: Icon(Icons.edit, color: Colors.white),
                      title: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(height: 1,color: Colors.white24,),
                  TextButton(
                    onPressed: () {setState(()
                    {
                      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                      resumeViewModel.deleteEducation(widget.index, index);
                      resumeViewModel.updateFullness(widget.newResumeMdoel);

                    });
                    Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const ListTile(
                      leading: Icon(Icons.delete, color: Colors.red),
                      title: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Future EducationSheet() {
    final formKey = GlobalKey<FormState>();
    Cdate=false;
    textControllerSchoolTitle.clear();
    textControllerMajor.clear();
    textControllerEduFrom.clear();
    textControllerEduTo.clear();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FractionallySizedBox(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF454545),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 40),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),

                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          CustomTextFieldValidate(
                            labelText: 'Which Educational Institute did you attend',
                            controller: textControllerSchoolTitle, hintText: 'Shnaghai University',
                            onChanged: (String ) {  },

                            validator: (value) {
                              if (value == null || value.isEmpty)
                              {
                                return 'Educational Institute cannot be empty';
                              }
                              return null;
                            }, keyboardType: TextInputType.text,
                          ),

                          const SizedBox(height: 20),
                          CustomTextFieldValidate(
                            labelText: 'Major',
                            controller: textControllerMajor, hintText: 'Bachelors of ...',
                            onChanged: (String ) {  },

                            validator: (value) {
                              if (value == null || value.isEmpty)
                              {
                                return 'Major cannot be empty';
                              }
                              return null;
                            }, keyboardType: TextInputType.text,
                          ),

                          const SizedBox(height: 20),

                          Row(
                            children: [

                              Flexible(
                                child: Theme(
                                  data: ThemeData.dark(),
                                  child: CustomTextFieldValidate(
                                    labelText: 'From',
                                    inputFormatter: [LengthLimitingTextInputFormatter(4)],
                                    controller: textControllerEduFrom,
                                    hintText: '2012',
                                    onChanged: (String value) {},
                                    keyboardType: TextInputType.datetime,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'From cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),const SizedBox(width: 10),
                              Flexible(
                                child: Theme(
                                  data: ThemeData.dark(),
                                  child: CustomTextFieldValidate(
                                    enable:  !Cdate,
                                    labelText: 'To',
                                    controller: textControllerEduTo,
                                    inputFormatter: [LengthLimitingTextInputFormatter(4)],
                                    hintText: '2016',
                                    onChanged: (String value) {},
                                    keyboardType: TextInputType.datetime,
                                    validator: (value) {
                                      if (!Cdate && (value == null || value.isEmpty)) {
                                        return 'To cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                child: const Text(
                                  'Present',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10),
                              FlutterSwitch(
                                width: 50,
                                activeIcon: const Icon(CupertinoIcons.check_mark),
                                value: Cdate,
                                activeColor: Colors.blue,
                                showOnOff: false,
                                onToggle: (val) {
                                  setState(() {
                                    Cdate = val;
                                  });
                                },
                              ),
                              const SizedBox(width: 150),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(

                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  if (Cdate) {

                                    final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                    resumeViewModel.addEducation(widget.index, Education(
                                        schoolTitle: textControllerSchoolTitle.text,
                                        major: textControllerMajor.text,
                                        from: textControllerEduFrom.text,
                                        to: 'PRESENT'));
                                    resumeViewModel.updateFullness(widget.newResumeMdoel);
                                  }
                                  else
                                  {
                                    final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                    resumeViewModel.addEducation(widget.index, Education(
                                        schoolTitle: textControllerSchoolTitle.text,
                                        major: textControllerMajor.text,
                                        from: textControllerEduFrom.text,
                                        to: textControllerEduTo.text));
                                    resumeViewModel.updateFullness(widget.newResumeMdoel);
                                  }

                                  // Call update function to refresh the state
                                  update();

                                  textControllerSchoolTitle.clear();
                                  textControllerMajor.clear();
                                  textControllerEduFrom.clear();
                                  textControllerEduTo.clear();

                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Save', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }



  Future certification_dot(index) {
    final textControllerCertificationName = TextEditingController(
      text: widget.newResumeMdoel.certifications[index].certificationName,
    );
    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: Color(0xFF454545),
          ),
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF454545),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        Certification_Edit(index);
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const ListTile(
                        leading: Icon(Icons.edit, color: Colors.white),
                        title: Text(
                          'Edit',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const Divider(height: 1, color: Colors.white24),
                    TextButton(
                      onPressed: () {
                        setState(() {

                          final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                          resumeViewModel.deleteCertification(widget.index, index);
                          resumeViewModel.updateFullness(widget.newResumeMdoel);
                        });
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future Certification_Edit(int index) {
    final textControllerCertificationName = TextEditingController(
      text: widget.newResumeMdoel.certifications[index].certificationName,
    );
    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(bottom: 20,top: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: Color(0xFF454545),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Theme(
                      data: ThemeData.dark(),
                      child: CustomTextFieldValidate(
                        labelText: 'Certification Name',
                        controller: textControllerCertificationName, hintText: '',
                        onChanged: (String ) {  },

                        validator: (value) {
                          if (value == null || value.isEmpty)
                          {
                            return 'Certification cannot be empty';
                          }
                          return null;
                        }, keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          setState(() {
                            widget.newResumeMdoel.certifications[index] = Certification(
                              certificationName: textControllerCertificationName.text,
                            );
                            final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                            resumeViewModel.editCertification(widget.index, index,Certification(
                              certificationName: textControllerCertificationName.text,
                            ) );
                          });
                          Navigator.pop(context);

                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future certificationSheet() {
    final formKey = GlobalKey<FormState>();


    return showModalBottomSheet(
      isScrollControlled: true,

      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF454545),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      CustomTextFieldValidate(
                        labelText: 'Certification Name',
                        controller: textControllerCertificationTitle, hintText: 'Basics of Python - Udemy',
                        onChanged: (String ) {  },

                        validator: (value) {
                          if (value == null || value.isEmpty)
                          {
                            return 'Certification cannot be empty';
                          }
                          return null;
                        }, keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      Container(

                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              setState(() {
                                final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                resumeViewModel.addCertification(widget.index, Certification(certificationName: textControllerCertificationTitle.text));
                                resumeViewModel.updateFullness(widget.newResumeMdoel);
                                update();
                              });
                              textControllerCertificationTitle.clear();
                              update();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Save', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }



  void update()
  {
    setState(() {

    });
  }

  Future experience_edit(index)
  {
   textControllerCompany=TextEditingController(text: widget.newResumeMdoel.experience[index].company);
     textControllerPosition=TextEditingController(text: widget.newResumeMdoel.experience[index].position);
     textControllerLocation=TextEditingController(text: widget.newResumeMdoel.experience[index].location);
     textControllerEFrom=TextEditingController(text: widget.newResumeMdoel.experience[index].from);
    textControllerETo=TextEditingController(text: widget.newResumeMdoel.experience[index].to);
     textControllerDescription=TextEditingController(text: widget.newResumeMdoel.experience[index].description);
   Cdate=false;
   final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF454545),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          CustomTextFieldValidate(
                            labelText: 'Company',
                            controller: textControllerCompany,
                            hintText: 'Global inc',
                            onChanged: (String) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Company cannot be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 20),
                          CustomTextFieldValidate(
                            labelText: 'Position',
                            controller: textControllerPosition,
                            hintText: 'Manager',
                            onChanged: (String) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Position cannot be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 20),
                          CustomTextFieldValidate(
                            labelText: 'Location',
                            controller: textControllerLocation,  // Correct controller used
                            hintText: 'Sydney, Australia',
                            onChanged: (String) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Location cannot be empty';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 20),

                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFieldValidate(
                                  labelText: 'From',
                                  controller: textControllerEFrom,  // Correct controller used
                                  hintText: '2012',
                                  onChanged: (String) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Start date cannot be empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.datetime,
                                  inputFormatter: [LengthLimitingTextInputFormatter(4)],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextFieldValidate(
                                  labelText: 'To',
                                  controller: textControllerETo,
                                  hintText: '2018',
                                  onChanged: (String) {},
                                  validator: (value) {
                                    if (!Cdate && (value == null || value.isEmpty)) {
                                      return 'End date cannot be empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.datetime,
                                  inputFormatter: [LengthLimitingTextInputFormatter(4)],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          CustomSummaryFieldNON(
                            height: 80,
                            labelText: 'Description',
                            controller: textControllerDescription,
                            hintText: 'Type Your letter message',
                            onChanged: (value) {},
                            borderColor: Colors.grey,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(

                                child: const Text('Present', style: TextStyle(color: Colors.white)),
                              ),
                              SizedBox(width: 10,),
                              Stack(
                                children: [
                                  FlutterSwitch(
                                    width: 50,
                                    activeIcon: const Icon(CupertinoIcons.check_mark),
                                    value: Cdate,
                                    activeColor: Colors.blue,
                                    showOnOff: false,
                                    onToggle: (val) {
                                      setState(() {
                                        Cdate = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const Spacer(),

                            ],
                          ),
                          const SizedBox(height: 30,),
                          Container(

                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false)
                                {
                                  setState(() {
                                    if (Cdate) {
                                      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                      resumeViewModel.editExperience(widget.index,index, Experience(
                                        company: textControllerCompany.text,
                                        position: textControllerPosition.text,
                                        location: textControllerLocation.text,
                                        from: textControllerEFrom.text,
                                        to: 'PRESENT',
                                        description: textControllerDescription.text,
                                      ));
                                    }
                                    else {
                                      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                      resumeViewModel.editExperience(widget.index,index, Experience(
                                        company: textControllerCompany.text,
                                        position: textControllerPosition.text,
                                        location: textControllerLocation.text,
                                        from: textControllerEFrom.text,
                                        to: textControllerEduTo.text,
                                        description: textControllerDescription.text,
                                      ));
                                    }
                                    update();
                                    textControllerCompany.clear();
                                    textControllerDescription.clear();
                                    textControllerETo.clear();
                                    textControllerEFrom.clear();
                                    textControllerPosition.clear();
                                  });
                                  update();
                                  Navigator.pop(context);
                                }

                              },
                              child: const Text('Save', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );

      },
    );
  }

  Future experienceSheet() {
    final textControllerCompany = TextEditingController();
    final textControllerPosition = TextEditingController();
    final textControllerLocation = TextEditingController();
    final textControllerEFrom = TextEditingController();
    final textControllerETo = TextEditingController();
    final textControllerDescription = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Cdate = false;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,  // Ensure background isn't causing visibility issues
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FractionallySizedBox(
              heightFactor: 0.85,  // Control the size of the modal sheet
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      color: Color(0xFF454545),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),

                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            CustomTextFieldValidate(
                              labelText: 'Company',
                              controller: textControllerCompany,
                              hintText: 'Global inc',
                              onChanged: (String) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Company cannot be empty';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 20),
                            CustomTextFieldValidate(
                              labelText: 'Position',
                              controller: textControllerPosition,
                              hintText: 'Manager',
                              onChanged: (String) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Position cannot be empty';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 20),
                            CustomTextFieldValidate(
                              labelText: 'Location',
                              controller: textControllerLocation,  // Correct controller used
                              hintText: 'Sydney, Australia',
                              onChanged: (String) {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Location cannot be empty';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFieldValidate(
                                    labelText: 'From',
                                    controller: textControllerEFrom,  // Correct controller used
                                    hintText: '2012',
                                    onChanged: (String) {},
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Start date cannot be empty';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.datetime,
                                    inputFormatter: [LengthLimitingTextInputFormatter(4)],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFieldValidate(
                                    labelText: 'To',
                                    controller: textControllerETo,
                                    hintText: '2018',
                                    onChanged: (String) {},
                                    validator: (value) {
                                      if (!Cdate && (value == null || value.isEmpty)) {
                                        return 'End date cannot be empty';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.datetime,
                                    inputFormatter: [LengthLimitingTextInputFormatter(4)],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomSummaryFieldNON(
                              height: 80,
                              labelText: 'Description',
                              controller: textControllerDescription,
                              hintText: 'Type Your letter message',
                              onChanged: (value) {},
                              borderColor: Colors.grey,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Container(

                                  child: const Text('Present', style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(width: 10,),
                                FlutterSwitch(
                                  width: 50,
                                  activeIcon: const Icon(CupertinoIcons.check_mark),
                                  value: Cdate,
                                  activeColor: Colors.blue,
                                  showOnOff: false,
                                  onToggle: (val) {
                                    setState(() {
                                      Cdate = val;
                                    });
                                  },
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Container(

                              width: double.infinity,
                              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {
                                    if (formKey.currentState?.validate() ?? false) {
                                      setState(() {
                                        if (Cdate) {
                                          final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                          resumeViewModel.addExperience(
                                            widget.index,
                                            Experience(
                                              company: textControllerCompany.text,
                                              position: textControllerPosition.text,
                                              location: textControllerLocation.text,
                                              from: textControllerEFrom.text,
                                              to: 'PRESENT',
                                              description: textControllerDescription.text,
                                            ),
                                          );
                                          resumeViewModel.updateFullness(widget.newResumeMdoel);
                                        } else {
                                          final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                          resumeViewModel.addExperience(
                                            widget.index,
                                            Experience(
                                              company: textControllerCompany.text,
                                              position: textControllerPosition.text,
                                              location: textControllerLocation.text,
                                              from: textControllerEFrom.text,
                                              to: textControllerETo.text,
                                              description: textControllerDescription.text,
                                            ),
                                          );
                                          resumeViewModel.updateFullness(widget.newResumeMdoel);
                                        }
                                        Navigator.pop(context);
                                        update();
                                      });
                                      textControllerCompany.clear();
                                      textControllerPosition.clear();
                                      textControllerEFrom.clear();
                                      textControllerETo.clear();
                                      textControllerDescription.clear();
                                      update();
                                    }
                                  },

                                  child: const Text('Save', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


  Future experience_dot(index)
  {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: Color(0xFF454545),
          ),
          width: double.infinity,
          child: FractionallySizedBox(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF454545),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: ()
                    {
                      setState(()
                      {experience_edit(index);}
                      );
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const ListTile(
                      leading: Icon(Icons.edit, color: Colors.white),
                      title: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(height: 1,color: Colors.white24,),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                        resumeViewModel.deleteExperience(widget.index, index);
                        resumeViewModel.updateFullness(widget.newResumeMdoel);
                      });
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const ListTile(
                      leading: Icon(Icons.delete, color: Colors.red),
                      title: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }



  Future refrenceSheet() {
    final textControllerRName = TextEditingController();
    final textControllerRCompany = TextEditingController();
    final textControllerRPostition = TextEditingController();
    final textControllerRPhone = TextEditingController();
    final textControllerREmail = TextEditingController();


    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF454545),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        //name
                        Container(
                          alignment: Alignment.topLeft,

                          child: const Text(
                            'Name',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),

                        const SizedBox(height: 10,),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(

                            controller: textControllerRName,
                            decoration: const InputDecoration(
                              label: Text('Vitalik'),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name field cannot be empty';
                              }

                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 20,),
                        //postition
                        Container(
                          alignment: Alignment.topLeft,

                          child: const Text(
                            'Position',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),

                        const SizedBox(height: 10,),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(


                            controller: textControllerRPostition,
                            decoration: const InputDecoration(
                              label: Text('Manager'),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Position field cannot be empty';
                              }
                              return null;
                            }
                          ),
                        ),

                        const SizedBox(height: 20,),
                        //company
                        Container(
                          alignment: Alignment.topLeft,

                          child: const Text(
                            'Company',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),

                        const SizedBox(height: 10,),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(

                            controller: textControllerRCompany,
                            decoration: const InputDecoration(
                              label: Text('Something Inc'),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Company field cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        //email

                        const SizedBox(height: 20,),

                        Container(
                          alignment: Alignment.topLeft,

                          child: const Text(
                            'Email',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(
                            controller: textControllerREmail,
                            decoration: const InputDecoration(
                              label: Text('vitalik@gmail.com'),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email field cannot be empty';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email containing @';
                              }
                              if (!value.endsWith('.com')) {
                                return 'Please enter a valid email ending with .com';
                              }
                              return null;
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 20,),

                        //phone
                        Container(
                          alignment: Alignment.topLeft,

                          child: const Text(
                            'Phone',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                            ],
                            keyboardType: TextInputType.phone,
                            controller: textControllerRPhone,
                            decoration: const InputDecoration(
                              label: Text('+7783420148392'),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone field cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(

                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {

                              });
                              if (formKey.currentState?.validate() ?? false) {
                                setState(() {
                                  final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                  resumeViewModel.addReference(widget.index, Reference(name: textControllerRName.text, position: textControllerRPostition.text, company: textControllerRCompany.text, email: textControllerREmail.text, phone: textControllerRPhone.text)
                                  );
                                  resumeViewModel.updateFullness(widget.newResumeMdoel);
                                }
                                );
                                textControllerLanguage.clear();
                                textControllerLevel.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Future refrenceEditSheet(index) {
    final textControllerRName = TextEditingController(text: widget.newResumeMdoel.refrences[index].name);
    final textControllerRCompany = TextEditingController(text: widget.newResumeMdoel.refrences[index].company);
    final textControllerRPostition = TextEditingController(text: widget.newResumeMdoel.refrences[index].position);
    final textControllerRPhone = TextEditingController(text: widget.newResumeMdoel.refrences[index].phone);
    final textControllerREmail = TextEditingController(text: widget.newResumeMdoel.refrences[index].email);

    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF454545),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        // Name
                        Container(
                          alignment: Alignment.topLeft,

                          child: const Text(
                            'Name',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Theme(
                          data: ThemeData.dark(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: textControllerRName,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name field cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                        // Position
                        Container(
                          alignment: Alignment.topLeft,

                          child: const Text(
                            'Position',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Theme(
                          data: ThemeData.dark(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: textControllerRPostition,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Position field cannot be empty';
                                  }
                                  return null;
                                },
                              ),


                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Company
                        Container(
                          alignment: Alignment.topLeft,

                          child: const Text(
                            'Company',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Theme(
                          data: ThemeData.dark(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50, // Fixed height for the TextFormField
                                child: TextFormField(
                                  controller: textControllerRCompany,
                                  decoration: const InputDecoration(
                                    label: Text('Something Inc'),
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  cursorColor: Colors.white,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Company field cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 5), // Space for error message

                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Email
                        Container(
                          alignment: Alignment.topLeft,

                          child: const Text(
                            'Email',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Theme(
                          data: ThemeData.dark(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: textControllerREmail,
                                decoration: const InputDecoration(
                                  label: Text('vitalik@gmail.com'),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email field cannot be empty';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email containing @';
                                  }
                                  if (!value.endsWith('.com')) {
                                    return 'Please enter a valid email ending with .com';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 5), // Space for error message

                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Phone
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Phone',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Theme(
                          data: ThemeData.dark(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50, // Fixed height for the TextFormField
                                child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(15),
                                  ],
                                  keyboardType: TextInputType.phone,
                                  controller: textControllerRPhone,
                                  decoration: const InputDecoration(
                                    label: Text('+7783420148392'),
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  cursorColor: Colors.white,
                                  validator: (value)
                                  {
                                    if (value == null || value.isEmpty) {
                                      return 'Phone field cannot be empty';
                                    }
                                    if (value.endsWith('.com')) {
                                      return 'Phone cannot end with .com';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 5), // Space for error message

                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(

                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                setState(() {

                                  final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                  resumeViewModel.editReference(widget.index, index, Reference(name:textControllerRName.text,company:  textControllerRCompany.text, position: textControllerRPostition.text, email: textControllerREmail.text, phone: textControllerRPhone.text, ));
                                  resumeViewModel.updateFullness(widget.newResumeMdoel);
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
Future refrenceDot(index)
{
  return  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          color: Color(0xFF454545),
        ),
        width: double.infinity,
        child: FractionallySizedBox(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF454545),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      refrenceEditSheet(index);
                    });
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: const ListTile(
                    leading: Icon(Icons.edit, color: Colors.white),
                    title: Text(
                      'Edit',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const Divider(height: 1, color: Colors.white24),
                TextButton(
                  onPressed: () {
                    setState(() {
                      final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                      resumeViewModel.deleteReference(widget.index, index);
                      resumeViewModel.updateFullness(widget.newResumeMdoel);
                    });
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: const ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    },
  );

}



  Future skillDot(index)
  {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: Color(0xFF454545),
          ),
          width: double.infinity,
          child: FractionallySizedBox(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF454545),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {

                        edit_skill(index);
                      });
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const ListTile(
                      leading: Icon(Icons.edit, color: Colors.white),
                      title: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),


                  const Divider(height: 1, color: Colors.white24),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                        resumeViewModel.deleteSkill(widget.index, index);
                        resumeViewModel.updateFullness(widget.newResumeMdoel);
                      });
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const ListTile(
                      leading: Icon(Icons.delete, color: Colors.red),
                      title: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Future edit_skill(int index) {
    final textControllerSkillName = TextEditingController(text: widget.newResumeMdoel.skills[index].skillName);
    final textControllerSkilllevel = TextEditingController(text: widget.newResumeMdoel.skills[index].level);

    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Color(0xFF454545),
            ),
            width: double.infinity,
            child: FractionallySizedBox(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF454545),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          CustomTextFieldValidate(
                            labelText: 'Skill',
                            controller: textControllerSkillName, hintText: 'Excel',
                            onChanged: (String ) {  },

                            validator: (value) {
                              if (value == null || value.isEmpty)
                              {
                                return 'Skill cannot be empty';
                              }
                              return null;
                            }, keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 10),
                          CustomTextFieldValidate(
                            labelText: 'Skill Level',
                            controller: textControllerSkilllevel, hintText: '20%',
                            onChanged: (value ) {if (value.isNotEmpty) {
                              if (int.parse(value) >= 100) {
                                textControllerSkilllevel.text = "100";
                              }
                              if (int.parse(value) <= 0) {
                                textControllerSkilllevel.text = "0";
                              }
                            }  },

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Level field cannot be empty';
                              }
                              final int? level = int.tryParse(value);
                              if (level == null || level < 0 || level > 100) {
                                return 'Please enter a value between 0 and 100';
                              }
                              return null;
                            }, keyboardType: TextInputType.text,
                          ),

                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false)
                                {
                                  setState(()
                                  {
                                    widget.newResumeMdoel.skills[index].skillName = textControllerSkillName.text;
                                    widget.newResumeMdoel.skills[index].level=textControllerSkilllevel.text;
                                    final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                    resumeViewModel.editSkill(widget.index,index,Skill(skillName: textControllerSkillName.text,level: textControllerSkilllevel.text),);
                                    resumeViewModel.updateFullness(widget.newResumeMdoel);
                                  });
                                  Navigator.of(context)..pop()..pop();
                                }
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Future SkillSheet() {
    final textControllerSkillName = TextEditingController();
    final textControllerSkillLevel = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF454545),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(

                margin: const EdgeInsets.symmetric(horizontal: 20),

                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        CustomTextFieldValidate(
                          labelText: 'Skill',
                          controller: textControllerSkillName, hintText: 'Excel',
                          onChanged: (String ) {  },

                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Skill cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFieldValidate(
                          labelText: 'Skill Level',
                          controller: textControllerSkillLevel, hintText: '20%',
                          onChanged: (value ) {if (value.isNotEmpty) {
                            if (int.parse(value) >= 100) {
                              textControllerSkillLevel.text = "100";
                            }
                            if (int.parse(value) <= 0) {
                              textControllerSkillLevel.text = "0";
                            }
                          }  },

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Level field cannot be empty';
                            }
                            final int? level = int.tryParse(value);
                            if (level == null || level < 0 || level > 100) {
                              return 'Please enter a value between 0 and 100';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),

                        const SizedBox(height: 10),
                        Container(

                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {

                              if (formKey.currentState?.validate() ?? false)
                              {
                                setState(() {
                                  final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                  resumeViewModel.addSkill(widget.index,Skill(skillName: textControllerSkillName.text,level: textControllerSkillLevel.text),);
                                  resumeViewModel.updateFullness(widget.newResumeMdoel);
                                });
                                textControllerSkillName.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Future lanuageSheet() {
    final textControllerLanguage = TextEditingController();
    final textControllerLevel = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF454545),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),

                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        const SizedBox(height: 20),
                        CustomTextFieldValidate(
                          labelText: 'Language',
                          controller: textControllerLanguage, hintText: 'English',
                          onChanged: (String ) {  },

                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Language cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFieldValidate(
                          labelText: 'Language Proficiency Level',
                          controller: textControllerLevel, hintText: '20',
                          onChanged: (value ) { if (value.isNotEmpty) {
                            if (int.parse(value) >= 100) {
                              textControllerLevel.text = "100";
                            }
                            if (int.parse(value) <= 0) {
                              textControllerLevel.text = "0";
                            }
                          } },

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Level field cannot be empty';
                            }
                            final int? level = int.tryParse(value);
                            if (level == null || level < 0 || level > 100) {
                              return 'Please enter a value between 0 and 100';
                            }
                            return null;
                          }, keyboardType: TextInputType.phone,
                          inputFormatter: [FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),],
                        ),
                        const SizedBox(height: 10),
                        Container(

                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {

                              });
                              if (formKey.currentState?.validate() ?? false) {
                                setState(() {
                                  final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                  resumeViewModel.addLanguage(widget.index,
                                    Language(
                                      language: textControllerLanguage.text,
                                      level: textControllerLevel.text,
                                    ),
                                  );

                                  resumeViewModel.updateFullness(widget.newResumeMdoel);
                                });
                                textControllerLanguage.clear();
                                textControllerLevel.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Future languageDot(index)
  {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: Color(0xFF454545),
          ),
          width: double.infinity,
          child: FractionallySizedBox(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF454545),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        rename_lang(index);
                      });
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const ListTile(
                      leading: Icon(Icons.edit, color: Colors.white),
                      title: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(height: 1, color: Colors.white24),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        edit_lang(index);
                      });

                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const ListTile(
                      leading: Icon(Icons.edit, color: Colors.white),
                      title: Text(
                        'Rename',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(height: 1, color: Colors.white24),
                  TextButton(
                    onPressed: () {
                      setState(() {

                        final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                        resumeViewModel.deleteLanguage(widget.index,index);
                        resumeViewModel.updateFullness(widget.newResumeMdoel);
                      });
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const ListTile(
                      leading: Icon(Icons.delete, color: Colors.red),
                      title: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Future rename_lang(int index) {
    final textControllerLanguage = TextEditingController(text: widget.newResumeMdoel.languages[index].language);
    final textControllerLevel = TextEditingController(text: widget.newResumeMdoel.languages[index].level);
    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Color(0xFF454545),
            ),
            width: double.infinity,
            child: FractionallySizedBox(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF454545),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        CustomTextFieldValidate(
                          labelText: 'Language',
                          controller: textControllerLanguage, hintText: 'English',
                          onChanged: (String ) {  },

                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Language cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFieldValidate(
                          labelText: 'Language Proficiency Level',
                          controller: textControllerLanguage, hintText: '20',
                          onChanged: (value ) { if (value.isNotEmpty) {
                            if (int.parse(value) >= 100) {
                              textControllerLevel.text = "100";
                            }
                            if (int.parse(value) <= 0) {
                              textControllerLevel.text = "0";
                            }
                          } },

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Level field cannot be empty';
                            }
                            final int? level = int.tryParse(value);
                            if (level == null || level < 0 || level > 100) {
                              return 'Please enter a value between 0 and 100';
                            }
                            return null;
                          }, keyboardType: TextInputType.number,
                          inputFormatter: [FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                setState(() {

                                  resumeViewModel.editLangauges(widget.index,index,Language(language:textControllerLanguage.text ,level:textControllerLevel.text ));
                                });
                                Navigator.of(context)..pop()..pop();
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Future edit_lang(int index) {
    final textControllerLanguage = TextEditingController(text: widget.newResumeMdoel.languages[index].language);
    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Color(0xFF454545),
            ),
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: FractionallySizedBox(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xFF454545),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          CustomTextFieldValidate(
                            labelText: 'Language',
                            controller: textControllerLanguage, hintText: 'English',
                            onChanged: (String ) {  },

                            validator: (value) {
                              if (value == null || value.isEmpty)
                              {
                                return 'Language cannot be empty';
                              }
                              return null;
                            }, keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false)
                                {
                                  setState(()
                                  {
                                    widget.newResumeMdoel.languages[index].language = textControllerLanguage.text;
                                  });
                                  Navigator.of(context)..pop()..pop();
                                }
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}


