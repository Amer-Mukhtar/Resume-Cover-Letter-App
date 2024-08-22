import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cover_viewmode.dart';

class Cover extends StatefulWidget {
  const Cover({super.key});

  @override
  State<Cover> createState() => _CoverState();
}

class _CoverState extends State<Cover> {
  final CoverMode _viewModel = CoverMode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        height: 100,
        color: Colors.black87,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Colors.blue[900], borderRadius: BorderRadius.circular(10)),
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
                _viewModel.addNewCover(context);

              });
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(CupertinoIcons.plus, color: Colors.white),
                SizedBox(width: 5),
                Text(
                  'Add Cover Letter',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      body:
        SingleChildScrollView(
          child: Column(
          
            children: [
              if(_viewModel.coverLetters.isEmpty)
                Center(
                  child: Column(
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
                  ),
                )
          
              else
              ListView.builder(
              key: const ValueKey('emptyStat'),
                shrinkWrap: true,
              itemCount: _viewModel.coverLetters.length,
              itemBuilder: (context, index) {
                print('object');
                final item = _viewModel.coverLetters[index];
                return GestureDetector(
                  onTap: () {
                    _showCoverLetterOptions(context, index);
                  },
                  child: Container(
                    color: Colors.black,
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                item['title'] ?? 'No Title',
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
                                    onPressed: () {
                                      _showCoverLetterOptions(context, index);
                                    },
                                  ),
                                ),
                              ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
          
                              const Text(
                                'Summary',
                                style: TextStyle(color: Colors.white60),
                              ),
                              Text(
                                item['summary'] ?? 'No Summary',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),]
          ),
        )
    );
  }

  void _showCoverLetterOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF454545),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Wrap(
              children:
              [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit, color: Colors.white),
                    title: const Text('Rename Title', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      _showRenameDialog(context, index);
                    },
                  ),
                  const Divider(height: 1,),
                  ListTile(
                    leading: const Icon(Icons.edit, color: Colors.white),
                    title: const Text('Edit', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() {
                        _viewModel.edit(index,context);
                      });


                    },
                  ),const Divider(height: 1,),
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text('Delete', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      setState(()
                      {
                        _viewModel.delete(index);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),]
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

  void _showRenameDialog(BuildContext context, int index) {
    final TextEditingController renameController = TextEditingController(
      text: _viewModel.coverLetters[index]['title'],
    );

    showModalBottomSheet(

        context: context,
        builder:
            (BuildContext
        context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
            child: Container(
              decoration:
              const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight:
                    Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Color(
                    0xFF454545),
              ),
              width: double
                  .infinity,
              child:
              FractionallySizedBox(
                child: Container(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xFF454545),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Align(alignment: Alignment.topLeft,child: Text('Enter Title',style: TextStyle(color: Colors.white,),textAlign: TextAlign.start,)),
                        const SizedBox(height: 15,),
                        Theme(
                          data: ThemeData.dark(),
                          child: TextField(
                            controller:renameController ,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(),
                            ),

                          ),
                        ),

                        const SizedBox(height: 15,),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                          child: TextButton(onPressed: ()
                          {
                            setState(() {
                              _viewModel.renameTitle(index, renameController.text);
                            });
                            Navigator.pop(context);

                          },
                              child: const Text('savssse',style: TextStyle(color: Colors.white),)
                          ),
                        ),
                        const SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );


  }
}
