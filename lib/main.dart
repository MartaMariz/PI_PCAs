import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pi_pcas/services/auth.dart';
import 'package:pi_pcas/services/messaging.dart';
import 'package:pi_pcas/services/notification.dart';
import 'package:pi_pcas/view/pages/wrapper.dart';
import 'package:provider/provider.dart';

import 'models/app_user.dart';
import 'theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<NotificationService>(create: (context) => NotificationService()),
          Provider<MessagingService>(create: (context) => MessagingService(context.read<NotificationService>()),),
          StreamProvider<AppUser?>.value(
              initialData: null,
              value: AuthService().user,
          )
        ],
      child: MaterialApp(
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
            //
            primarySwatch: materialMainColor,
            fontFamily: 'Mulish',

          ),
          home:  Wrapper()
      ),
    );
  }
}
