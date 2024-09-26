
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:resume_maker/Models/model_resume.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_sections/Certification.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_sections/Experience.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_sections/Intro.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_sections/KeyAchievements.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_sections/Languages.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_sections/Refrences.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_sections/Skill%20Highlight.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_view_model.dart';
import '../../Utility/widgets/AlertSnackBar.dart';
import '../templates/black_white.dart';
import '../templates/blue.dart';
import '../templates/grey.dart';
import '../templates/resume_5.dart';
import '../templates/simple.dart';
import 'resume_sections/Contact.dart';
import 'resume_sections/Education.dart';



String _errorText='';

List photo= [
  {'image':'assets/images/template1.png',
    'title':'Black & White'},
  {'image':'assets/images/template2.png',
    'title': 'Black & Blue'},
  {'image':'assets/images/resume_1.png',
    'title': 'Simple'
  },
  {'image':'assets/images/resume_4.png',
    'title': 'Grey'
  },
  {'image':'assets/images/resume_5.png',
    'title': 'Blue'
  },
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


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
 }

 late final ResumeViewModelProvider view;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  Color _borderColorIntro = Colors.grey;
  Color _borderColorContact = Colors.grey;

  void _handleTabChange(int index, ResumeState resumeState) {
    if (index == 0) {
      resumeState.updateBorderColorIntro(Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(
        AlertSnackBar('Required fields cannot be left empty.', Colors.red, Colors.white),
      );
      Future.delayed(const Duration(seconds: 3), () {
        resumeState.updateBorderColorIntro(Colors.grey);
      });
    } else if (index == 1) {
      resumeState.updateBorderColorContact(Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(
        AlertSnackBar('Required fields cannot be left empty.', Colors.red, Colors.white),
      );
      Future.delayed(const Duration(seconds: 3), () {
        resumeState.updateBorderColorContact(Colors.grey);
      });
    }
  }


  File ? _select;


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
                _tabController.animateTo((_tabController.index + 1) % 10);
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
        body: Consumer<ResumeState>(
          builder: (context, resumeState, child)
          { return Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              child: DefaultTabController(
                length: 10,
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
                              Icon( FontAwesomeIcons.trophy,size: 20,),
                              SizedBox(width: 10,),
                              Text('Key Achievements')
                            ],),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: const Row(children: [
                              Icon(CupertinoIcons.doc,size: 20,),
                              SizedBox(width: 10,),
                              Text('Templates')
                            ],),
                          ),
                        ),

          
          
                      ]
                  ),
                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children:
                      [
                        ///Intro
                        IntroScreen(newResumeMdoel: widget.newResumeMdoel,index: widget.index, borderColorIntro:  resumeState.borderColorIntro,),
          
                        ///Contact
                        ContactScreen(newResumeMdoel: widget.newResumeMdoel,index: widget.index, borderColorContact:  resumeState.borderColorContact),
          
                        //Education
                        EducationScreen(newResumeMdoel: widget.newResumeMdoel,index: widget.index, borderColorContact:  resumeState.borderColorContact),
          
                        //Experience
                        ExperienceScreen(newResumeMdoel: widget.newResumeMdoel,index: widget.index, borderColorContact:  resumeState.borderColorContact)
                    ,
                        //Certification
                        CertificationScreen(newResumeMdoel: widget.newResumeMdoel,index: widget.index, borderColorContact:  resumeState.borderColorContact),
          
                        //Skill Highlight
                        SkillHighlightScreen(newResumeMdoel: widget.newResumeMdoel,index: widget.index, borderColorContact:  resumeState.borderColorContact),
          
                       //Languages
                        LanguageScreen(newResumeMdoel: widget.newResumeMdoel,index: widget.index, borderColorContact:  resumeState.borderColorContact),
          
                        //references
                        RefrencesScreen(newResumeMdoel: widget.newResumeMdoel, index: widget.index,borderColorContact:  resumeState.borderColorContact),

                        //key achievements
                        KeyAchievementsScreen(newResumeMdoel: widget.newResumeMdoel,index: widget.index, borderColorContact:  resumeState.borderColorContact),

                        ///template
                        Scaffold(
                          body: Container(
                            color: Colors.black,
                            child: GridView.builder
                              (
                              itemCount: photo.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,crossAxisSpacing: 0,mainAxisExtent: 250,
                              ),
                              itemBuilder: (context ,index)
          
                              {
                                return GestureDetector(
                                   onTap:  (){
          
                                     if (widget.newResumeMdoel.intro!.firstName.isEmpty ||
                                         widget.newResumeMdoel.intro!.lastName.isEmpty ||
                                         widget.newResumeMdoel.intro!.summary.isEmpty
                                     ) {
          
                                       _handleTabChange(0,resumeState);
                                       _tabController.animateTo(0);
                                     }
          
          
                                     else if(widget.newResumeMdoel.contact!.email.isEmpty||widget.newResumeMdoel.contact!.phoneNumber.isEmpty||widget.newResumeMdoel.contact!.website.isEmpty||widget.newResumeMdoel.contact!.address.isEmpty)
                                       {
                                         _handleTabChange(1,resumeState);
                                         _tabController.animateTo(1);
          
                                       }
                                     else if(widget.newResumeMdoel.skills.isEmpty)
                                     {
          
                                       _handleTabChange(5,resumeState);
                                       _tabController.animateTo(5);
                                       print('skills');
          
                                     }
                                     else if(widget.newResumeMdoel.languages.isEmpty)
                                     {
          
                                       _handleTabChange(6,resumeState);
                                       _tabController.animateTo(6);
                                     }
                                     else
                                     {
          
                                       handleTap(index, context);
                                     }
          
          
                                   },
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02,left:20 ),
                                        width: MediaQuery.of(context).size.width * 0.9,
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
                                            width: MediaQuery.of(context).size.width * 0.8,
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
          );}
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
        if (index==0)
          createPdf_B_W(widget.newResumeMdoel, 'preview', context);

        if (index==1)
        createPdf_blue(widget.newResumeMdoel,'preview', context);

        if (index==2)
          createPdf_simple(widget.newResumeMdoel,'preview', context);

        if (index==3)
          createPdf_grey(widget.newResumeMdoel,'preview', context);
        if (index==4)
          createPdf_template_5(widget.newResumeMdoel,'preview', context);

      } catch (e)
      {
        print('Error generating PDF: $e');
      }
    }

    // Start PDF generation
    generatePdf();
  }

}

class ResumeState extends ChangeNotifier {
  Color _borderColorIntro = Colors.grey;
  Color _borderColorContact = Colors.grey;

  Color get borderColorIntro => _borderColorIntro;
  Color get borderColorContact => _borderColorContact;

  void updateBorderColorIntro(Color color) {
    _borderColorIntro = color;
    notifyListeners();
  }

  void updateBorderColorContact(Color color) {
    _borderColorContact = color;
    notifyListeners();
  }
}

