

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
        title: const Text('Novo registo', style: TextStyle(color: Colors.white),),
        backgroundColor: mainColor,
      ),
      body: Text('something'),
    );
  }

}