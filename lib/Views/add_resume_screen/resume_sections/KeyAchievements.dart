import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../Models/model_resume.dart';
import '../../../Utility/widgets/TextFieldValidator.dart';
import '../../../Utility/widgets/additionalOptionsButton.dart';
import '../../../ViewModels/resume_view_model.dart';

class KeyAchievementsScreen extends StatefulWidget {
  final ResumeModel newResumeMdoel;
  final index;
  Color borderColorContact;
  KeyAchievementsScreen({super.key, required this.newResumeMdoel, this.index,required this.borderColorContact});


  @override
  State<KeyAchievementsScreen> createState() => _KeyAchievementsScreenState();
}

class _KeyAchievementsScreenState extends State<KeyAchievementsScreen> {

  TextEditingController textControllerAchievements=TextEditingController();
  TextEditingController textControllerDescription=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              AchievmentSheet();
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
                      FontAwesomeIcons.trophy,
                      color: Colors.blue,
                      size: 80,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'No Achievements added',
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
              final item = widget.newResumeMdoel.achievements.removeAt(oldIndex);
              widget.newResumeMdoel.achievements.insert(newIndex, item);
            });
          },
          children: [
            for (int index = 0; index < widget.newResumeMdoel.achievements.length; index++)
              Container(
                key: ValueKey('achievments$index'), // Unique key based on index
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
                                    widget.newResumeMdoel.achievements[index].name ?? '',
                                    style: const TextStyle(color: Colors.white),
                                    maxLines:1,
                                    overflow:TextOverflow.ellipsis

                                ),),

                                AdditonalOptions(onPressed: () { AchievementDot(index); },)
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 35),
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

                                    Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                                      child: Text(
                                        widget.newResumeMdoel.achievements[index].Descirption ?? '',
                                        style: const TextStyle(color: Colors.white, fontSize: 10),overflow: TextOverflow.ellipsis,maxLines: 1,
                                      ),
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
  Future AchievmentSheet() {
    final textControllerAcievements = TextEditingController();
    final textControllerDescription = TextEditingController();
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
                          labelText: 'Achievement',
                          controller: textControllerAcievements, hintText: 'Market Expansion',
                          onChanged: (String ) {  },

                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Achievement cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFieldValidate(
                          labelText: 'Description',
                          controller: textControllerDescription, hintText: 'Identified untapped..',
                          onChanged: (value ) { },

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Description field cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.name,

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
                                  resumeViewModel.addAchievments(widget.index,
                                    Achievements(
                                      name: textControllerAcievements.text,
                                      Descirption: textControllerDescription.text,
                                    ),
                                  );

                                  resumeViewModel.updateFullness(widget.newResumeMdoel);
                                });
                                textControllerAcievements.clear();
                                textControllerDescription.clear();
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
  Future AchievementDot(index)
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
                        rename_achivement(index);
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
                        resumeViewModel.deleteAchievments(widget.index,index);
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


  Future rename_achivement(int index) {
    final textControllerAchievments = TextEditingController(text: widget.newResumeMdoel.achievements[index].name);
    final textControllerDescriptions = TextEditingController(text: widget.newResumeMdoel.achievements[index].Descirption);
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

                        CustomTextFieldValidate(
                          labelText: 'Achievement',
                          controller: textControllerAchievments, hintText: 'Market Expansion',
                          onChanged: (String ) {  },

                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Achievement cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFieldValidate(
                          labelText: 'Description',
                          controller: textControllerDescriptions, hintText: 'Identified untapped..',
                          onChanged: (value ) {  },
                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Description cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.name,

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
                                  final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
                                  resumeViewModel.editAchievments(widget.index,index,Achievements( name:textControllerAchievments.text ,Descirption:textControllerDescriptions.text ));
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


  void update()
  {
    setState(() {

    });
  }
}
