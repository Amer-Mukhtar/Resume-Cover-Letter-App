import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../add_resume_screen/resume_1.dart';
import '../cover_letter_screen/cover_letter_1.dart';


class home extends StatefulWidget {
  const home({super.key});
  @override
  State<home> createState() => _homeState();
}
class _homeState extends State<home> {
  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: Drawer(
        backgroundColor: Colors.blue[900],
        child: ListView(
          children: const [
            ListTile(
              title: Text(
                'Additional Settings',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
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
                scaffoldkey.currentState?.openDrawer();
              },
            ),
          ),
        ),
        actions: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(10)),
              width: 40,
              height: 40,
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
              )),
          const SizedBox(width: 10,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              border: Border.all(color: Colors.white60),
            ),
            width: 50,
            height: 40,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [

                Text(
                  '0',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                SizedBox(width: 5,),
                Icon(
                  CupertinoIcons.plus,
                  color: Colors.white,
                  size: 15,
                )
              ],
            ),
          ),
          const SizedBox(width: 10,),
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(
          width: double.infinity,
          color: Colors.black,
          child: Container(
            padding:  EdgeInsets.only(top: 10),
            child:  DefaultTabController(
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
                        tabs:
                        [
                          Tab(text: 'Resume',),
                          Tab(text: 'Cover Letters',)
                        ],
                      ),
                      Expanded(
                          child:
                          TabBarView(children:
                          [


                            Resume_List(),
                            Cover()
                          ])
                      )
                    ],
                  ),
                )
            ),
          )
      ),
    );
  }
  void update()
  {
    setState(() {

    });
  }
}














