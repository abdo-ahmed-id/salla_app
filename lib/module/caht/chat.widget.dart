import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.theme.dart';

class ReMassageWidget extends StatelessWidget {
  String text;
  ReMassageWidget({this.text});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text.trim(),
            style: GoogleFonts.cairo(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class SeMassageWidget extends StatelessWidget {
  String text;
  SeMassageWidget({this.text});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text.trim(),
            style: GoogleFonts.cairo(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
