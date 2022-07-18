import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/services/database.dart';

import '../../theme.dart';

class EditPage extends StatefulWidget {
  EditPage({Key? key, this.user}) : super(key: key);

  final user;

  @override
  _EditPage createState() => _EditPage(user);

}

class _EditPage extends State<EditPage>{

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final user;
  final DatabaseService _database = DatabaseService();

  _EditPage(this.user);

  Future updateData() async {
    if (_formKey.currentState!.validate()) {
      String username, password;
      _usernameController.text.isNotEmpty ?
        username = _usernameController.text : username = user.username;
      _passwordController.text.isNotEmpty ?
        password = _passwordController.text : password = user.password;
      await _database.updateUserData(user.id, username, password, user.code);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Container(
              child:Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Text('Preencha apenas os dados que deseja modificar',
                          style: TextStyle(
                            fontSize:16,
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
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value != null && value.isNotEmpty && value.length <8)  {
                                        return 'Username deve ter pelo menos 8 caracteres';
                                      }
                                      if (value == 'martamariz')  {
                                        return 'Username já está a ser utilizado';
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
                                      if (value != null && value.isNotEmpty && value.length <8)  {
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

                      //edit button
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: GestureDetector(
                          onTap: updateData,
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(130, 10, 130, 10),
                              decoration:  BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                  'Editar',
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

          ),
        )

    );
  }


}
