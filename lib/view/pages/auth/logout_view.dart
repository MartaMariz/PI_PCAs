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

  Future cancel() async{
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
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
                Container(
                  child: GestureDetector(
                    onTap: signOut,
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(150, 10, 150, 10),
                        decoration:  BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                            'Sim',
                            style: TextStyle(
                                color:  Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            )
                        )
                    ),
                  ),
                ),
                const SizedBox( height: 10),

                //cancel button
                Container(
                  child: GestureDetector(
                    onTap: cancel,
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(150, 10, 150, 10),
                        decoration:  BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                            'Não',
                            style: TextStyle(
                                color:  Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            )
                        )
                    ),
                  ),
                ),
              ],

            )
          ),


        )

    );
  }

}