import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.theme.dart';

ThemeData darkTheme = ThemeData(
  dialogBackgroundColor: AppTheme.backgroundColor,
  primaryColor: Colors.black,
  cardColor: AppTheme.backgroundColor,
  // primarySwatch: Colors.white,
  backgroundColor: AppTheme.backgroundColor,
  scaffoldBackgroundColor: AppTheme.backgroundColor,
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      iconTheme: IconThemeData(
        color: Colors.white,
        // opacity: 33,
      ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        //    statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 10.0,
      backgroundColor: AppTheme.backgroundColor,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: 'secFont',
      )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppTheme.backgroundColor,
    selectedItemColor: AppTheme.primaryColor,
    elevation: 20.0,
    // backgroundColor: HexColor('333739'),
    unselectedItemColor: AppTheme.secondaryColor,
  ),
  // accentIconTheme:IconThemeData(
  //   color: Colors.white
  // ) ,
  accentColor: Colors.white,
  // primaryIconTheme: IconThemeData(
  //   color: Colors.white
  // ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: AppTheme.secondaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 25),
    subtitle1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        height: 1.4),
    caption: TextStyle(
        color: Colors.white60,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        height: 1.4),
  ),
);

ThemeData lightTheme = ThemeData(
  dialogBackgroundColor: Colors.white,
  // primarySwatch: defaultColor,
  backgroundColor: Colors.white38,
  tabBarTheme: TabBarTheme(labelColor: Colors.white),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
    ),
    subtitle1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        height: 1.4),
    caption: TextStyle(
        //color: Colors.,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        height: 1.4),
  ),
  scaffoldBackgroundColor: Colors.white,
  // scaffoldBackgroundColor: Color.fromRGBO(20,120 ,200, 0.8),
  accentColor: Colors.black,
  appBarTheme: AppBarTheme(
      // toolbarTextStyle:TextStyle(
      //   color: Colors.deepOrange,
      // ) ,
      titleSpacing: 20.0,
      iconTheme: IconThemeData(
        color: Colors.black,
        // opacity: 33,
      ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 3.0,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'secFont',

          // fontWeight: FontWeight.bold,
          fontSize: 50)),
  //cardColor: Color.fromARGB(100, 200, 200, 1),
  cardColor: Colors.blue[50],
  // cardColor: Color.fromARGB(100, 100, 100, 0),
  primaryColorDark: Colors.black54,
  primaryColor: Colors.white,
  // cardColor: Color.fromRGBO(20,100 ,200, 0.8),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppTheme.focusColor,
    // selectedItemColor:Color.fromRGBO(20,100 ,200, 0.8),
    elevation: 20.0,

    backgroundColor: Colors.white,
    unselectedItemColor: Colors.black54,
  ),
);
