import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smile/services/database.dart';

import '../../../services/auth.dart';
import '../../../theme.dart';
import '../wrapper.dart';

class RegisterPage extends StatefulWidget{
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key,required this.showLoginPage}) : super(key: key);

  @override
  _RegisterPage createState() => _RegisterPage();

}


class _RegisterPage extends State<RegisterPage>{
  //controllers
  final _codeController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _key = GlobalKey<FormState>();
  late double width;

  final AuthService _auth = AuthService();
  final DatabaseService _database = DatabaseService();

  @override
  void dispose(){
    _codeController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();
  }

  Future createAccount() async {

    if (_key.currentState!.validate()) {
      dynamic result = await _auth.registerWithEmailAndPassword(_emailController.text, _passwordController.text);

      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Autenticação não autorizada. Tente outro email e/ou senha.')),
        );
        return;
      } else {
        dynamic result2 = await _database.updateUserData(result.id, _usernameController.text, Random().nextInt(6), _codeController.text, [0]);

        if (result2 == null){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Houve um problema ao recolher dados. Tente novamente mais tarde.')),
          );
          return;
        }
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Autenticação não autorizada. Tente novamente.')),
      );
      return;
    }

    if (mounted){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Wrapper(),)
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
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        body: SafeArea(
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
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                                        return null;
                                      },
                                      controller: _usernameController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Username'
                                      ),
                                    )

                                )
                            )
                        ),
                        const SizedBox( height: 10,),

                        //email input
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
                                padding: EdgeInsets.fromLTRB(width*0.4-30, 10, width*0.4-30, 10),
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
    );
  }

}
