

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_view_model.dart';

import '../../../Models/model_resume.dart';
import '../../../Utility/widgets/TextFieldLimit.dart';
import '../../../Utility/widgets/TextFieldValidator.dart';
import '../../../Utility/widgets/additionalOptionsButton.dart';
import '../../../Utility/widgets/reorderButton.dart';

class EducationScreen extends StatefulWidget {
  final ResumeModel newResumeMdoel;
  final index;
  Color borderColorContact;
  EducationScreen({super.key, required this.newResumeMdoel, this.index,required this.borderColorContact});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {

  TextEditingController textControllerSchoolTitle=TextEditingController();
  TextEditingController textControllerMajor=TextEditingController();
  TextEditingController textControllerEduFrom=TextEditingController();
  TextEditingController textControllerEduTo=TextEditingController();
  bool Cdate=false;

  @override
  void dispose() {
    textControllerSchoolTitle.dispose();
    textControllerMajor.dispose();
    textControllerEduFrom.dispose();
    textControllerEduTo.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  void update()
  {
    setState(() {

    });
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
                              child: CustomTextFieldValidateLimit(
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
                              child: CustomTextFieldValidateLimit(
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
                                update();

                                textControllerSchoolTitle.clear();
                                textControllerMajor.clear();
                                textControllerEduFrom.clear();
                                textControllerEduTo.clear();
                                Navigator.pop(context);
                              }
                              update();
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
                                  child: CustomTextFieldValidateLimit(

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
                                  child: CustomTextFieldValidateLimit(
                                    enable:  !Cdate,
                                    labelText: 'To',
                                    controller: textControllerEduTo,
                                    inputFormatter: [
                                      LengthLimitingTextInputFormatter(4)],
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

                                  textControllerSchoolTitle.clear();
                                  textControllerMajor.clear();
                                  textControllerEduFrom.clear();
                                  textControllerEduTo.clear();
                                  update();
                                  Navigator.pop(context);
                                }
                                update();
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

}
