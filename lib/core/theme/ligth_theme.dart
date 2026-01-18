import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xffFFFFFF),
    secondary: Color(0xff3A4640),
  ),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffF6F7F9),
    // foregroundColor: Color(0xff161F1B),
    titleTextStyle: TextStyle(color: Color(0xFF161F1B), fontSize: 20),
    elevation: 0,
    centerTitle: false,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      } else {
        return Colors.white;
      }
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xff9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xff9E9E9E);
    }),

    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.black)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(Color(0xffFFFCFC)),
      backgroundColor: WidgetStatePropertyAll(Color(0xff15B86C)),
    ),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xffF6F7F9),
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 32, color: Color(0xff161F1B)),

    displayMedium: TextStyle(fontSize: 28, color: Color(0xff161F1B)),
    displaySmall: TextStyle(fontSize: 24, color: Color(0xff161F1B)),
    // bodyMedium: TextStyle(fontSize: 16, color: Color(0xff161F1B)),
    // bodySmall: TextStyle(fontSize: 14, color: Color(0xff161F1B)),
    labelMedium: TextStyle(color: Color(0xff181818), fontSize: 16),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xff3A4640),
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xff6A6A6A),

      decoration: TextDecoration.lineThrough,

      decorationColor: Color(0xff6A6A6A),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      fontSize: 20,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: .5),
    ),

    filled: true,
    focusColor: Color(0xffD1DAD6),
    fillColor: Color(0xffFFFFFF),
    hintStyle: TextStyle(color: Color(0xff9E9E9E)),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xffD1DAD6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xff161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xffD1DAD6)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.blue,
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Color(0xff3A4640),
    backgroundColor: Color(0xffF6F7F9),
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xff15B86C),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xffF6F7F9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
    ),
  ),
);
