import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/helper/notifications.dart';

class ForgetPasswordPage extends StatelessWidget {
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
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
                  'اعادة كلمة المرور',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp,
                      color: Colors.deepOrange),
                ),
                SizedBox(height: 15.h),
                CustomTextForm(
                  hintText: 'بريدك الالكتروني',
                  color: Colors.white,
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextButton(
                  text: 'لقد تذكرت كلمة المرور',
                  onPressed: () {
                    print('email$_email');
                    Modular.to.pushReplacementNamed(AppRoutes.login);
                  },
                ),
                SizedBox(height: 10.h),
                CustomTextButton(
                  text: 'انشاء كلمة مرور جديدة',
                  onPressed: () {
                    try {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      if (_email == null ||
                          _email.isEmpty ||
                          !_email.contains('@')) {
                        Notifications.error(
                            'من فضلك قم بادخال بريد الكتروني صحيح');
                      } else {
                        print('email$_email');

                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: _email)
                            .then((value) => Notifications.success(
                                'من فضلك قم بزيارة بريدك الالكتروني'))
                            .catchError((e) {
                          print('error${e}');

                          // Notifications.error('error $e');
                        });
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'invalid-email') {
                        Notifications.error(e.message);
                      } else if (e.code == 'user-not-found') {
                        Notifications.error(e.message);
                      } else if (e.code == 'wrong-password') {
                        Notifications.error(e.message);
                      } else if (e.code == 'user-disabled') {
                        Notifications.error(e.message);
                      }
                    } catch (e) {
                      Notifications.error(e.message);
                    }
                    return null;
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
