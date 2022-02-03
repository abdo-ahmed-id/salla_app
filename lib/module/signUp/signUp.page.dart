import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AppBloc _appBloc = Modular.get<AppBloc>();
  String _userName;

  String _email;

  String _password;

  String _phoneNum;
  bool checkedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sign Up',
                    style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.sp,
                        color: AppTheme.primaryColor),
                  ),
                  SizedBox(height: 25.h),
                  CustomTextForm(
                    color: Colors.white,
                    onChanged: (value) {
                      _userName = value;
                    },
                    hintText: 'User Name',
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15.h),
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
                    initialValue: '+20',
                    onChanged: (value) {
                      _phoneNum = value;
                    },
                    hintText: 'Phone',
                    keyboardType: TextInputType.phone,
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
                  CustomTextForm(
                    color: Colors.white,
                    onChanged: (value) {
                      _password = value;
                    },
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  // Checkbox(
                  //     activeColor: Colors.green,
                  //     value: false,
                  //     onChanged: (newValue) {
                  //       checkedValue = newValue;
                  //     }),
                  SizedBox(height: 45.h),
                  GradientButton(
                    text: 'SignUp',
                    backgroundColor: AppTheme.primaryColor,
                    textColor: AppTheme.secondaryColor,
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      _appBloc.createAccount(_email, _password);
                    },
                  ),
                  CustomTextButton(
                    text: 'Skip',
                    size: 18,
                    onPressed: () {
                      Modular.to.pushReplacementNamed(AppRoutes.mainHome);
                    },
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
