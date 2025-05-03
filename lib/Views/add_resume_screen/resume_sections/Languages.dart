import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../Models/model_resume.dart';
import '../../../Utility/widgets/TextFieldValidator.dart';
import '../../../Utility/widgets/additionalOptionsButton.dart';
import '../../../ViewModels/resume_view_model.dart';

class LanguageScreen extends StatefulWidget {
  final ResumeModel newResumeMdoel;
  final index;
  Color borderColorContact;
  LanguageScreen({super.key, required this.newResumeMdoel, this.index,required this.borderColorContact});


  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  TextEditingController textControllerLanguage=TextEditingController();
  TextEditingController textControllerLevel=TextEditingController();
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
                                  final resumeViewModel = Provider.of<ResumeViewModelProvider>(context, listen: false);
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
              margin: const EdgeInsets.symmetric(horizontal: 10),
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

  void update()
  {
    setState(() {

    });
  }
}
