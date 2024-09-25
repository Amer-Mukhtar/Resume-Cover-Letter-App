import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Models/model_resume.dart';
import '../../../Utility/widgets/AlertSnackBar.dart';
import '../../templates/black_white.dart';
import '../../templates/blue.dart';
import '../resume_2.dart';

class TemplateScreen extends StatefulWidget {
  Resume_Details resume_details;
  final ResumeModel newResumeMdoel;
  final index;
  Color borderColorContact;
  Color borderColorIntro;
  final TabController tabController;
  TemplateScreen({super.key, required this.newResumeMdoel, this.index,required this.borderColorContact,required this.borderColorIntro,required this.tabController,required this.resume_details});


  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  List photo= [
    {'image':'assets/images/template1.png',
      'title':'Black & White'},
    {'image':'assets/images/template2.png',
      'title': 'Black & Blue'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  widget.tabController.animateTo(0);
                }


                else if(widget.newResumeMdoel.contact!.email.isEmpty||widget.newResumeMdoel.contact!.phoneNumber.isEmpty||widget.newResumeMdoel.contact!.website.isEmpty||widget.newResumeMdoel.contact!.address.isEmpty)
                {
                  _handleTabChange(1);
                  widget.tabController.animateTo(1);

                }
                else if(widget.newResumeMdoel.skills.isEmpty)
                {

                  _handleTabChange(5);
                  widget.tabController.animateTo(5);
                  print('skills');

                }
                else if(widget.newResumeMdoel.languages.isEmpty)
                {

                  _handleTabChange(6);
                  widget.tabController.animateTo(6);
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

    );
  }

  void _handleTabChange(int index) {
    print('herwe');
    if (index == 0)
    {
      setState(()
      {

        widget.borderColorIntro = Colors.red;
        ScaffoldMessenger.of(context).showSnackBar(
          AlertSnackBar('Required fields cannot be left empty.',Colors.red,Colors.white),
        );

      });

      Future.delayed(Duration(seconds: 3), ()
      {
        setState(()
        {
          widget.borderColorIntro = Colors.grey;
        });
      });
    }
    else if (index == 1)
    {
      setState(()
      {
        widget.borderColorContact = Colors.red;
        ScaffoldMessenger.of(context).showSnackBar(
          AlertSnackBar('Required fields cannot be left empty.',Colors.red,Colors.white),
        );
      });

      Future.delayed(Duration(seconds: 3), () {
        setState(()
        {
          widget.borderColorContact = Colors.grey;
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


  void handleTap(int index, BuildContext context) {
    if (widget.newResumeMdoel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resume model is null!')),
      );
      return;
    }


    final GlobalKey<State> dialogKey = GlobalKey<State>();

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
}
