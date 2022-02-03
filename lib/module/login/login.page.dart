import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
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
                    Text(
                      'Welcome Back!',
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
                          color: AppTheme.primaryColor),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'Login To Your Account',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    CustomTextForm(
                      color: Colors.white,
                      onChanged: (value) {
                        _email = value;
                      },
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 15.h),
                    CustomTextForm(
                      color: Colors.white,
                      onChanged: (value) {
                        _password = value;
                      },
                      hintText: 'Password',
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    SizedBox(height: 15.h),
                    CustomTextButton(
                      text: 'Forget Your Password?',
                      size: 18,
                      onPressed: () {
                        Modular.to.pushNamed(AppRoutes.forgetPassword);
                      },
                    ),
                    Center(
                      child: GradientButton(
                        text: 'Login',
                        backgroundColor: AppTheme.primaryColor,
                        textColor: Colors.black,
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          _appBloc.signIn(_email, _password);
                          // validationInput(context);
                        },
                      ),
                    ),
                    SizedBox(height: 15.h),
                    CustomTextButton(
                      text: "If You Don't have Account?",
                      size: 18,
                      onPressed: () {
                        Modular.to.pushReplacementNamed(AppRoutes.signUp);
                      },
                    ),
                    Center(
                      child: CustomTextButton(
                        text: "Skip",
                        size: 18,
                        onPressed: () {
                          Modular.to.pushReplacementNamed(AppRoutes.mainHome);
                        },
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
