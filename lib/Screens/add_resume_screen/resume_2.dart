
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resume_maker/Models/model_resume.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_view_model.dart';
import '../templates/black_white.dart';
import '../templates/blue.dart';



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

class _Resume_DetailsState extends State<Resume_Details> with SingleTickerProviderStateMixin {
  final ResumeViewModelProvider resumeViewModel = ResumeViewModelProvider();


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
    textControllerFirstName =TextEditingController(text: widget.newResumeMdoel.intro?.firstName);
    textControllerFirstName.addListener(() => widget.newResumeMdoel.intro?.firstName = textControllerFirstName.text);

    textControllerLastName =TextEditingController(text: widget.newResumeMdoel.intro?.lastName);
    textControllerLastName.addListener(() => widget.newResumeMdoel.intro?.lastName = textControllerLastName.text);

    textControllerSummary =TextEditingController(text: widget.newResumeMdoel.intro?.lastName);
    textControllerSummary.addListener(() => widget.newResumeMdoel.intro?.summary = textControllerSummary.text);

    textControllerEmail =TextEditingController(text: widget.newResumeMdoel.contact?.address);
    textControllerEmail.addListener(() => widget.newResumeMdoel.contact?.address = textControllerEmail.text);


    textControllerPhoneNumber =TextEditingController(text: widget.newResumeMdoel.contact?.phoneNumber);
    textControllerPhoneNumber.addListener(() => widget.newResumeMdoel.contact?.phoneNumber = textControllerPhoneNumber.text);

    textControllerWebsite =TextEditingController(text: widget.newResumeMdoel.contact?.website);
    textControllerWebsite.addListener(() => widget.newResumeMdoel.contact?.website = textControllerWebsite.text);


    textControllerAddress =TextEditingController(text: widget.newResumeMdoel.contact?.email);
    textControllerAddress.addListener(() => widget.newResumeMdoel.contact?.email = textControllerAddress.text);






    _tabController = TabController(length: 8, vsync: this);
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
            child: IconButton(onPressed: (){setState(() {
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
                _tabController.animateTo((_tabController.index + 1) % 8);
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
              length: 8,
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
                          child: const Row(children: [
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
                      ),//Languages
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
                                      child: Stack(children: [
                                        CircleAvatar(
                                          backgroundImage: widget.newResumeMdoel.profile_image == null
                                              ? const AssetImage('assets/images/profile.png') as ImageProvider
                                              : FileImage(File(widget.newResumeMdoel.profile_image!.path)),
                                          radius: 50,
                                        ),
                                        Positioned(left: 70,top: 70,child: GestureDetector(onTap: (){imageSheet();},child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue),child: const Icon(CupertinoIcons.plus,color: Colors.white,),)))
                                      ],)
                                  ),
                
                                  //First Name
                                  Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),child: Text('First Name',style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                                  Theme(
                                    data: ThemeData.dark(),
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                      height: 50,
                                      width:double.infinity ,
                                      child: TextFormField(
                                        onChanged: (value){
                                          resumeViewModel.updateFullness2(widget.newResumeMdoel);
                                        },
                                        controller: textControllerFirstName,
                                        decoration: const InputDecoration(
                                          labelText: 'Vitalik',
                                          focusedBorder:OutlineInputBorder(
                
                                              borderSide: BorderSide(color: Colors.white)
                
                                          ) ,
                                          border: OutlineInputBorder(),
                                        ),
                                        cursorColor: Colors.white,
                                      ),
                                    ),
                                  ),
                
                                  //Last name
                                  Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),child: Text('Last Name',style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                                  Theme(
                                    data: ThemeData.dark(),
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                      height: 50,
                                      width:double.infinity ,
                                      child: TextFormField(
                
                                        controller: textControllerLastName,
                                        decoration: const InputDecoration(
                                          labelText: 'William',
                                          focusedBorder:OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white)
                
                                          ) ,
                                          border: OutlineInputBorder(),
                                        ),
                                        cursorColor: Colors.white,
                                      ),
                                    ),
                                  ),
                
                                  //summary
                                  Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
                                      child: Text('Summary',
                                        style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                                  Theme(
                                    data: ThemeData.dark(),
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                      height: 50,
                                      width:double.infinity ,
                                      child: TextFormField(
                
                                        controller: textControllerSummary,
                                        decoration: const InputDecoration(
                                          labelText: 'UI Desginer based in LA',
                                          focusedBorder:OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white)
                
                                          ) ,
                                          border: OutlineInputBorder(),
                                        ),
                                        cursorColor: Colors.white,
                                      ),
                                    ),
                                  )
                
                
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
                                  Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),child: Text('Email Address',style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                                  Theme(
                                    data: ThemeData.dark(),
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                      height: 50,
                                      width:double.infinity ,
                                      child: TextFormField(
                                        keyboardType: TextInputType.emailAddress,
                                        controller: textControllerEmail,
                                        decoration: const InputDecoration(
                                          labelText: 'vialik@gmail.com',
                                          focusedBorder:OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white)
                                          ) ,
                                          border: OutlineInputBorder(),
                                        ),
                                        cursorColor: Colors.white,
                                      ),
                                    ),
                                  ),
                
                                  //Phone Number
                                  Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),child: Text('Phone Number',style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                                  Theme(
                                    data: ThemeData.dark(),
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                      height: 50,
                                      width:double.infinity ,
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        controller: textControllerPhoneNumber,
                                        decoration: const InputDecoration(
                                          labelText: '234 233 254 325',
                                          focusedBorder:OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white)
                
                                          ) ,
                                          border: OutlineInputBorder(),
                                        ),
                                        cursorColor: Colors.white,
                                      ),
                                    ),
                                  ),
                
                                  //Personal Website
                                  Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),child: Text('Website',style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                                  Theme(
                                    data: ThemeData.dark(),
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                      height: 50,
                                      width:double.infinity ,
                                      child: TextFormField(
                                        keyboardType: TextInputType.url,
                                        controller: textControllerWebsite,
                                        decoration: const InputDecoration(
                                          labelText: 'vitalik.com',
                                          focusedBorder:OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white)
                
                                          ) ,
                                          border: OutlineInputBorder(),
                                        ),
                                        cursorColor: Colors.white,
                                      ),
                                    ),
                                  ),
                
                                  //Address
                                  Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),child: Text('Address',style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                                  Theme(
                                    data: ThemeData.dark(),
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                      height: 50,
                                      width:double.infinity ,
                                      child: TextFormField(
                                        keyboardType: TextInputType.streetAddress,
                                        controller: textControllerAddress,
                                        decoration: const InputDecoration(
                                          labelText: 'Los ANgeles,USA',
                                          focusedBorder:OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white)
                
                                          ) ,
                                          border: OutlineInputBorder(),
                                        ),
                                        cursorColor: Colors.white,
                                      ),
                                    ),
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
                  body: Container(
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
                        if (widget.newResumeMdoel.education.isEmpty ?? true)
                          SizedBox(
                            width: double.infinity,
                            key: const ValueKey('empty'),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 170),
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
                          )
                        else
                          for (int index = 0; index < widget.newResumeMdoel.education.length; index++)
                            Container(
                              key: ValueKey(widget.newResumeMdoel.education[index].schoolTitle),
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
                                              Text(
                                                widget.newResumeMdoel.education[index].schoolTitle,
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, top: 10),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    border: Border.all(color: Colors.white60),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: GestureDetector(
                                                    onLongPress: () {
                                                      // Handle long press
                                                    },
                                                    child: IconButton(
                                                      icon: const Icon(
                                                        Icons.more_vert,
                                                        color: Colors.white,
                                                        size: 12,
                                                      ),
                                                      onPressed: () {
                                                        Education_dot(index);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                  Text(
                                                    widget.newResumeMdoel.education[index].major,
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                  Text(
                                                    widget.newResumeMdoel.education[index].to.toString(),
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(color: Colors.white60),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: IconButton(
                                                  icon: const Icon(
                                                    CupertinoIcons.arrow_up_arrow_down,
                                                    color: Colors.blue,
                                                    size: 15,
                                                  ),
                                                  onPressed: () {
                                                    // Handle reorder button press
                                                    // You need to implement reordering logic here
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                                      child: Text(
                                        widget.newResumeMdoel.education[index].schoolTitle ?? ' ',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
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
                        width: double.infinity,
                        key: const ValueKey('empty'),
                        margin: const EdgeInsets.only(top: 0),
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
                              key: ValueKey('experience_$index'), // Unique key based on index
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
                                                  Text(
                                                    widget.newResumeMdoel.experience[index].company ?? '',
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, top: 10),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    border: Border.all(color: Colors.white60),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.more_vert,
                                                      color: Colors.white,
                                                      size: 12,
                                                    ),
                                                    onPressed: () {
                                                     setState(() {
                                                       experience_dot(index);
                                                       update();
                                                     });
                                                     update();
                                                    },
                                                  ),
                                                ),
                                              ),
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
                                                  Row(
                                                    children: [
                                                      Text(
                                                        widget.newResumeMdoel.experience[index].position ?? '',
                                                        style: const TextStyle(color: Colors.white60, fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(color: Colors.white60),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: IconButton(
                                                  icon: const Icon(
                                                    CupertinoIcons.arrow_up_arrow_down,
                                                    color: Colors.blue,
                                                    size: 15,
                                                  ),
                                                  onPressed: () {
                                                    // Handle reorder button press
                                                    // You need to implement reordering logic here
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                                      child: Text(
                                        widget.newResumeMdoel.experience[index].description ?? ' ',
                                        style: const TextStyle(color: Colors.white),
                                      ),
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
                          child: ReorderableListView(
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
                              if (widget.newResumeMdoel.certifications.isEmpty)
                                Container(
                                  width: double.infinity,
                                  key: const ValueKey('empty'),
                                  margin: const EdgeInsets.only(top: 170),
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
                                )
                              else
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
                                                  color: const Color(0xFF454545),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      widget.newResumeMdoel.certifications[index].certificationName ?? '',
                                                      style: const TextStyle(color: Colors.white),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10, top: 10),
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                          color: Colors.black,
                                                          border: Border.all(color: Colors.white60),
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        child: GestureDetector(
                                                          onLongPress: () {
                                                            // Handle long press
                                                          },
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons.more_vert,
                                                              color: Colors.white,
                                                              size: 12,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                certification_edit(index);
                                                              });
                                                            },
                                                          ),
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
                            ],
                          )

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
                  body: Container(
                    color: Colors.black,
                    child: ReorderableListView(
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
                        if (widget.newResumeMdoel.skills.isEmpty)
                          SizedBox(
                            width: double.infinity,
                            key: const ValueKey('empty'),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 170),
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
                                  'No skills added',
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          )
                        else
                          for (var index = 0; index < widget.newResumeMdoel.skills.length; index++)
                            Container(
                              key: ValueKey(widget.newResumeMdoel.skills[index]),
                              color: Colors.black,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Container(
                                      width: double.infinity,
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF454545),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                widget.newResumeMdoel.skills[index].skillName ?? '',
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, top: 10),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    border: Border.all(color: Colors.white60),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: GestureDetector(
                                                    onLongPress: () {
                                                      // Handle long press
                                                    },
                                                    child: IconButton(
                                                      icon: const Icon(
                                                        Icons.more_vert,
                                                        color: Colors.white,
                                                        size: 12,
                                                      ),
                                                      onPressed: () {
                                                        showModalBottomSheet(
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
                                                                            rename_skill(index);
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
                                                                            widget.newResumeMdoel.skills.removeAt(index);
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
                                                                      const Divider(height: 1, color: Colors.white24),
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                                                        child: const ListTile(
                                                                          title: Text(
                                                                            'Cancel',
                                                                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                                                                            textAlign: TextAlign.center,
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
                                                      },
                                                    ),
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
                          ? SizedBox(
                        width: double.infinity,
                        key: const ValueKey('empty'),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 0),
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
                              'No languages added',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      )
                          : ReorderableListView(
                        onReorder: (int oldIndex, int newIndex) {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          setState(() {
                            resumeViewModel.getLength(widget.index);
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
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF454545),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                widget.newResumeMdoel.languages[index].language ?? '',
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, top: 10),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    border: Border.all(color: Colors.white60),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: GestureDetector(
                                                    onLongPress: () {
                                                      // Handle long press
                                                    },
                                                    child: IconButton(
                                                      icon: const Icon(
                                                        Icons.more_vert,
                                                        color: Colors.white,
                                                        size: 12,
                                                      ),
                                                      onPressed: () {
                                                        showModalBottomSheet(
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
                                                                            widget.newResumeMdoel.languages.removeAt(index);
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
                                                                      const Divider(height: 1, color: Colors.white24),
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                                                        child: const ListTile(
                                                                          title: Text(
                                                                            'Cancel',
                                                                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                                                                            textAlign: TextAlign.center,
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
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                   handleTap(index);
                                 },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                          children:
                                          [
                                            Container(

                                            margin: const EdgeInsets.only(top: 20),
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: AssetImage(photo[index]['image']??' ',),
                                                  fit:BoxFit.fitHeight
                                              ),
                                            ),
                                          ),
                                            Positioned(
                                              top: 170,
                                              width: 150,
                                              child: Container(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [Colors.black, Colors.transparent],
                                                    stops: [0.0, 1.0],
                                                  ),
                                                ),
                                                child: Column(
                                                  children:
                                                  [
                                                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children:
                                                    [
                                                      Text(photo[index]['title']??'',style: const TextStyle(color: Colors.white),),
                                                      const Icon(CupertinoIcons.profile_circled,color: Colors.orange,size: 15,),
                                                    ],
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            )

                                          ]
                                      ),
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

  void handleTap(int index) {
    if (index.isEven) {
      createPdf_B_W(widget.newResumeMdoel);
    } else {
      createPdf_blue(widget.newResumeMdoel);
    }
  }

  Future _pickImageFromGallery() async{
    final returnedImage= await ImagePicker().pickImage(source: ImageSource.gallery);
    setState((){

      _select=File(returnedImage!.path);
      widget.newResumeMdoel.profile_image=_select;
    });
  }
  Future _pickImageFromCamera() async{
    final returnedImage= await ImagePicker().pickImage(source: ImageSource.camera);
    setState((){
      _select=File(returnedImage!.path);
      widget.newResumeMdoel.profile_image=_select;
    });
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
                  TextButton(onPressed: (){_pickImageFromGallery();},style: TextButton.styleFrom(padding: EdgeInsets.zero,) ,child: const ListTile(leading: Icon(FontAwesomeIcons.image,color: Colors.white,),title: Text('Gallery',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),),
                  const Divider(height: 1,color: Colors.white24,),
                  TextButton(onPressed: (){_pickImageFromCamera();}, style: TextButton.styleFrom(padding: EdgeInsets.zero,),child: const ListTile(leading: Icon(CupertinoIcons.camera,color: Colors.white,),title: Text('Camera',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),),
                ],
              ),
            ),
          );

        }
    );
  }

  //work
  Future EducationSheet_edit(index)
  {

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
                  padding: const EdgeInsets.only(bottom: 40),
                  decoration: const BoxDecoration(
                    color: Color(0xFF454545),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Text(
                          'Which School did you attend',
                          style: TextStyle(color: text, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Theme(
                        data: ThemeData.dark(),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: textControllerSchoolTitle,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Text(
                          'Major',
                          style: TextStyle(color: text, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Theme(
                        data: ThemeData.dark(),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: textControllerMajor,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Text(
                          'From',
                          style: TextStyle(color: text, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Theme(
                              data: ThemeData.dark(),
                              child: Container(
                                margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                                height: 50,
                                width: (double.infinity / 2),
                                child: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  controller: textControllerEduFrom,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  cursorColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Theme(
                              data: ThemeData.dark(),
                              child: Container(
                                margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                                height: 50,
                                width: (double.infinity / 2),
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),

                                  ],
                                  enabled: !Cdate,
                                  keyboardType: TextInputType.datetime,
                                  controller: textControllerEduTo,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  cursorColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 10),
                            child: const Text(
                              'Present',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
                      Container(
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if(Cdate)
                                {
                              widget.newResumeMdoel.education[index].schoolTitle=textControllerSchoolTitle.text;
                              widget.newResumeMdoel.education[index].major=textControllerMajor.text;
                              widget.newResumeMdoel.education[index].to='PRESENT';
                              widget.newResumeMdoel.education[index].from=textControllerEduFrom.text;}

                              else
                                {
                                  widget.newResumeMdoel.education[index].schoolTitle=textControllerSchoolTitle.text;
                                  widget.newResumeMdoel.education[index].major=textControllerMajor.text;
                                  widget.newResumeMdoel.education[index].to=textControllerEduTo.text;
                                  widget.newResumeMdoel.education[index].from=textControllerEduFrom.text;
                                }
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Save', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
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
                        EducationSheet_edit(index);
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
                    onPressed: () {setState(() {
                      widget.newResumeMdoel.education.removeAt(index);

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
                  const Divider(height: 1,color: Colors.white24,),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const ListTile(
                      title: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
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
    final _formKey = GlobalKey<FormState>();

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
                  padding: const EdgeInsets.only(bottom: 40),
                  decoration: const BoxDecoration(
                    color: Color(0xFF454545),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Text(
                          'Which School did you attend',
                          style: TextStyle(color: text, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Theme(
                        data: ThemeData.dark(),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'School cannot be empty';
                              }
                              return null;
                            },
                            controller: textControllerSchoolTitle,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Text(
                          'Major',
                          style: TextStyle(color: text, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Theme(
                        data: ThemeData.dark(),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Major cannot be empty';
                              }
                              return null;
                            },
                            controller: textControllerMajor,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Text(
                          'From',
                          style: TextStyle(color: text, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Theme(
                              data: ThemeData.dark(),
                              child: Container(
                                margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                                height: 50,
                                width: (double.infinity / 2),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'From cannot be empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.datetime,
                                  controller: textControllerEduFrom,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  cursorColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Theme(
                              data: ThemeData.dark(),
                              child: Container(
                                margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                                height: 50,
                                width: (double.infinity / 2),
                                child: TextFormField(
                                enabled: !Cdate,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'To cannot be empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.datetime,
                                  controller: textControllerEduTo,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  cursorColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 10),
                            child: const Text(
                              'Present',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          FlutterSwitch(
                            width: 50,
                            activeIcon: const Icon(CupertinoIcons.check_mark),
                            value: Cdate,
                            activeColor: Colors.blue,
                            showOnOff: false,
                            onToggle: (val)
                            {
                              setState(() {
                                Cdate = val;
                              });
                            },
                          ),
                          const SizedBox(width: 150),

                        ],
                      ),
                      const SizedBox(height: 30,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              setState(() {
                                if (Cdate)
                                  widget.newResumeMdoel.education.add(Education(
                                      schoolTitle: textControllerSchoolTitle
                                          .text,
                                      major: textControllerMajor.text,
                                      from: textControllerEduFrom.text,
                                      to: 'PRESENT'));
                                else
                                  widget.newResumeMdoel.education.add(Education(
                                      schoolTitle: textControllerSchoolTitle
                                          .text,
                                      major: textControllerMajor.text,
                                      from: textControllerEduFrom.text,
                                      to: textControllerEduTo.text));

                                update();
                              });
                            }
                            textControllerSchoolTitle.clear();
                            textControllerMajor.clear();
                            textControllerEduFrom.clear();
                            textControllerEduTo.clear();
                            update();
                            Navigator.pop(context);
                          },
                          child: const Text('Save', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


  Future SkillSheet() {
    final textControllerSkillName = TextEditingController();
    final _formKey = GlobalKey<FormState>();

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
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: const Text(
                          'Skill',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Theme(
                        data: ThemeData.dark(),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: textControllerSkillName,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
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
                            if (_formKey.currentState?.validate() ?? false) {
                              setState(() {
                                widget.newResumeMdoel.skills.add(
                                  Skill(skillName: textControllerSkillName.text),
                                );
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
        );
      },
    );
  }


  Future lanuageSheet() {
    final textControllerLanguage = TextEditingController();
    final textControllerLevel = TextEditingController();
    final _formKey = GlobalKey<FormState>();

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
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: const Text(
                          'Language',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Theme(
                        data: ThemeData.dark(),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: textControllerLanguage,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Language field cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: const Text(
                          'Level (In percentage)',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Theme(
                        data: ThemeData.dark(),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            keyboardType: TextInputType.number,
                            controller: textControllerLevel,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Level field cannot be empty';
                              }
                              final int? level = int.tryParse(value);
                              if (level == null || level < 0 || level > 100) {
                                return 'Please enter a value between 0 and 100';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (int.parse(value) >= 100) {
                                  textControllerLevel.text = "100";
                                }
                              }
                            },
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
                            setState(() {

                            });
                            if (_formKey.currentState?.validate() ?? false) {
                              setState(() {
                                widget.newResumeMdoel.languages.add(
                                  Language(
                                    language: textControllerLanguage.text,
                                    level: textControllerLevel.text,
                                  ),
                                );
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
        );
      },
    );
  }


  Future certificationSheet() {
    final _formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
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
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Text(
                          'Certification',
                          style: TextStyle(color: text, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Theme(
                        data: ThemeData.dark(),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: textControllerCertificationTitle,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
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
                            if (_formKey.currentState?.validate() ?? false) {
                              setState(() {
                                widget.newResumeMdoel.certifications.add(
                                  Certification(certificationName: textControllerCertificationTitle.text),
                                );
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


  Future certification_edit(index) {
    final textControllerCertificationName = TextEditingController(
      text: widget.newResumeMdoel.certifications[index].certificationName,
    );
    final _formKey = GlobalKey<FormState>();

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
          child: FractionallySizedBox(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF454545),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(
                            controller: textControllerCertificationName,
                            decoration: const InputDecoration(
                              labelText: 'Certification Name',
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Certification name cannot be empty';
                              }
                              return null;
                            },
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
                            if (_formKey.currentState?.validate() ?? false) {
                              setState(() {
                                widget.newResumeMdoel.certifications[index] = Certification(
                                  certificationName: textControllerCertificationName.text,
                                );
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
                      const Divider(height: 1, color: Colors.white24),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.newResumeMdoel.certifications.removeAt(index);
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
                      const Divider(height: 1, color: Colors.white24),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: const ListTile(
                          title: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
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
  }

  Future experienceSheet() {
    final textControllerCompany = TextEditingController();
    final textControllerPosition = TextEditingController();
    final textControllerLocation = TextEditingController();
    final textControllerEFrom = TextEditingController();
    final textControllerETo = TextEditingController();
    final textControllerDescription = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FractionallySizedBox(
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text('Company', style: TextStyle(color: text, fontWeight: FontWeight.bold)),
                          ),
                          Theme(
                            data: ThemeData.dark(),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: TextFormField(
                                controller: textControllerCompany,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Company cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text('Position', style: TextStyle(color: text, fontWeight: FontWeight.bold)),
                          ),
                          Theme(
                            data: ThemeData.dark(),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: TextFormField(
                                controller: textControllerPosition,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Position cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text('Location', style: TextStyle(color: text, fontWeight: FontWeight.bold)),
                          ),
                          Theme(
                            data: ThemeData.dark(),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: TextFormField(
                                controller: textControllerLocation,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Location cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text('From', style: TextStyle(color: text, fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Theme(
                                  data: ThemeData.dark(),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      controller: textControllerEFrom,
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                      cursorColor: Colors.white,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Start date cannot be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Theme(
                                  data: ThemeData.dark(),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: TextFormField(
                                      enabled: !Cdate,
                                      keyboardType: TextInputType.datetime,
                                      controller: textControllerETo,
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                      cursorColor: Colors.white,
                                      validator: (value) {
                                        if (!Cdate && (value == null || value.isEmpty)) {
                                          return 'End date cannot be empty if not present';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text('Description', style: TextStyle(color: text, fontWeight: FontWeight.bold)),
                          ),
                          Theme(
                            data: ThemeData.dark(),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: TextFormField(
                                controller: textControllerDescription,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Description cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20, right: 10),
                                child: const Text('Present', style: TextStyle(color: Colors.white)),
                              ),
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
                          const SizedBox(height: 30),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false)
                                {
                                  setState(() {
                                    if (Cdate) {
                                      widget.newResumeMdoel.experience.add(Experience(
                                        company: textControllerCompany.text,
                                        position: textControllerPosition.text,
                                        location: textControllerLocation.text,
                                        from: textControllerEFrom.text,
                                        to: 'PRESENT',
                                        description: textControllerDescription.text,
                                      ));
                                    } else {
                                      widget.newResumeMdoel.experience.add(Experience(
                                        company: textControllerCompany.text,
                                        position: textControllerPosition.text,
                                        location: textControllerLocation.text,
                                        from: textControllerEFrom.text,
                                        to: textControllerETo.text,
                                        description: textControllerDescription.text,
                                      ));
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
            );
          },
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

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FractionallySizedBox(
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text('Company', style: TextStyle(color: text, fontWeight: FontWeight.bold)),
                        ),
                        Theme(
                          data: ThemeData.dark(),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: TextFormField(
                              controller: textControllerCompany,
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              cursorColor: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text('Position', style: TextStyle(color: text, fontWeight: FontWeight.bold)),
                        ),
                        Theme(
                          data: ThemeData.dark(),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: TextFormField(

                              controller: textControllerPosition,
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              cursorColor: Colors.white,
                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text('Location', style: TextStyle(color: text, fontWeight: FontWeight.bold)),
                        ),
                        Theme(
                          data: ThemeData.dark(),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: TextFormField(

                              controller: textControllerLocation,
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              cursorColor: Colors.white,
                            ),
                          ),
                        ),


                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text('From - To', style: TextStyle(color: text, fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Theme(
                                data: ThemeData.dark(),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.datetime,
                                    controller: textControllerEFrom,
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                    cursorColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Theme(
                                data: ThemeData.dark(),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: TextFormField(
                                    enabled: !Cdate,
                                    keyboardType: TextInputType.datetime,
                                    controller: textControllerETo,
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                    cursorColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text('Description', style: TextStyle(color: text, fontWeight: FontWeight.bold)),
                        ),
                        Theme(

                          data: ThemeData.dark(),
                          child: Container(
                            height: 150,
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              expands: true,
                              maxLines: null,
                              minLines: null,
                              controller: textControllerDescription,
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              cursorColor: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20, right: 10),
                              child: const Text('Present', style: TextStyle(color: Colors.white)),
                            ),
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
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {

                              setState(() {
                                if(Cdate) {
                                  widget.newResumeMdoel.experience[index]
                                      .description =
                                      textControllerDescription.text;
                                  widget.newResumeMdoel.experience[index]
                                      .position = textControllerPosition.text;
                                  widget.newResumeMdoel.experience[index]
                                      .company = textControllerCompany.text;
                                  widget.newResumeMdoel.experience[index]
                                      .location = textControllerLocation.text;
                                  widget.newResumeMdoel.experience[index].from =
                                      textControllerEFrom.text;
                                  widget.newResumeMdoel.experience[index].to =
                                      'PRESENT';
                                }
                                else
                                  {
                                    widget.newResumeMdoel.experience[index]
                                        .description =
                                        textControllerDescription.text;
                                    widget.newResumeMdoel.experience[index]
                                        .position = textControllerPosition.text;
                                    widget.newResumeMdoel.experience[index]
                                        .company = textControllerCompany.text;
                                    widget.newResumeMdoel.experience[index]
                                        .location = textControllerLocation.text;
                                    widget.newResumeMdoel.experience[index].from =
                                        textControllerEFrom.text;
                                    widget.newResumeMdoel.experience[index].to =
                                        textControllerETo.text;

                                  }
                                update();

                              });
                              update();
                              Navigator.of(context)..pop()..pop();
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
                        widget.newResumeMdoel.experience.removeAt(index);
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
                  const Divider(height: 1,color: Colors.white24,),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const ListTile(
                      title: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
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

  Future rename_certi(int index) {
    final textControllerCertificationTitle = TextEditingController(text: widget.newResumeMdoel.certifications[index].certificationName);
    final _formKey = GlobalKey<FormState>();

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
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFF454545),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 5),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Enter Certification',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(
                            controller: textControllerCertificationTitle,
                            decoration: const InputDecoration(
                              labelText: 'Certification Title',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Certification title cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                setState(() {
                                  widget.newResumeMdoel.certifications[index].certificationName = textControllerCertificationTitle.text;
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

  Future rename_skill(int index) {
    final textControllerSkillName = TextEditingController(text: widget.newResumeMdoel.skills[index].skillName);
    final _formKey = GlobalKey<FormState>();

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
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFF454545),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 5),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Enter Skill',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(
                            controller: textControllerSkillName,
                            decoration: const InputDecoration(
                              labelText: 'Skill Name',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Skill name cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false)
                              {
                                setState(()
                                {
                                  widget.newResumeMdoel.skills[index].skillName = textControllerSkillName.text;
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


  Future rename_lang(int index) {
    final textControllerLanguage = TextEditingController(text: widget.newResumeMdoel.languages[index].language);
    final textControllerLevel = TextEditingController(text: widget.newResumeMdoel.languages[index].level);
    final _formKey = GlobalKey<FormState>();

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
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Enter Language',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(
                            controller: textControllerLanguage,
                            decoration: const InputDecoration(
                              labelText: 'Language',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Language cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Enter Level',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (int.parse(value) >= 100) {
                                  textControllerLevel.text = "100";
                                  textControllerLevel.selection = TextSelection.collapsed(offset: textControllerLevel.text.length);
                                }
                              }
                            },
                            controller: textControllerLevel,
                            decoration: const InputDecoration(
                              labelText: 'Level Percentage',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Level cannot be empty';
                              }
                              final intValue = int.tryParse(value);
                              if (intValue == null || intValue < 0 || intValue > 100) {
                                return 'Please enter a valid level (0-100)';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                setState(() {
                                  widget.newResumeMdoel.languages[index].language = textControllerLanguage.text;
                                  widget.newResumeMdoel.languages[index].level = textControllerLevel.text;
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
    final _formKey = GlobalKey<FormState>();

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
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFF454545),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Enter Language',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(
                            controller: textControllerLanguage,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Language cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                setState(() {
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
        );
      },
    );
  }

}


