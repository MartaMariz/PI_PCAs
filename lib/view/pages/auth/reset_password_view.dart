import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme.dart';
import '../home_page_view.dart';

class ResetPasswordPage extends StatefulWidget{
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPage createState() => _ResetPasswordPage();

}


class _ResetPasswordPage extends State<ResetPasswordPage>{
  //controllers
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _key = GlobalKey<FormState>();


  @override
  void dispose(){

    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();

  }

  Future setPassword() async{
    //usar os controllers.text e tals
    if (_key.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password alterada com sucesso.')),
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
                          const Text('Repor a password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36
                              )
                          ),
                          const SizedBox(height: 10),
                          const Text('Escolha uma nova password.',
                              style: TextStyle(
                                fontSize: 15,
                              )
                          ),
                          const SizedBox( height: 50,),



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
                              onTap: setPassword,
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(145, 10, 145, 10),
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
                          const SizedBox( height: 25,),


                        ],

                      )
                  )

              ),
            )
        )

    );
  }

}
