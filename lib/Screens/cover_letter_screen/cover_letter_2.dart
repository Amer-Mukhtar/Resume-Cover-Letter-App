import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../Models/model_cover.dart';
import '../../Utility/widgets/Textfield.dart';
import '../../Utility/widgets/TextfieldSummary.dart';
import 'cover_viewmode.dart';

Color text = Colors.white;
List photo = [
  {'image': 'assets/images/template1.png', 'title': 'Black & White'},
  {'image': 'assets/images/template2.png', 'title': 'Black & Blue'},
];

class CoverLetter extends StatefulWidget
{
  final CoverLetterModel coverLetterModel;

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

    textControllerLettermsg.addListener((){
      widget.coverLetterModel.summary = textControllerLettermsg.text;
      final CoverViewM = Provider.of<CoverViewModelProvider>(context, listen: false);
      CoverViewM.SetSummary(widget.coverLetterModel,textControllerLettermsg.text);

    });
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
                  children:
                  [
                    //messaging
                    Scaffold(
                      backgroundColor: Colors.black,
                      body: Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: SingleChildScrollView(
                          child: CustomSummaryField(
                            height: MediaQuery.of(context).size.height /1.7,
                            labelText: 'Summary',
                            controller: textControllerLettermsg,
                            hintText: 'Type Your letter message',
                            onChanged: (value) {
                              // Your onChanged logic here
                            }, borderColor: Colors.grey,
                          ),
                        ),
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
                              CustomTextField(
                                labelText: 'First Name',
                                KeyboardType: TextInputType.text,
                                controller: textControllerFirstName,
                                hintText: 'William',
                                onChanged: (value) {
                                },
                              ),


                              // Last Name
                              CustomTextField(
                                labelText: 'Last Name',
                                KeyboardType: TextInputType.text,
                                controller: textControllerLastName,
                                hintText: 'Smith',
                                onChanged: (value) {

                                },
                              ),


                              // Email
                              CustomTextField(
                                labelText: 'Email',
                                KeyboardType: TextInputType.emailAddress,
                                controller: textControllerEmail,
                                hintText: 'Vitaklik@gmail.com',
                                onChanged: (value) {

                                },
                              ),


                              // Phone Number
                              CustomTextField(
                                labelText: 'Phone Number',
                                KeyboardType: TextInputType.phone,
                                controller: textControllerPhone,
                                hintText: '+43 983 7459 3495',
                                onChanged: (value) {

                                },
                              ),


                              // Address
                              CustomTextField(
                                labelText: 'Address',
                                KeyboardType: TextInputType.text,
                                controller: textControllerAddress,
                                hintText: 'Los Angeles ,USA',
                                onChanged: (value) {

                                },
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
