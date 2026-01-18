import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(primaryContainer: Color(0xff282828),secondary:Color(0xffC6C6C6) ),
  brightness: Brightness.dark,
  
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff181818),
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 20,
    ),    elevation: 0,
    centerTitle: false,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }
      return Colors.white;
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
  ),textButtonTheme: TextButtonThemeData(style: ButtonStyle(foregroundColor:WidgetStatePropertyAll(Colors.white)

)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(Color(0xffFFFCFC)),
      backgroundColor: WidgetStatePropertyAll(Color(0xff15B86C)),
    ),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xff181818),
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 32, color: Color(0xffC6C6C6)),
    displayMedium: TextStyle(fontSize: 28, color: Color(0xffffffff)),
    displaySmall: TextStyle(fontSize: 24, color: Color(0xffffffff)),
    // bodyMedium: TextStyle(fontSize: 16, color: Color(0xffffffff)),
    // bodySmall: TextStyle(fontSize: 14, color: Color(0xffffffff)),
    labelMedium: TextStyle(color: Color(0xffFFFCFC), fontSize: 16),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xffC6C6C6),
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xffA0A0A0),

      decoration: TextDecoration.lineThrough,

      decorationColor: Color(0xffA0A0A0),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      fontSize: 20,
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: .5),
    ),
    filled: true,
    fillColor: Color(0xff282828),
    hintStyle: TextStyle(color: Color(0xff6D6D6D)),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStatePropertyAll(Color(0xffFFFFFF)),
  ),
  iconTheme: IconThemeData(color:Color(0xffFFFCFC), ),
    listTileTheme: ListTileThemeData( titleTextStyle:TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
    ), ),
    dividerTheme: DividerThemeData(color: Color(0xff6E6E6E)),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white,selectionColor: Colors.blue,selectionHandleColor: Colors.white),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
  unselectedItemColor: Color(0xffC6C6C6),

    backgroundColor: Color(0xff181818),

showUnselectedLabels: true,
type: BottomNavigationBarType.fixed,
selectedItemColor: Color(0xff15B86C),),
    splashFactory: NoSplash.splashFactory,
  popupMenuTheme:PopupMenuThemeData(
    color: Color(0xff181818),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    labelTextStyle: WidgetStateProperty.all(TextStyle(fontSize: 20,fontWeight: FontWeight.w400))
  )

);
