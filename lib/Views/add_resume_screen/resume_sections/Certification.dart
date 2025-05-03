import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Models/model_resume.dart';
import '../../../Utility/widgets/TextFieldValidator.dart';
import '../../../Utility/widgets/additionalOptionsButton.dart';
import '../../../ViewModels/resume_view_model.dart';



class CertificationScreen extends StatefulWidget {
  final ResumeModel newResumeMdoel;
final index;
Color borderColorContact;
  CertificationScreen({super.key, required this.newResumeMdoel, this.index,required this.borderColorContact});


@override
  State<CertificationScreen> createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
  TextEditingController textControllerCertificationTitle=TextEditingController();
  @override
  void dispose() {

    textControllerCertificationTitle.dispose();
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

}
