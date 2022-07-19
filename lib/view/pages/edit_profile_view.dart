import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/models/app_user.dart';
import 'package:pi_pcas/services/database.dart';

import '../../models/user_data.dart';
import '../../theme.dart';

class EditPage extends StatefulWidget {
  EditPage({Key? key, required this.user}) : super(key: key);

  final AppUser user;

  @override
  _EditPage createState() => _EditPage(user);

}

class _EditPage extends State<EditPage>{

  List<String> profilePics = [
    'lib/assets/images/bunny_icon.png',
    'lib/assets/images/cat_icon.png',
    'lib/assets/images/cow_icon.png',
    'lib/assets/images/dog_icon.png',
    'lib/assets/images/fox_icon.png',
    'lib/assets/images/frog_icon.png'
  ];

  String nullPic = 'lib/assets/images/null_icon.png';

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final int _imageController = -1;
  final user;

  final DatabaseService _database = DatabaseService();

  _EditPage(this.user);

  Future updateData() async {
    UserData? userData = await _database.retrieveCurrentData(user.id);
    if (userData == null){
      print("cockou");
      return;
    }

    if (_formKey.currentState!.validate()) {
      String username;
      int image;
      _usernameController.text.isNotEmpty ?
        username = _usernameController.text : username = userData.username;
      _imageController != -1?
        image = _imageController : image = userData.image;
      await _database.updateUserData(user.id, username, image, userData.code);
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
                      CircleAvatar(
                        radius : 60,
                        backgroundColor: Colors.transparent,
                        backgroundImage: ExactAssetImage(nullPic),
                      ),
                      const SizedBox( height: 50,),
                      const Text('Preencha apenas os dados que deseja modificar',
                          style: TextStyle(
                            fontSize:16,
                          )
                      ),

                      const SizedBox( height: 30,),
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
