import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'view/pages/home_page_view.dart';
import 'theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

Map<int, Color> color =
{
  50:Color.fromRGBO(0xB4, 0x8D, 0xE5, .1),
  100:Color.fromRGBO(0xB4, 0x8D, 0xE5, .2),
  200:Color.fromRGBO(0xB4, 0x8D, 0xE5, .3),
  300:Color.fromRGBO(0xB4, 0x8D, 0xE5, .4),
  400:Color.fromRGBO(0xB4, 0x8D, 0xE5, .5),
  500:Color.fromRGBO(0xB4, 0x8D, 0xE5, .6),
  600:Color.fromRGBO(0xB4, 0x8D, 0xE5, .7),
  700:Color.fromRGBO(0xB4, 0x8D, 0xE5, .8),
  800:Color.fromRGBO(0xB4, 0x8D, 0xE5, .9),
  900:Color.fromRGBO(0xB4, 0x8D, 0xE5, 1),
};
MaterialColor materialMainColor = MaterialColor(0xB48DE5, color);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: materialMainColor,

      ),
      home: const MyHomePage(title: 'Intervenção PCAs'),
    );
  }
}
