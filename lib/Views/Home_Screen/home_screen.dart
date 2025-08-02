import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../add_resume_screen/resume_1.dart';
import '../cover_letter_screen/cover_letter_1.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  IconData notification_active = Icons.notifications_active;
  IconData notification_disabled = Icons.notifications_off;
  IconData current_notification =Icons.notifications_active;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        backgroundColor:  Color.lerp(Colors.black,Colors.white,0.15),
        child: SafeArea(
          child: Container(

            padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 30),
            decoration: BoxDecoration(color: Color.lerp(Colors.black,Colors.white,0.15),borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
            width: double.infinity,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    '   ABOUT',
                    style: TextStyle(color: Colors.white54,fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),

                //share
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      color: Colors.black),
                  child: Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, padding: EdgeInsets.zero,
                          backgroundColor: Colors.black,
                          minimumSize: Size.zero,
                        ).copyWith(
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            ),
                          ),
                        ),
                        onPressed: () {
                          launchUrl(Uri.http('google.com'));
                        },
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF454545),
                            ),
                            child: const Icon(
                              CupertinoIcons.share,
                              color: Colors.white,
                            ),
                          ),
                          title: const Text(
                            'Share with Friends',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: const Icon(
                            CupertinoIcons.arrow_up_right,
                            color: Colors.white30,
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                Container(width: double.infinity,color: Colors.white10,height: 0.5,),


                //share
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.black),
                  child: Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, padding: EdgeInsets.zero,
                          backgroundColor: Colors.black,
                          minimumSize: Size.zero,
                        ).copyWith(
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                        onPressed: () {

                        },
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF454545),
                            ),
                            child: const Icon(
                              CupertinoIcons.doc,
                              color: Colors.white,
                            ),
                          ),
                          title: const Text(
                            'Terms of Use',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: const Icon(
                            CupertinoIcons.arrow_up_right,
                            color: Colors.white30,
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                Container(width: double.infinity,color: Colors.white10,height: 0.5,),

                //privacy policy
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.black),
                  child: Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, padding: EdgeInsets.zero,
                          backgroundColor: Colors.black,
                          minimumSize: Size.zero,
                        ).copyWith(
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                        onPressed: () {

                        },
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF454545),
                            ),
                            child: const Icon(
                              CupertinoIcons.checkmark_shield,
                              color: Colors.white,
                            ),
                          ),
                          title: const Text(
                            'Privacy Policy',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: const Icon(
                            CupertinoIcons.arrow_up_right,
                            color: Colors.white30,
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                Container(width: double.infinity,color: Colors.white10,height: 0.5,),

                //App Version
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                      color: Colors.black),
                  child: Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, padding: EdgeInsets.zero,
                          backgroundColor: Colors.black,
                          minimumSize: Size.zero,
                        ).copyWith(
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                            ),
                          ),
                        ),
                        onPressed: () {

                        },
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF454545),
                            ),
                            child: const Icon(
                              FontAwesomeIcons.codeBranch,
                              color: Colors.white,
                            ),
                          ),
                          title: const Text(
                            'App Version',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: const Text('3.02-82',style: TextStyle(color: Colors.white54),
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
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.blue),
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white60),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
                width: 40,
                height: 40,
                child:  Image.asset("assets/icons/gemini2.png")
            ),
          ),const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
             setState(() {
               if(current_notification==notification_active)
               {
                 current_notification =notification_disabled;
               }
               else if(current_notification==notification_disabled)
               {
                 current_notification =notification_active;
               }

             });
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(10)),
                width: 40,
                height: 40,
                child:  Icon(
                  current_notification,
                  color: Colors.white,
                )),
          ),
          const SizedBox(width: 20),
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          child:  const DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.blueAccent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent),
                    unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 20),
                    tabs: [
                      Tab(text: 'Resume'),
                      Tab(text: 'Cover Letters')
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Resume_List(),
                        Cover(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }





}
