import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/view/pages/home_page_view.dart';

import '../../../theme.dart';

class LoginCodePage extends StatefulWidget{
  const LoginCodePage({Key? key}): super(key: key);

  @override
  _LoginCodePage createState() => _LoginCodePage();

}


class _LoginCodePage extends State<LoginCodePage>{
  //controllers
  final _usernamaController = TextEditingController();
  final _codeController = TextEditingController();

  Future resetPassword() async{
    //usar os controllers.text e tals
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(),
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
                const Text('Esqueceu-se da password?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    )
                ),
                const SizedBox(height: 15,),
                const Text('Insira o código que lhe foi fornecido no registo para a recuperar.',
                    style: TextStyle(
                        fontSize: 15,
                    ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox( height: 50,),

                //code input
                Padding( padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:  Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _codeController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Código'
                              ),
                            )

                        )
                    )
                ),
                const SizedBox( height: 10,),


                //username input
                Padding( padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _usernamaController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Username'
                              ),
                            )

                        )
                    )
                ),
                const SizedBox(height: 10,),

                //next button
                Padding(padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: GestureDetector(
                    onTap: resetPassword,
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(160, 10, 160, 10),
                        decoration:  BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                            'Next',
                            style: TextStyle(
                                color:  Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            )
                        )
                    ),
                  ),
                ),
                const SizedBox( height: 50,),


              ],

            )

        )

    );
  }

}
