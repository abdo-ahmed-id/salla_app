import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:salla_app/module/login/login.page.dart';

loginButtomSheete({BuildContext context}) {
  showMaterialModalBottomSheet(
    context: context,
    builder: (context) => LoginPage(),
  );
}
