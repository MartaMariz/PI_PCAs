import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/services/auth.dart';

import '../../../theme.dart';
import '../wrapper.dart';

class LogOutPage extends StatefulWidget {
  LogOutPage({Key? key}) : super(key: key);

  @override
  _LogOutPage createState() => _LogOutPage();
}

class _LogOutPage extends State<LogOutPage>{
  final AuthService _auth = AuthService();

  Future signOut() async{
    await _auth.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper(),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                //welcome
                const Text('Tem a certeza que quer sair?',
                    style: TextStyle(
                        fontSize: 20
                    )
                ),
                const SizedBox( height: 50,),

                //signout button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: GestureDetector(
                    onTap: signOut,
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(150, 10, 150, 10),
                        decoration:  BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                            'Log Out',
                            style: TextStyle(
                                color:  Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            )
                        )
                    ),
                  ),
                ),
                const SizedBox( height: 75,),
              ],

            )

        )

    );
  }

}