import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../services/auth.dart';
import '../../../theme.dart';
import '../wrapper.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget{
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}): super(key: key);

  @override
  _LoginPage createState() => _LoginPage();

}


class _LoginPage extends State<LoginPage>{
  //controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _auth = AuthService();

  Future signIn() async{

    dynamic result = await _auth.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados incorretos')),
      );
      return;
    } else {
      print("go off sis");
      print(result);
    }

    if (mounted){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper(),)
      );
    }

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
              const Text('Olá!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36
              )
          ),
            const Text('Bem vinda de volta!',
              style: TextStyle(
                  fontSize: 20
              )
            ),
            const SizedBox( height: 50,),

              //username input
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
                        controller: _emailController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email'
                        ),
                      )

                  )
              )
              ),
              const SizedBox( height: 10,),


              //password input
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
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password'
                            ),
                          )

                      )
                  )
              ),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const ForgotPassword()
                  )
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [Text('Esqueceu-se da password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      )
                  ),
            ],
                  ),
                ),
              ),
              const SizedBox( height: 10,),

              //signin button
              Padding(padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(150, 10, 150, 10),
                    decoration:  BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color:  Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      )
                    )
                  ),
                ),
              ),
              const SizedBox( height: 25,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Text('Ainda não se registou? ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: const Text('Registe-se agora. ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        )),
                  )
                ],
              ),
              const SizedBox( height: 50,),

            ],

          )

      )

    );
  }

}
