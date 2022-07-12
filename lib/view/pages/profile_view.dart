import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(

        child: Container(
          padding : const EdgeInsets.all(16),
          height: size.height,
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
                height: size.height * .7,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    ProfileButton (text: 'Editar Perfil', iconData: Icons.edit,),
                    ProfileButton (text: 'Contactar um Profissional', iconData: Icons.person,),
                    ProfileButton (text: 'Definições', iconData: Icons.settings,),
                  ],

                ),
              )


            ],

          )
        ),
      )
    );
  }

}

class ProfileButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  const ProfileButton({
    Key? key, required this.iconData, required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { print('tappedd');},
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
