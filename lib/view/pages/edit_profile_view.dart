import 'package:flutter/material.dart';
import 'package:smile/models/app_user.dart';
import 'package:smile/services/database.dart';

import '../../models/user_data.dart';
import '../../theme.dart';

class EditPage extends StatefulWidget {
  EditPage({Key? key, required this.user}) : super(key: key);

  final AppUser user;

  @override
  _EditPage createState() => _EditPage(user);

}

class _EditPage extends State<EditPage>{

  @override
  void initState() {
    super.initState();
    setState(() {
      _imageController = -1;
    });
  }

  List<String> profilePics = [
    'lib/assets/images/icon1.png',
    'lib/assets/images/icon2.png',
    'lib/assets/images/icon3.png',
    'lib/assets/images/icon4.png',
    'lib/assets/images/icon5.png',
    'lib/assets/images/icon6.png',
    'lib/assets/images/icon7.png',
    'lib/assets/images/icon8.png',
    'lib/assets/images/icon9.png',
    'lib/assets/images/icon10.png',
    'lib/assets/images/icon11.png',
    'lib/assets/images/icon12.png',
    'lib/assets/images/icon13.png',
    'lib/assets/images/icon14.png',
    'lib/assets/images/icon15.png',
    'lib/assets/images/icon16.png',
    'lib/assets/images/icon17.png',
    'lib/assets/images/icon18.png',
    'lib/assets/images/icon19.png',
    'lib/assets/images/icon20.png',
    'lib/assets/images/icon21.png',
    'lib/assets/images/icon22.png',
    'lib/assets/images/icon23.png',
    'lib/assets/images/icon24.png',
    'lib/assets/images/icon25.png',
    'lib/assets/images/icon26.png',
    'lib/assets/images/icon27.png',
    'lib/assets/images/icon28.png',
    'lib/assets/images/icon29.png',
    'lib/assets/images/icon30.png'
  ];

  String nullPic = 'lib/assets/images/null_icon.png';

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  static late int _imageController;
  final user;

  final DatabaseService _database = DatabaseService();

  _EditPage(this.user);

  Future updateData() async {
    UserData? userData = await _database.retrieveCurrentUserData(user.id);
    if (userData == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Houve um problema ao recolher dados. Tente novamente mais tarde.')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      String username;
      int image;
      _usernameController.text.isNotEmpty ?
        username = _usernameController.text : username = userData.username;
      _imageController != -1?
        image = _imageController : image = userData.image;
      await _database.updateUserData(user.id, username, image, userData.code, userData.submodulesUnlocked);
      Navigator.pop(context);
    }
  }

  Future cancel() async{
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Form(
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

                  CircleAvatar(
                    radius : 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage: _imageController == -1?
                    ExactAssetImage(nullPic) : ExactAssetImage(profilePics[_imageController]),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child:  GestureDetector(
                        onTap: (){
                          showDialog(context: context,
                              builder: (BuildContext context) =>
                                  Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                    elevation: 16,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        const SizedBox(height: 20),
                                        const Center(child: Text('Escolha uma imagem:')),
                                        const SizedBox(height: 20),
                                        Column(
                                          children: getIcons()
                                        )
                                      ],
                                    ),
                                  )
                          );
                        },
                        child: const CircleAvatar(
                        backgroundColor: mainColor,
                        radius: 14.0,
                        child: Icon(
                          Icons.brush,
                          size: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      ),
                    ),
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
                  const SizedBox( height: 30,),

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
                  const SizedBox( height: 10,),

                  //cancel button
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: GestureDetector(
                      onTap: cancel,
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(120, 10, 120, 10),
                          decoration:  BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                              'Cancelar',
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

  List<Widget> getIcons(){
    double width = MediaQuery.of(context).size.width ;
    List<Widget> icons = [];
    for (int i=0; i<10; i++){
      icons.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {setState(() => _imageController = i*3); Navigator.pop(context); },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(
                        color: _imageController == 0 ?
                        mainColor : Colors.white,
                        blurRadius: 1,
                        spreadRadius: 1)],
                  ),
                  child: Image.asset("lib/assets/images/icon"+ (i*3+1).toString() +".png", width: width/5),
                )
            ),
            const SizedBox(width: 3),
            GestureDetector(
                onTap: () {setState(() => _imageController = i*3+1); Navigator.pop(context); },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(
                        color: _imageController == 1 ?
                        mainColor : Colors.white,
                        blurRadius: 1,
                        spreadRadius: 1)],
                  ),
                  child: Image.asset("lib/assets/images/icon"+ (i*3+2).toString() + ".png", width: width/5),
                )
            ),
            const SizedBox(width: 3),
            GestureDetector(
                onTap: () {setState(() => _imageController = i*3+2); Navigator.pop(context); },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(
                        color: _imageController == 1 ?
                        mainColor : Colors.white,
                        blurRadius: 1,
                        spreadRadius: 1)],
                  ),
                  child: Image.asset("lib/assets/images/icon"+ (i*3+3).toString() + ".png", width: width/5),
                )
            ),
          ],
        ),
      );
      icons.add(const SizedBox(height: 3));
    }
    return icons;
  }


}
