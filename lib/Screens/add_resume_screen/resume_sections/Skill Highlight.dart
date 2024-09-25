import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_view_model.dart';

import '../../../Models/model_resume.dart';
import '../../../Utility/widgets/TextFieldValidator.dart';
import '../../../Utility/widgets/additionalOptionsButton.dart';

class SkillHighlightScreen extends StatefulWidget {
  final ResumeModel newResumeMdoel;
  final index;
  Color borderColorContact;
  SkillHighlightScreen({super.key, required this.newResumeMdoel, this.index,required this.borderColorContact});


  @override
  State<SkillHighlightScreen> createState() => _SkillHighlightScreenState();
}

class _SkillHighlightScreenState extends State<SkillHighlightScreen> {
  TextEditingController textControllerSkillName=TextEditingController();


  @override
  void dispose() {

    textControllerSkillName.dispose();

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
                                  children:
                                  [
                                    const Text(
                                      'Level',
                                      style: TextStyle(color: Colors.white60, fontSize: 14),
                                    ),
                                    Text("${widget.newResumeMdoel.skills[index].level}" ,
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
    final textControllerSkilllevel = TextEditingController(text: widget.newResumeMdoel.skills[index].level.toString());

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
                            }, keyboardType: TextInputType.phone,
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
                                    final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                    resumeViewModel.editSkill(widget.index,index,Skill(skillName: textControllerSkillName.text,level: double.tryParse(textControllerSkilllevel.text) ?? 0.0),);
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
                          }, keyboardType: TextInputType.phone,
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
                                  resumeViewModel.addSkill(widget.index,Skill(skillName: textControllerSkillName.text,level: double.tryParse(textControllerSkillLevel.text) ?? 0.0),);
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

  void update()
  {
    setState(() {

    });
  }
}
