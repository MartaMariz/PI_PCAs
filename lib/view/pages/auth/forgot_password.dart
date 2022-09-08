import 'package:flutter/material.dart';
import 'package:smile/view/pages/auth/auth_page_view.dart';

import '../../../services/auth.dart';
import '../../../theme.dart';

class ForgotPassword extends StatefulWidget{
  const ForgotPassword({Key? key}): super(key: key);

  @override
  _ForgotPassword createState() => _ForgotPassword();

}


class _ForgotPassword extends State<ForgotPassword>{
  //controllers
  final _emailController = TextEditingController();

  final AuthService _auth = AuthService();
  Future resetPassword() async{

    dynamic result = await _auth.resetPassword(_emailController.text.trim());
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email não é válido')),
      );
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aceda ao seu email para redefinir a password.')),
      );
      Navigator.pop(context);
    }

  }

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
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
                        child : Text('Insira o email para redefinir a sua password.',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        )
                    ),
                    const SizedBox( height: 50,),


                    //email input
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
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email'
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
                                'Redefinir',
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
