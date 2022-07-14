

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class AddRecord extends StatefulWidget{
  @override
  _RecordState createState() => _RecordState();

}


class _RecordState extends State<AddRecord>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        centerTitle: true,
        title: const Text('Novo registo', style: TextStyle(color: Colors.white,
        fontFamily: 'Mulish',
          fontSize: 20.0,
        ),),
        backgroundColor: mainColor,
      ),
      body: Text(''),
    );
  }

}