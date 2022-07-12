

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddRecord extends StatefulWidget{
  @override
  _RecordState createState() => _RecordState();

}


class _RecordState extends State<AddRecord>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar registo')
      ),
      body: Text('something'),
    );
  }

}