import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/view/pages/auth/auth_page_view.dart';
import 'package:pi_pcas/view/pages/auth/reset_password_view.dart';
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
        MaterialPageRoute(builder: (context) => const ResetPasswordPage(),
        )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top : 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AuthPage(),
                            )
                        );
                      },
                      color: mainColor,
                      textColor: Colors.white,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    )],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
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
                    const Padding(
                        padding: EdgeInsets.symmetric( horizontal: 25.0),
                        child : Text('Insira o código que lhe foi fornecido no registo para a recuperar.',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        )
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
                            padding: const EdgeInsets.fromLTRB(140, 10, 140, 10),
                            decoration:  BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                                'Próximo',
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

              ),
                )] ,
            )

        )

    );
  }

}
