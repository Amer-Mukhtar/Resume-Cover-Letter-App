import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
    final resumeViewModelProvider = Provider.of<ResumeViewModelProvider>(context,  listen: false);
    print('does t');
    double leng=0;
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
              enter_title_sheet(context);
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
      body: ReorderableListView(
        scrollDirection: Axis.vertical,
        onReorder: (int oldIndex, int newIndex) {

          if (newIndex > oldIndex) {
            newIndex -= 1;
          }

        },
        children: [
          if (resumeViewModelProvider.resumes.isEmpty)
            Column(
              key: const ValueKey('emptyState'),
              children: [
                const SizedBox(height: 180),
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
            )
          else
            for (int index = 0; index < resumeViewModelProvider.resumes.length; index++)
              Container(
                key: ValueKey(resumeViewModelProvider.resumes[index]),
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
                                Text(
                                  resumeViewModelProvider.resumes[index]['title'] ?? 'No Title',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 10),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(color: Colors.white60),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      onPressed: ()
                                      {
                                        setState(() {
                                          _showCoverLetterOptions(context, index, resumeViewModelProvider);
                                        });

                                      },
                                    ),
                                  ),
                                ),
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
                            padding: const EdgeInsets.all(20),
                            child: Column(///here
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        resumeViewModelProvider.job_return(index),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      children: [
                                        Text(
                                          'Fullness: ${resumeViewModelProvider.resumes[index]['fullness']}%',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 110,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: LinearProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                              value: resumeViewModelProvider.getLength(index) / 100,
                                              backgroundColor: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
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
              )

        ],
      ),
    );
  }

  Future enter_title_sheet(BuildContext context) {
    final resumeViewModelProvider = Provider.of<ResumeViewModelProvider>(context,  listen: false);
    return showModalBottomSheet(
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Text(
                        'Title',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Theme(
                      data: ThemeData.dark(),
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                        height: 50,
                        width: double.infinity,
                        child: TextFormField(
                          controller: textControllerTitle,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          cursorColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Text(
                        'Job',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Theme(
                      data: ThemeData.dark(),
                      child: Container(
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                        height: 50,
                        width: double.infinity,
                        child: TextFormField(
                          controller: textControllerJob,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          cursorColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: ()
                        {
                          setState(()
                          {
                            resumeViewModelProvider.addNewResume(context,textControllerTitle.text, textControllerJob.text);
                          });
                          textControllerJob.clear();
                          textControllerTitle.clear();
                          Navigator.pop(context);
                          Navigator.pop(context);
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

  void renameResume(BuildContext context, int index, ResumeViewModelProvider resumeViewModel) {
    TextEditingController renameController = TextEditingController();
    TextEditingController renameControllerJob = TextEditingController();

    showModalBottomSheet(
      context: context,
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
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rename Resume', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: renameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Rename Job', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: renameControllerJob,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            resumeViewModel.renameTitle(index, renameController.text, renameControllerJob.text);
                          });
                          Navigator.of(context)..pop()..pop();

                        },
                        child: const Text('Save', style: TextStyle(color: Colors.white)),
                      ),
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

  void _showCoverLetterOptions(BuildContext context, int index, ResumeViewModelProvider resumeViewModel) {
    showModalBottomSheet(
      context: context,
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
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.cancel, color: Colors.white),
                      title: const Text('Cancel', style: TextStyle(color: Colors.white)),
                      onTap: () {
                       setState(() {
                         Navigator.pop(context);
                       });
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
