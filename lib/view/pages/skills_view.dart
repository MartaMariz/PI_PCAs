

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Skills extends StatefulWidget{
  @override
  _SkillsState createState() => _SkillsState();

}


class _SkillsState extends State<Skills>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Competências')
      ),
      body: Text('Competências'),
    );
  }

}
