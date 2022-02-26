import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/helper/notifications.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';

class LoginPage extends StatelessWidget {
  final AppBloc _appBloc = Modular.get<AppBloc>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            AssetsHelper.backgroundImage,
          ),
        )),
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 80.h),
                    Center(
                      child: Text(
                        'تسجيل الدخول الي حسابك',
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                            color: AppTheme.primaryColor),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(height: 25.h),
                    CustomTextForm(
                      color: Colors.white,
                      onChanged: (value) {
                        _email = value;
                      },
                      hintText: 'البريد الالكتروني',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 15.h),
                    CustomTextForm(
                      color: Colors.white,
                      onChanged: (value) {
                        _password = value;
                      },
                      hintText: 'كلمه المرور',
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    SizedBox(height: 25.h),
                    Center(
                      child: GradientButton(
                        text: 'تسجيل الدخول',
                        backgroundColor: AppTheme.primaryColor,
                        textColor: Colors.black,
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }

                          validationInput(context);
                        },
                      ),
                    ),
                    SizedBox(height: 15.h),
                    CustomTextButton(
                      text: "لا تمتلك حساب ؟",
                      size: 18,
                      onPressed: () {
                        Modular.to.pushReplacementNamed(AppRoutes.signUp);
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextButton(
                      text: 'هل نسيت كلمة المرور؟',
                      size: 18,
                      onPressed: () {
                        Modular.to.pushNamed(AppRoutes.forgetPassword);
                      },
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void validationInput(context) {
    if (_email == null || _email.isEmpty || !_email.contains('@')) {
      Notifications.error('من فضلك قم بادخال بريد الكتروني صحيح');
    } else if (_password == null || _password.isEmpty || _password.length < 6) {
      Notifications.error('من فضلك قم بادخال كلمه مرور صحيحة');
    } else {
      Modular.get<AppBloc>().signIn(context, _email, _password);
    }
  }
}
