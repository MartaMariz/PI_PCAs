import 'package:flutter/material.dart';

const Color mainColor = Color.fromRGBO(0XB4, 0x8D, 0xE5, 1);

class Palette{
  static const MaterialColor color = MaterialColor(0XB48DE5,
      <int, Color> {
        50: Color(0XB48DE5),
        100: Color(0XB48DE5),
        200: Color(0XB48DE5),
        300: Color(0XB48DE5),
        400: Color(0XB48DE5),
        500: Color(0XB48DE5),
        600: Color(0XB48DE5),
        700: Color(0XB48DE5),
        800: Color(0XB48DE5),
        900: Color(0XB48DE5),
        0: Color(0XB48DE5),


      });

}


Map<int, Color> color =
{
      50:Color.fromRGBO(0xB4, 0x8D, 0xE5, 1),
      100:Color.fromRGBO(0xB4, 0x8D, 0xE5, .2),
      200:Color.fromRGBO(0xB4, 0x8D, 0xE5, .3),
      300:Color.fromRGBO(0xB4, 0x8D, 0xE5, .4),
      400:Color.fromRGBO(0xB4, 0x8D, 0xE5, .5),
      500:Color.fromRGBO(0xB4, 0x8D, 0xE5, .6),
      600:Color.fromRGBO(0xB4, 0x8D, 0xE5, .7),
      700:Color.fromRGBO(0xB4, 0x8D, 0xE5, .8),
      800:Color.fromRGBO(0xB4, 0x8D, 0xE5, .9),
      900:Color.fromRGBO(0xB4, 0x8D, 0xE5, 1),
};
MaterialColor materialMainColor = MaterialColor(0xB48DE5, color);





