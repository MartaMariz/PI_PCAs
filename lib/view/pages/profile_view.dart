import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/services/database.dart';
import 'package:pi_pcas/view/pages/auth/logout_view.dart';
import 'package:pi_pcas/view/pages/contacts_view.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../models/user_data.dart';
import '../../theme.dart';
import 'edit_profile_view.dart';

class Profile extends StatefulWidget{

  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile>{

  List<String> profilePics = [
    'lib/assets/images/bunny_icon.png',
    'lib/assets/images/cat_icon.png',
    'lib/assets/images/cow_icon.png',
    'lib/assets/images/dog_icon.png',
    'lib/assets/images/fox_icon.png',
    'lib/assets/images/frog_icon.png'
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        centerTitle: true,
          title: const Text('Perfil', style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Mulish',
              color: Colors.white),),
        backgroundColor: mainColor,
      ),
        body: Container(
          padding : const EdgeInsets.all(16),
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 150,
                child: StreamBuilder<UserData>(
                  stream: DatabaseService().userData(user!.id),
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      return CircleAvatar(
                        radius : 60,
                        backgroundColor: Colors.transparent,
                        backgroundImage: ExactAssetImage(profilePics[snapshot.data!.image]),
                      );
                    }
                    else {
                      return Text("");
                    }
                  },

                ),
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  border : Border.all(
                    color: mainColor,
                    width: 5.0,
                  )
                ),
              ),
              const SizedBox(
                height: 10,
              ),
          SizedBox(
              width: size.width * .3,
              child: StreamBuilder<UserData>(
                stream: DatabaseService().userData(user.id),
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    return Text(snapshot.data!.username,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20,
                    color: textGrayColor,
                    fontFamily: 'Mulish'),
                  );
                  }
                  else {
                    return Text("");
                  }
                },
              )
            ),

              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileButton (text: 'Editar Perfil', iconData: Icons.edit, redirect: EditPage(user: user)),
                    ProfileButton (text: 'Contactar um Profissional', iconData: Icons.person, redirect: Contacts()),
                    ProfileButton (text: 'Definições', iconData: Icons.settings, redirect: Contacts()),
                    ProfileButton (text: 'LogOut', iconData: Icons.logout, redirect: LogOutPage()),
                  ],

                ),
              )


            ],

          )
        ),
    );
  }

}

class ProfileButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Widget redirect;

  ProfileButton({
    Key? key, required this.iconData, required this.text, required this.redirect
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => redirect),
        );
        print('tappedd');
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(iconData, size: 24, color: textGrayColor,),
                  const SizedBox(width: 16,),
                  Text(text, style: const TextStyle(
                      fontSize: 18,
                      color: textGrayColor,
                      fontFamily: 'Mulish'
                  )
                  ),

                ],
              ),
              text != "LogOut" ?
              const Icon(
                Icons.arrow_forward_ios, size: 16, color: textGrayColor,)
              : const SizedBox(width: 0.0,),

            ],

          )
      ),
    );
  }
}