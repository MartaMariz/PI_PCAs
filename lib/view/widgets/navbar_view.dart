

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';
class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Conteúdo',
      style: optionStyle,
    ),
    Text(
      'Index 1: Registo Diário',
      style: optionStyle,
    ),
    Text(
      'Index 2: Perfil',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded),
          label: 'Conteúdo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'Registo Diário',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: mainColor,
      onTap: _onItemTapped,
    );
  }
}
