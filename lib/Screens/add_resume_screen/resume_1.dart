import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../Utility/widgets/TextFieldValidator.dart';
import 'resume_view_model.dart';

class Resume_List extends StatefulWidget {
  const Resume_List({super.key});

  @override
  State<Resume_List> createState() => _Resume_ListState();
}
class _Resume_ListState extends State<Resume_List> {
  TextEditingController textControllerTitle = TextEditingController();
  TextEditingController textControllerJob = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double lenght=MediaQuery.of(context).size.width -180;
    final resumeViewModelProvider = Provider.of<ResumeViewModelProvider>(context,  listen: false);


    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        height: 100,
        color: Colors.black87,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () {
            setState(() {
              resumeViewModelProvider.addNewResume(context, '', '-');
            });
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.plus, color: Colors.white),
                SizedBox(width: 5),
                Text(
                  'Add Resume',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      body:resumeViewModelProvider.resumes.isEmpty
          ? Container(
        width: double.infinity,
        alignment: Alignment.center,
        key: const ValueKey('emptyState'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          key: const ValueKey('emptyState'),
          children:
          [
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.grey.shade300,
                  ],
                ),
              ),
              child: const Icon(FontAwesomeIcons.boxOpen, color: Colors.white, size: 80),
            ),
            const SizedBox(height: 5),
            const Text('Nothing Here', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text('Looks like nothing is added yet', style: TextStyle(color: Colors.white60)),
          ],
        ),
      ) :ReorderableListView(
        scrollDirection: Axis.vertical,
        onReorder: (int oldIndex, int newIndex) {

          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
        },
        children: [

            for (int index = 0; index < resumeViewModelProvider.resumes.length; index++)
              Stack(
                key: ValueKey(resumeViewModelProvider.resumes[index]),
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    key: ValueKey(resumeViewModelProvider.resumes[index]),

                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white24,
                                width:1,

                              ),),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                //top-title
                                Container(
                                  padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF454545),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(9),
                                      topRight: Radius.circular(9),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        constraints: const BoxConstraints(maxWidth: 240),child: Text(
                                        resumeViewModelProvider.resumes[index]['title'] ?? 'No Title',
                                        style: const TextStyle(color: Colors.white),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),),


                                      Container(
                                        padding: EdgeInsets.all(0),
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border.all(color: Colors.white38),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          onPressed: ()
                                          {
                                            setState(() {
                                              _showCoverLetterOptions(context, index, resumeViewModelProvider);
                                            });

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                //bottom-job
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(left: 12,right: 21,top: 17,bottom: 17),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Job Title',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(color: Colors.white70, fontSize: 12),
                                              ),
                                              Row(children: [SizedBox(height: 5,)],),
                                              Row(children: [

                                                Container(constraints: const BoxConstraints(maxWidth: 170),child: Text(
                                                  resumeViewModelProvider.jobReturn(index),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                                ),)
                                              ],)
                                            ],
                                          ),
                                          Consumer<ResumeViewModelProvider>(
                                            builder: (context, resumeViewModelProvider, child) {
                                              final fullness = resumeViewModelProvider.resumes[index]['fullness'] / 100;
                                              return Center(
                                                child: Container(
                                                  height: 25,width: 25,
                                                  child: CircularProgressIndicator(
                                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                                                    value: fullness,
                                                    backgroundColor: Colors.white24,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //preview snapshot of resume
                  Consumer<ResumeViewModelProvider>(
                    builder: (context,resumeViewModelProvider,child){
                      return resumeViewModelProvider.getResumeSnapshot(index) != null
                          ? Positioned(
                        left:lenght,
                        top: 30,
                        child: Container(
                          key: ValueKey(resumeViewModelProvider.resumes[index]),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          height: 120,
                          width: 80,
                          child: Image.memory(
                            resumeViewModelProvider.getResumeSnapshot(index)!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                          : SizedBox.shrink();
                    },
                  )
                ],
              )
        ],
      ),
    );
  }
  Future enter_title_sheet(BuildContext context) {
    final resumeViewModelProvider = Provider.of<ResumeViewModelProvider>(context, listen: false);

    // Create a GlobalKey for the Form
    final formKey = GlobalKey<FormState>();

    // Controllers for the TextFormField widgets
    final TextEditingController textControllerTitle = TextEditingController();
    final TextEditingController textControllerJob = TextEditingController();

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF454545),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,  // Assign the key to the Form
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 0, right: 0, top: 10),
                          child: const Text(
                            'Title',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(
                            controller: textControllerTitle,
                            decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: 'New Resume',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 0, right: 0, top: 10),
                          child: const Text(
                            'Job',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextFormField(
                            controller: textControllerJob,
                            decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: 'Manager',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a job title';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(

                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: () {
                             setState(() {
                               if (formKey.currentState?.validate() ?? false)
                               {
                                 resumeViewModelProvider.addNewResume(context, textControllerTitle.text, textControllerJob.text);

                                 textControllerJob.clear();
                                 textControllerTitle.clear();
                                 Navigator.pop(context);
                                 Navigator.pop(context);
                               } else
                               {

                               }
                             });
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
  }


  void renameResume(BuildContext context, int index, ResumeViewModelProvider resumeViewModel) {
    // Create GlobalKey for the Form
    final formKey = GlobalKey<FormState>();

    // Controllers for the TextFormField widgets
    final TextEditingController renameController = TextEditingController();
    final TextEditingController renameControllerJob = TextEditingController();

    // Initialize controllers with current values
    renameController.text = resumeViewModel.resumes[index]['title'];
    renameControllerJob.text = resumeViewModel.jobReturn(index);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF454545),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFieldValidate(
                      labelText: 'Rename Resume',
                      controller: renameController,
                      hintText: 'New Resume',
                      onChanged: (String ) {  },
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                        {
                          return 'Please enter a resume title';
                        }
                        return null;
                      },
                    ),

                   SizedBox(height: 10,),
                    CustomTextFieldValidate(
                      labelText: 'Rename Job',
                      controller: renameControllerJob,
                      hintText: 'Manager',
                      onChanged: (String ) {  },
                      keyboardType: TextInputType.text,
                      validator:(value) {
                        if (value == null || value.isEmpty)
                        {
                          return 'Please enter a job title';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (formKey.currentState?.validate() ?? false) {
                              resumeViewModel.renameTitle(index, renameController.text, renameControllerJob.text);
                              renameController.clear();
                              renameControllerJob.clear();
                              Navigator.of(context)..pop()..pop();
                            } else {



                            }
                          });
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
  }


  void _showCoverLetterOptions(BuildContext context, int index, ResumeViewModelProvider resumeViewModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF454545),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit, color: Colors.white),
                      title: const Text('Rename', style: TextStyle(color: Colors.white)),
                      onTap: () {
                       setState(() {
                         renameResume(context, index, resumeViewModel);
                       });
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.edit, color: Colors.white),
                      title: const Text('Edit', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        setState(() {
                          resumeViewModel.edit(index, context);
                        });
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.delete, color: Colors.red),
                      title: const Text('Delete', style: TextStyle(color: Colors.red)),
                      onTap: () {
                        setState(() {
                          resumeViewModel.delete(index);
                        });
                        Navigator.pop(context);
                      },
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
