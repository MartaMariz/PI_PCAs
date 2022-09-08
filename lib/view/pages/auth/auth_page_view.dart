import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile/view/pages/auth/login_view.dart';

import 'login_view.dart';
import 'register_view.dart';

import '../../../theme.dart';

class AuthPage extends StatefulWidget{
  @override
  _AuthPage createState() => _AuthPage();

}


class _AuthPage extends State<AuthPage>{
  //initially show the login page
  bool showLoginPage = true;

  void toggleScreens(){

    setState(() {
      showLoginPage = !showLoginPage;
    });


  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(showRegisterPage: toggleScreens) ;
    }
    else{
      return RegisterPage(showLoginPage:  toggleScreens);
    }
  }

}
