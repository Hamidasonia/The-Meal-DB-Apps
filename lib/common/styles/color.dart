import 'package:flutter/material.dart';
import 'package:submission_dicoding_pemula/tool/hex_color.dart';

final hBlack = HexColor("#000000");
final hText = HexColor("00464D");

final MaterialColor mBlack = _convertMateial(0, 0, 0);

MaterialColor _convertMateial(int red, int green, int blue) {
  Map<int, Color> _colorCodes = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return new MaterialColor(0xFF93cd48, _colorCodes);
}
