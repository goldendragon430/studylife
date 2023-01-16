import 'package:flutter/material.dart';
import '../Extensions/extensions.dart';

class Constants {
//Colors
  static Color lightThemeBackgroundColor = Colors.white;
  static Color darkThemeBackgroundColor = HexColor.fromHex("#1E2439");
  static Color darkThemeSecondaryBackgroundColor = HexColor.fromHex("#283153");
  static Color lightThemePrimaryColor = HexColor.fromHex('#00F6FF');
  static Color darkThemePrimaryColor = HexColor.fromHex('#00F6FF');
  static Color lightThemeSecondaryColor =
      HexColor.fromHex('#00F6FF').withOpacity(0.2);
  static Color darkThemeSecondaryColor = HexColor.fromHex('#707070');
  static Color lightThemeTextPrimaryColor = Colors.black;
  static Color lightThemeTextSecondaryColor = Colors.black.withOpacity(0.5);
  static Color darkThemeTextPrimaryColor = Colors.white;
  static Color darkThemeTextSecondaryColor = Colors.white.withOpacity(0.5);
  static Color lightThemeTextSelectionColor = HexColor.fromHex("#0F116C");
  static Color darkThemeTextSelectionColor = HexColor.fromHex('#00F6FF');
  static Color darkThemeNavigationBarColor = HexColor.fromHex('#1A1B21');
  static Color lightThemeUnselectedTextColor = Colors.black.withOpacity(0.7);
  static Color darkThemeUnselectedTextColor = Colors.white.withOpacity(0.5);

    static const MaterialColor kToLight = MaterialColor(
    0xffffffff, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffe6e6e6), //10%
      100: Color(0xffcccccc), //20%
      200: Color(0xffb3b3b3), //30%
      300: Color(0xff999999), //40%
      400: Color(0xff808080), //50%
      500: Color(0xff666666), //60%
      600: Color(0xff4c4c4c), //70%
      700: Color(0xff333333), //80%
      800: Color(0xff191919), //90%
      900: Color(0xff000000), //100%
    },
  );

  static const MaterialColor kToDark = MaterialColor(
    0xff1e2439, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff1b2033), //10%
      100: Color(0xff181d2e), //20%
      200: Color(0xff151928), //30%
      300: Color(0xff121622), //40%
      400: Color(0xff0f121d), //50%
      500: Color(0xff0c0e17), //60%
      600: Color(0xff090b11), //70%
      700: Color(0xff06070b), //80%
      800: Color(0xff030406), //90%
      900: Color(0xff000000), //100%
    },
  );

//Fonts
  static TextStyle lightThemeTitleTextStyle = TextStyle(
      fontSize: 24,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: lightThemeTextPrimaryColor);

  static TextStyle darkThemeTitleTextStyle = TextStyle(
      fontSize: 24,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: darkThemeTextPrimaryColor);

  static TextStyle titleTextStyle = const TextStyle(
    fontSize: 24,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );
}