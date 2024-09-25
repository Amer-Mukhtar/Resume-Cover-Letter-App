
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
import '../../../Utility/widgets/textFieldSummaryNON.dart';

class ExperienceScreen extends StatefulWidget {

  final ResumeModel newResumeMdoel;
  final index;
  Color borderColorContact;
  ExperienceScreen({super.key, required this.newResumeMdoel, this.index,required this.borderColorContact});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  bool Cdate=false;
  TextEditingController textControllerCompany=TextEditingController();
  TextEditingController textControllerPosition=TextEditingController();
  TextEditingController textControllerLocation=TextEditingController();
  TextEditingController textControllerEFrom=TextEditingController();
  TextEditingController textControllerETo=TextEditingController();
  TextEditingController textControllerDescription=TextEditingController();

  @override
  void dispose() {
    textControllerCompany.dispose();
    textControllerPosition.dispose();
    textControllerLocation.dispose();
    textControllerEFrom.dispose();
    textControllerETo.dispose();
    textControllerDescription.dispose();
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
    );
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
                                child: CustomTextFieldValidateLimit(
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
                                child: CustomTextFieldValidateLimit(
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
                                        to: textControllerETo.text,
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

  void update()
  {
    setState(() {

    });
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
                                  child: CustomTextFieldValidateLimit(
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
                                  child: CustomTextFieldValidateLimit(
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
}
