import 'package:flutter/material.dart';

class ColorStyle {
  ColorStyle._();
  static const backgroundColor = Color(0xffE5E5E5);
  static const whiteColor = Color(0xffFFFFFF);
  static const headingColor = Color(0xff000000);
  static const subHeadingColor = Color(0xff5e5c5c);
  static const incompleteColor = Color(0xffc45454);
  static const completedColor = Color(0xff28770d);

}


//From this class styling of text can be updated directly
class TxtStyle{
  static const headingStyle = TextStyle(
      fontSize: 20,
      color: ColorStyle.headingColor,
      fontFamily: 'roboto',
      fontWeight: FontWeight.w700);

   static const subHeadingStyle = TextStyle(
      fontSize: 14,
      color: ColorStyle.subHeadingColor,
       fontFamily: 'roboto',
      fontWeight: FontWeight.w500);

   static const badgeStyle = TextStyle(
      fontSize: 12,
      fontFamily: 'roboto',
      fontWeight: FontWeight.w500);

}

//This is using for updating theme in main.dart file
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006879),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFAAEDFF),
  onPrimaryContainer: Color(0xFF001F26),
  secondary: Color(0xFF984813),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFDBCA),
  onSecondaryContainer: Color(0xFF331100),
  tertiary: Color(0xFF00677D),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFB3EBFF),
  onTertiaryContainer: Color(0xFF001F27),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFFFFFF),
  onBackground: Color(0xFF001F25),
  surface: Color(0xFFF8FDFF),
  onSurface: Color(0xFF001F25),
  surfaceVariant: Color(0xFFDBE4E7),
  onSurfaceVariant: Color(0xFF3F484B),
  outline: Color(0xFF70797B),
  onInverseSurface: Color(0xFFD6F6FF),
  inverseSurface: Color(0xFF00363F),
  inversePrimary: Color(0xFF54D6F3),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006879),
  outlineVariant: Color(0xFFBFC8CB),
  scrim: Color(0xFF000000),
);
