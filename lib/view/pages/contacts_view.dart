import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class Contacts extends StatelessWidget{
  const Contacts({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactar um profissional', style: TextStyle(color: Colors.white),),
        backgroundColor: mainColor,
      ),
      body: Container(
        padding : const EdgeInsets.all(16),
        height: size.height,
        width: size.width,
        child: RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.black38,  fontSize: 18, height: 1.2),
            children: [
              TextSpan(
                  text:  'Conversa com o teu médico de família sobre os teus sintomas e dificuldades. Ele irá encaminhar-te para o serviço de Psicologia mais adequado às tuas necessidades.\n'),
              TextSpan(
                  text: 'Existem também serviços de Psicologia onde podes marcar consulta:\n',),
              TextSpan(
                  text: 'Serviço de Consulta Psicológica da Faculdade de Psicologia e de Ciências da Educação da Universidade do Porto \n'),
              TextSpan(
                  text: 'Email: secretariado_consultas@fpce.up.pt\n'),
              TextSpan(
                  text: 'Telefone: 22 040 0600 | 22 042 89 22\n'),
              TextSpan(
                  text: 'Centro de Apoio e Serviço Psicológico da Universidade da Maia\n'),
              TextSpan(
                  text: 'Email: casp@ismai.pt\n'),
              TextSpan(
                  text: 'Telefone: 22 986 60 92\n'),
            ]
          ),
        ),

      )

    );
  }


}
