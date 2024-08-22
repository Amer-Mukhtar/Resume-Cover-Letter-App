import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Models/model_cover.dart';

Color text = Colors.white;
List photo = [
  {'image': 'assets/images/template1.png', 'title': 'Black & White'},
  {'image': 'assets/images/template2.png', 'title': 'Black & Blue'},
];

class CoverLetter extends StatefulWidget
{
  final newCoverLetterModel coverLetterModel;

  const CoverLetter({super.key, required this.coverLetterModel});

  @override
  State<CoverLetter> createState() => _CoverLetterState();
}

class _CoverLetterState extends State<CoverLetter> with SingleTickerProviderStateMixin
{
  late TabController _tabController;

  late TextEditingController textControllerLettermsg;
  late TextEditingController textControllerFirstName;
  late TextEditingController textControllerLastName;
  late TextEditingController textControllerEmail;
  late TextEditingController textControllerPhone;
  late TextEditingController textControllerAddress;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    textControllerLettermsg = TextEditingController(text: widget.coverLetterModel.summary);
    textControllerFirstName = TextEditingController(text: widget.coverLetterModel.firstName);
    textControllerLastName = TextEditingController(text: widget.coverLetterModel.lastName);
    textControllerEmail = TextEditingController(text: widget.coverLetterModel.email);
    textControllerPhone = TextEditingController(text: widget.coverLetterModel.phoneNumber);
    textControllerAddress = TextEditingController(text: widget.coverLetterModel.address);

    textControllerLettermsg.addListener(() => widget.coverLetterModel.summary = textControllerLettermsg.text);
    textControllerFirstName.addListener(() => widget.coverLetterModel.firstName = textControllerFirstName.text);
    textControllerLastName.addListener(() => widget.coverLetterModel.lastName = textControllerLastName.text);
    textControllerEmail.addListener(() => widget.coverLetterModel.email = textControllerEmail.text);
    textControllerPhone.addListener(() => widget.coverLetterModel.phoneNumber = textControllerPhone.text);
    textControllerAddress.addListener(() => widget.coverLetterModel.address = textControllerAddress.text);
  }

  @override
  void dispose() {
    textControllerLettermsg.dispose();
    textControllerFirstName.dispose();
    textControllerLastName.dispose();
    textControllerEmail.dispose();
    textControllerPhone.dispose();
    textControllerAddress.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void update()
  {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        height: 100,
        color: Colors.black87,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.circular(10)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () {
              _tabController.animateTo((_tabController.index + 1) % 3);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  child: const Icon(CupertinoIcons.arrow_right, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Cover Letter', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white60),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(CupertinoIcons.arrow_left, color: Colors.white, size: 15),
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              TabBar(
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.blueAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.white,
                labelStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blueAccent),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 15),
                tabs: const [
                  Tab(
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.doc_plaintext),
                        SizedBox(width: 5),
                        Text('Letter Message'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.addressCard, size: 20),
                        SizedBox(width: 10),
                        Text('Intro'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.doc),
                        SizedBox(width: 5),
                        Text('Template'),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(

                  controller: _tabController,
                  children: [
                    // Letter Message Tab
                    Scaffold(
                      backgroundColor: Colors.black,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              padding: const EdgeInsets.all(10),
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white60, width: 1),
                              ),
                              child: Theme(
                                data: ThemeData.dark(),
                                child: TextField(
                                  expands: true,
                                  maxLines: null,
                                  minLines: null,
                                  keyboardType: TextInputType.multiline,
                                  controller: textControllerLettermsg,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Colors.white54),
                                    hintText: 'Type Your letter message',
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Intro Tab
                    Scaffold(
                      backgroundColor: Colors.black,
                      body: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              // First Name
                              Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),child: Text('First Name',style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                              Theme(
                                data: ThemeData.dark(),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                  height: 50,
                                  width:double.infinity ,
                                  child: TextFormField(

                                    controller: textControllerFirstName,
                                    decoration: const InputDecoration(
                                      labelText: 'William',
                                      focusedBorder:OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)

                                      ) ,
                                      border: OutlineInputBorder(),
                                    ),
                                    cursorColor: Colors.white,
                                  ),
                                ),
                              ),

                              // Last Name
                              Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),child: Text('Last Name',style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                              Theme(
                                data: ThemeData.dark(),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                  height: 50,
                                  width:double.infinity ,
                                  child: TextFormField(

                                    controller: textControllerLastName,
                                    decoration: const InputDecoration(
                                      labelText: 'Smith',
                                      focusedBorder:OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)

                                      ) ,
                                      border: OutlineInputBorder(),
                                    ),
                                    cursorColor: Colors.white,
                                  ),
                                ),
                              ),

                              // Email
                              Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),child: Text('Email',style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                              Theme(
                                data: ThemeData.dark(),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                  height: 50,
                                  width:double.infinity ,
                                  child: TextFormField(

                                    controller: textControllerEmail,
                                    decoration: const InputDecoration(
                                      labelText: 'Vitaklik@gmail.com',
                                      focusedBorder:OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)

                                      ) ,
                                      border: OutlineInputBorder(),
                                    ),
                                    cursorColor: Colors.white,
                                  ),
                                ),
                              ),

                              // Phone Number
                              Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),child: Text('Phone Number',style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                              Theme(
                                data: ThemeData.dark(),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                  height: 50,
                                  width:double.infinity ,
                                  child: TextFormField(

                                    controller: textControllerPhone,
                                    decoration: const InputDecoration(
                                      labelText: '1749 2347 8932',
                                      focusedBorder:OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)

                                      ) ,
                                      border: OutlineInputBorder(),
                                    ),
                                    cursorColor: Colors.white,
                                  ),
                                ),
                              ),

                              // Address
                              Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),child: Text('Address',style: TextStyle(color: text,fontWeight: FontWeight.bold),)),
                              Theme(
                                data: ThemeData.dark(),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 20),
                                  height: 50,
                                  width:double.infinity ,
                                  child: TextFormField(

                                    controller: textControllerAddress,
                                    decoration: const InputDecoration(
                                      labelText: 'Los Angeles ,USA',
                                      focusedBorder:OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white)

                                      ) ,
                                      border: OutlineInputBorder(),
                                    ),
                                    cursorColor: Colors.white,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    // Template Tab
                    Flexible(
                      child: Scaffold(
                        body: Container(
                          color: Colors.black,
                          child: GridView.builder(
                            itemCount: photo.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, crossAxisSpacing: 0),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 20),
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(photo[index]['image'] ?? ''),
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 170,
                                          width: 150,
                                          child: Container(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [Colors.black, Colors.transparent],
                                                stops: [0.0, 1.0],
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Text(photo[index]['title'] ?? '',
                                                        style: const TextStyle(color: Colors.white)),
                                                    const Icon(CupertinoIcons.profile_circled,
                                                        color: Colors.orange, size: 15),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
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

}
