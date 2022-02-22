import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/notifications.dart';

class DialogWidget extends StatelessWidget {
  final UserModel userModel;

  DialogWidget({this.userModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Center(
          child: Text(
            'تعديل معلوماتك',
            style: TextStyle(
                backgroundColor: Theme.of(context).cardColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              validationInput();
            },
            child: Text(
              'حفظ'.tr(),
              style: TextStyle(color: AppTheme.primaryColor, fontSize: 18.sp),
            ),
          ),
          TextButton(
            onPressed: () {
              Modular.to.pop();
            },
            child: Text(
              'الغاء'.tr(),
              style: TextStyle(color: Colors.red, fontSize: 18.sp),
            ),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryTextField(
                maxLength: 20,
                onChanged: (value) {
                  userModel.displayName = value;
                },
                initialValue: userModel?.displayName,
                hintText: 'الاسم بالكامل',
                keyboardType: TextInputType.text,
              ),
              PrimaryTextField(
                onChanged: (value) {
                  userModel.email = value;
                },
                initialValue: userModel?.email,
                hintText: 'البريد الالكتروني',
                keyboardType: TextInputType.emailAddress,
              ),
              PrimaryTextField(
                onChanged: (value) {
                  userModel.numPhone = value;
                },
                initialValue:
                    userModel.numPhone == '' ? '' : userModel?.numPhone,
                hintText: 'رقم المحمول',
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ));
  }

  void validationInput() async {
    if (userModel.email == null || !userModel.email.contains('@')) {
      Notifications.error('please enter correct email'.tr());
    } else if (userModel.displayName == null) {
      Notifications.error('please enter correct username'.tr());
    } else if (userModel.numPhone == null || userModel.numPhone.length != 13) {
      Notifications.error('please enter correct phoneNum'.tr());
    } else {
      await userModel.save(setOptions: SetOptions(merge: true));
      userModel.save();
      Modular.to.pop();
    }
  }
}
