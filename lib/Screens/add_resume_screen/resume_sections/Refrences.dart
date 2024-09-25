import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_view_model.dart';


import '../../../Models/model_resume.dart';
import '../../../Utility/widgets/TextFieldValidator.dart';
import '../../../Utility/widgets/additionalOptionsButton.dart';

class RefrencesScreen extends StatefulWidget {
  final ResumeModel newResumeMdoel;
  final index;
  Color borderColorContact;
  RefrencesScreen({super.key, required this.newResumeMdoel, this.index,required this.borderColorContact});


  @override
  State<RefrencesScreen> createState() => _RefrencesScreenState();
}

class _RefrencesScreenState extends State<RefrencesScreen> {



  TextEditingController textControllerLanguage=TextEditingController();
  TextEditingController textControllerLevel=TextEditingController();

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
                        CustomTextFieldValidate(
                          labelText: 'Name',
                          controller: textControllerRName, hintText: 'Vitalik',
                          onChanged: (String ) {  },

                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Name cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),

                        const SizedBox(height: 20,),
                        //postition
                        CustomTextFieldValidate(
                          labelText: 'Position',
                          controller: textControllerRPostition, hintText: 'Manager',
                          onChanged: (String ) {  },

                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Position cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),


                        const SizedBox(height: 20,),
                        //company

                        CustomTextFieldValidate(
                          labelText: 'Company',
                          controller: textControllerRCompany, hintText: 'Something Inc',
                          onChanged: (String ) {  },

                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Company cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),

                        //email

                        const SizedBox(height: 20,),

                        CustomTextFieldValidate(
                          labelText: 'Email',
                          controller: textControllerREmail, hintText: 'vitalik@gmail.com',
                          onChanged: (String ) {  },

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
                          }, keyboardType: TextInputType.text,
                        ),


                        const SizedBox(height: 20,),

                        //phone
                        CustomTextFieldValidate(
                          labelText: 'Phone',
                          controller: textControllerRPhone, hintText: '+7783420148392',
                          onChanged: (String ) {  },
                            keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone field cannot be empty';
                            }
                            return null;
                          },inputFormatter: [LengthLimitingTextInputFormatter(15),],
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
                        //name
                        CustomTextFieldValidate(
                          labelText: 'Name',
                          controller: textControllerRName, hintText: 'Vitalik',
                          onChanged: (String ) {  },

                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Name cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),

                        const SizedBox(height: 20,),
                        //postition
                        CustomTextFieldValidate(
                          labelText: 'Position',
                          controller: textControllerRPostition, hintText: 'Manager',
                          onChanged: (String ) {  },

                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Position cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),


                        const SizedBox(height: 20,),
                        //company

                        CustomTextFieldValidate(
                          labelText: 'Company',
                          controller: textControllerRCompany, hintText: 'Something Inc',
                          onChanged: (String ) {  },

                          validator: (value) {
                            if (value == null || value.isEmpty)
                            {
                              return 'Company cannot be empty';
                            }
                            return null;
                          }, keyboardType: TextInputType.text,
                        ),

                        //email

                        const SizedBox(height: 20,),

                        CustomTextFieldValidate(
                          labelText: 'Email',
                          controller: textControllerREmail, hintText: 'vitalik@gmail.com',
                          onChanged: (String ) {  },

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
                          }, keyboardType: TextInputType.text,
                        ),


                        const SizedBox(height: 20,),

                        //phone
                        CustomTextFieldValidate(
                          labelText: 'Phone',
                          controller: textControllerRPhone, hintText: '+7783420148392',
                          onChanged: (String ) {  },
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone field cannot be empty';
                            }

                            return null;
                          },inputFormatter: [LengthLimitingTextInputFormatter(15),],
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
}
