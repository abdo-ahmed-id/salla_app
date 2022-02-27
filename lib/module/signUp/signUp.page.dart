import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/helper/constants.dart';
import 'package:salla_app/helper/notifications.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AppBloc _appBloc = Modular.get<AppBloc>();
  String _userName;

  String _email;

  String _password;
  String _confirmPassword;

  String _phoneNum;
  String brandSelect;
  String modelSelect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(
          bloc: _appBloc,
          builder: (context, state) {
            return Container(
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
                          'انشاء حساب',
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
                          hintText: 'الاسم بالكامل',
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 15.h),
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
                          // initialValue: '+20',
                          // maxLength: 11,
                          onChanged: (value) {
                            _phoneNum = value;
                          },
                          hintText: 'رقم المحمول',
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 15.h),
                        CustomTextForm(
                          color: Colors.white,
                          onChanged: (value) {
                            _password = value;
                          },
                          hintText: 'كلمة المرور',
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        SizedBox(height: 15.h),
                        CustomTextForm(
                          color: Colors.white,
                          onChanged: (value) {
                            _confirmPassword = value;
                          },
                          hintText: 'تاكيد كلمة المرور',
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        SizedBox(height: 15.h),
                        popupItem(
                          onSelect: (value) {
                            Modular.get<AppBloc>()
                                .selectItem(brandSelect: value);
                          },
                          mainText: 'اختر ماركة السيارة' ?? '',
                          selectedItem: state.brandSelect,
                          list: Constants.brandCars,
                        ),
                        SizedBox(height: 20.h),
                        popupItem(
                            onSelect: (value) {
                              Modular.get<AppBloc>()
                                  .selectItem(modelSelect: value);
                            },
                            mainText: 'اختر الموديل',
                            selectedItem: state.modelSelect ?? '',
                            list: modelList(state)),
                        SizedBox(height: 45.h),
                        GradientButton(
                          text: 'انشاء حساب',
                          backgroundColor: AppTheme.primaryColor,
                          textColor: AppTheme.secondaryColor,
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            validationInput(context, state);
                          },
                        ),
                        CustomTextButton(
                          text: 'تراجع',
                          size: 18,
                          onPressed: () {
                            Modular.to.pop();
                          },
                        ),
                        SizedBox(height: 25.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void validationInput(context, AppState state) async {
    if (_email == null || !_email.contains('@')) {
      Notifications.error('يرجي ادخال بريد الكتروني صحيح');
    } else if (_userName == null) {
      Notifications.error('يرجي ادخال اسمك بشكل صحيح');
    } else if (_phoneNum == null) {
      Notifications.error('يرجي ادخال رقم محمول صحيح');
    } else if (state.brandSelect == null || state.modelSelect == null) {
      Notifications.error('يرجي ادخال بيانات سيارتك');
    } else if (_password == null ||
        _password.length < 6 ||
        _confirmPassword != _password) {
      Notifications.error('يرجي ادخال كلمة مرور صحيحة');
    } else {
      Modular.get<AppBloc>().createAccount(
          context: context,
          userModel: UserModel(
              displayName: _userName,
              email: _email,
              numPhone: _phoneNum,
              password: _password,
              brandCar: state.brandSelect,
              modelCar: state.modelSelect));
    }
  }

  static Widget popupItem(
      {String mainText, String selectedItem, List list, Function onSelect}) {
    return PopupMenuButton(
      child: ListTile(
        title: Row(
          children: [
            Text(
              mainText,
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 40,
              color: Colors.white,
            ),
            // SizedBox(width: 120.w),
          ],
        ),
        trailing: Text(
          selectedItem ?? '',
          style: GoogleFonts.cairo(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor),
        ),
      ),
      itemBuilder: (BuildContext bc) {
        return list
            .map((day) => PopupMenuItem(
                  child: Text(
                    day,
                    style: GoogleFonts.cairo(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  value: day,
                ))
            .toList();
      },
      onSelected: onSelect,
    );
  }

  static List modelList(AppState state) {
    if (state.brandSelect == 'MG') {
      return Constants.mGModelCars;
    } else if (state.brandSelect == 'BYD') {
      return Constants.bYDModelCars;
    } else if (state.brandSelect == 'DFSK') {
      return Constants.dFSKModelCars;
    } else if (state.brandSelect == 'اسبرانزا') {
      return Constants.ispranzaModelCars;
    } else if (state.brandSelect == 'البينا') {
      return Constants.albenaModelCars;
    } else if (state.brandSelect == 'الفروميو') {
      return Constants.alfaromioModelCars;
    } else if (state.brandSelect == 'اوبل') {
      return Constants.appleModelCars;
    } else if (state.brandSelect == 'اوداي') {
      return Constants.odayModelCars;
    } else if (state.brandSelect == 'بروتون') {
      return Constants.protonModelCars;
    } else if (state.brandSelect == 'بريليانس') {
      return Constants.brelyansModelCars;
    } else if (state.brandSelect == 'بيجو') {
      return Constants.bigoModelCars;
    } else if (state.brandSelect == 'تشانجان') {
      return Constants.tshanganModelCars;
    } else if (state.brandSelect == 'تويوتا') {
      return Constants.toyotaModelCars;
    } else if (state.brandSelect == 'جاك') {
      return Constants.jakModelCars;
    } else if (state.brandSelect == 'جريتوول') {
      return Constants.gretoolModelCars;
    } else if (state.brandSelect == 'جلوري') {
      return Constants.gloaryModelCars;
    } else if (state.brandSelect == 'جيب') {
      return Constants.geepModelCars;
    } else if (state.brandSelect == 'مرسيدس') {
      return Constants.marsedesModelCars;
    }
  }
}
