import 'package:flutter/material.dart';
import '../Extensions/extensions.dart';

class Constants {

//Colors
static Color lightThemeBackgroundColor = Colors.white;
static Color darkThemeBackgroundColor = HexColor.fromHex("#1E2439");
static Color darkThemeSecondaryBackgroundColor = HexColor.fromHex("#283153");
static Color lightThemePrimaryColor = HexColor.fromHex('#00F6FF');
static Color darkThemePrimaryColor = HexColor.fromHex('#00F6FF');
static Color lightThemeSecondaryColor = HexColor.fromHex('#00F6FF').withOpacity(0.2);
static Color darkThemeSecondaryColor = HexColor.fromHex('#707070');
static Color lightThemeTextPrimaryColor = Colors.black;
static Color lightThemeTextSecondaryColor = Colors.black.withOpacity(0.5);
static Color darkThemeTextPrimaryColor = Colors.white;
static Color darkThemeTextSecondaryColor = Colors.white.withOpacity(0.5);

//Fonts
static  TextStyle lightThemeTitleTextStyle = TextStyle( 
  fontSize: 24, fontFamily: 'Roboto', fontWeight: FontWeight.bold,color: lightThemeTextPrimaryColor
);

static  TextStyle darkThemeTitleTextStyle = TextStyle( 
  fontSize: 24, fontFamily: 'Roboto', fontWeight: FontWeight.bold,color: darkThemeTextPrimaryColor
);

static  TextStyle titleTextStyle = const TextStyle( 
  fontSize: 24, fontFamily: 'Roboto', fontWeight: FontWeight.bold, 
);




}