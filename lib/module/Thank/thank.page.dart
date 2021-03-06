import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.routes.dart';

class ThankPage extends StatefulWidget {
  @override
  _ThankPageState createState() => _ThankPageState();
}

class _ThankPageState extends State<ThankPage> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Colors.blue, Colors.black, Colors.deepOrange],
  ).createShader(const Rect.fromLTWH(50.0, 10.0, 200.0, 70.0));
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () => Modular.to.navigate(AppRoutes.mainHome));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'شكرا لك',
                style: GoogleFonts.cairo(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
              Text(
                'سيصلك الطلب خلال 48 ساعه سيقوم احد موظفينا بالتواصل معك',
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
