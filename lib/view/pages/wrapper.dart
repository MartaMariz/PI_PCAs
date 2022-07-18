// chamado inicialmente se estiver logado home senão login
//https://www.youtube.com/watch?v=Mfa3u3naQew

import 'package:flutter/material.dart';
import 'package:pi_pcas/view/pages/auth/auth_page_view.dart';
import 'package:provider/provider.dart';
import '../../models/app_user.dart';
import 'home_page_view.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    //return either authenticate or home
    return user == null ? AuthPage() : MyHomePage();
  }
}
