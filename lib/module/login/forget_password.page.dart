import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';

class ForgetPasswordPage extends StatelessWidget {
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              AssetsHelper.backgroundImage,
            ),
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80.h),
                Text(
                  'Forget Password',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp,
                      color: Colors.deepOrange),
                ),
                SizedBox(height: 15.h),
                CustomTextForm(
                  hintText: 'Your Email',
                  color: Colors.white,
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextButton(
                  text: 'I Remember Your Password ?',
                  onPressed: () {
                    print('email$_email');
                    Modular.to.pushReplacementNamed(AppRoutes.login);
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextButton(
                  text: 'Create New Password',
                  onPressed: () {
                    try {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      if (_email == null ||
                          _email.isEmpty ||
                          !_email.contains('@')) {
                        // Notifications.error('please enter correct email'.tr());
                      } else {
                        print('email$_email');

                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: _email)
                            .then((value) => null)
                            .catchError((e) {
                          print('error$e');
                          // Notifications.error('error $e');
                        });
                      }
                    } on FirebaseAuthException catch (e) {
                      print('error $e');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
