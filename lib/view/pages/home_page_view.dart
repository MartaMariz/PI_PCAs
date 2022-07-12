
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/view/pages/add_record_view.dart';
import 'package:pi_pcas/view/pages/profile_view.dart';
import 'package:pi_pcas/view/pages/skills_view.dart';

import '../../theme.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTab = 0;

  final List<Widget> screens = [
    Skills(),
    AddRecord(),
    Profile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Skills();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white,),
        backgroundColor: mainColor,
        onPressed: () {
          setState(() {
            currentScreen = AddRecord();
            currentTab = 1;
          });
        },
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 70,
          child:  Row(
            mainAxisAlignment:  MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment:  CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth:  40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Skills();
                        currentTab = 0;
                      });
                    },
                    child:
                        Icon(
                          Icons.menu_book_outlined,
                          size: 40,
                          color: currentTab == 0? mainColor : Colors.grey,
                        )
                    )

                ],
              ),
              Row(
                crossAxisAlignment:  CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                      minWidth:  40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Profile();
                          currentTab = 2;
                        });
                      },
                      child:
                      Icon(
                        Icons.person,
                        color: currentTab == 2? mainColor : Colors.grey,
                        size: 40,
                      )
                  )

                ],

              )

            ],
          ),
        )
      )
    );
  }
}

