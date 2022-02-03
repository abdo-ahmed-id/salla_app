import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Modular.get<AppBloc>().initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3100));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();

    Timer(Duration(seconds: 4),
        () => Modular.to.pushReplacementNamed(AppRoutes.mainHome));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Salla',
              style: GoogleFonts.cairo(
                  fontSize: 60, fontWeight: FontWeight.bold, letterSpacing: 3),
            ),
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                alignment: FractionalOffset(_animation.value, 0),
                image: AssetImage(
                  AssetsHelper.shoppingCart,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
