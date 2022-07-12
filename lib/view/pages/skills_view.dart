

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class Skills extends StatefulWidget{
  @override
  _SkillsState createState() => _SkillsState();

}


class _SkillsState extends State<Skills>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Competências', style: TextStyle(color: Colors.white),),
        backgroundColor: mainColor,
      ),
      body: Text('Competências'),
    );
  }

}
