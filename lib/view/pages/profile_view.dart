import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi_pcas/view/pages/contacts_view.dart';

import '../../theme.dart';

class Profile extends StatefulWidget{
  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Perfil', style: TextStyle(color: Colors.white),),
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
                child: const CircleAvatar(
                  radius : 60,
                  backgroundColor: Colors.transparent,
                  backgroundImage:  ExactAssetImage('/../assets/images/profile.jpg'),
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
            child: const Text('Marta Mariz',
              style: TextStyle(fontSize: 20),
            ),
          ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    ProfileButton (text: 'Editar Perfil', iconData: Icons.edit, redirect: Contacts(),),
                    ProfileButton (text: 'Contactar um Profissional', iconData: Icons.person, redirect: Contacts()),
                    ProfileButton (text: 'Definições', iconData: Icons.settings, redirect: Contacts()),
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
  const ProfileButton({
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
        print('tappedd');},
      child: Container(
          padding : const EdgeInsets.symmetric(vertical:  18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children:  [
                  Icon( iconData, size: 24),
                  const SizedBox(width: 16,),
                  Text(text, style: const TextStyle(
                    fontSize:  18,
                    fontWeight:  FontWeight.w600,
                  )
                  ),

                ],
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),

            ],

          )
      ),
    ) ;
  }
}
