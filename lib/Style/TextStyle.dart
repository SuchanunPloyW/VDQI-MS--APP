
import 'package:flutter/material.dart';
import 'package:vdqims/Style/ColorTheme.dart';

// < ------------------      Alert        ------------------>
class TextStyleAlert{
  static TextStyle body18bold= TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ColorTheme.bold,
    fontFamily: ('IBM Plex Sans Thai'),

  );
  static TextStyle body15normal = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: ColorTheme.grey
  );

  static TextStyle body15bold = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: ColorTheme.grey
  );
}
// < ------------------      MenuName        ------------------>
// Thai Menu
class TextStyleMenuName{

  static TextStyle bodyMenuThai = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: ColorTheme.white,
    fontFamily: ('IBM Plex Sans Thai'),
  );
  static TextStyle bodyMenuEng = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorTheme.white,
    fontFamily: ('IBM Plex Sans Thai'),
  );
}





// < ------------------      Foot        ------------------>
class TextStyleFoot{
  static TextStyle bodyfoot= TextStyle(
    fontSize: 11,
    color: ColorTheme.foot,
    fontFamily: ('IBM Plex Sans Thai'),
  );
  
}