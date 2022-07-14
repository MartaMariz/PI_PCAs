import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme.dart';
import '../home_page_view.dart';

class RegisterPage extends StatefulWidget{
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key,required this.showLoginPage}) : super(key: key);

  @override
  _RegisterPage createState() => _RegisterPage();

}


class _RegisterPage extends State<RegisterPage>{
  //controllers
  final _codeController = TextEditingController();
  final _usernamaController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _key = GlobalKey<FormState>();


  @override
  void dispose(){
    _codeController.dispose();
    _usernamaController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();

  }

  Future createAccount() async{
    //usar os controllers.text e tals
    if (_key.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage(),
          )
      );
    }

  }

  bool passwordConfirmed(){
    if ( _passwordController.text.trim() == _passwordConfirmController.text.trim()){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Expanded(
            child: Container(
                child:Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        //welcome
                        const Text('Bem vinda!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 36
                            )
                        ),
                        const SizedBox(height: 10),
                        const Text('Registe-se com o código que lhe foi fornecido.',
                            style: TextStyle(
                              fontSize: 15,
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
                                    child: TextFormField(
                                      controller: _codeController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Código'
                                      ),
                                      validator : (value) {
                                        //check if code exists
                                        if (value == '123'){
                                          return 'Código inválido';
                                        }
                                        else {
                                          return null;
                                        }

                                      },

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
                                child:  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty || value.length <8)  {
                                          return 'Username deve ter pelo menos 8 caracteres';
                                        }
                                        if (value == 'martamariz')  {
                                          return 'Username já está a ser utilizado';
                                        }
                                        return null;
                                      },
                                      controller: _usernamaController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Username'
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
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty || value.length <8)  {
                                          return 'Password deve ter pelo menos 8 caracteres';
                                        }
                                        return null;
                                      },
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
                        const SizedBox( height: 10,),

                        //password confirm input
                        Padding( padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value != _passwordController.text){
                                          return 'Passwords diferentes';
                                        }
                                        else {
                                          return null;
                                        }
                                      },
                                      controller: _passwordConfirmController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Confirma a Password'
                                      ),
                                    )

                                )
                            )
                        ),
                        const SizedBox( height: 10,),

                        //signin button
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: GestureDetector(
                            onTap: createAccount,
                            child: Container(
                                padding: const EdgeInsets.fromLTRB(130, 10, 130, 10),
                                decoration:  BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                    'Criar conta',
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
                            const Text('Já tem conta? ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),),
                            GestureDetector(
                              onTap: widget.showLoginPage,
                              child: const Text('Efetue o login. ',
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

            ),
          )
        )

    );
  }

}
