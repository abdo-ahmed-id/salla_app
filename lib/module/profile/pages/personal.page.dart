import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/module/profile/pages/dialog_widget.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          'المعلومات الشخصية',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: ModelStreamSingleBuilder<UserModel>(onSuccess: (user) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'الاسم بالكامل',
                        style: GoogleFonts.cairo(
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'البريد الالكتروني',
                        style: GoogleFonts.cairo(
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'رقم الجوال',
                        style: GoogleFonts.cairo(
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        user.displayName,
                        style: GoogleFonts.cairo(color: Colors.blueGrey),
                      ),
                      SizedBox(height: 22.h),
                      Text(
                        user.email ?? '',
                        style: GoogleFonts.cairo(color: Colors.blueGrey),
                      ),
                      SizedBox(height: 22.h),
                      Text(
                        user.numPhone ?? '',
                        style: GoogleFonts.cairo(color: Colors.blueGrey),
                      ),
                      SizedBox(height: 22.h),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                text: 'تعديل',
                backgroundColor: AppTheme.primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  _showEditDialog(context, user);
                },
              )
            ],
          ),
        );
      }),
    );
  }

  _showEditDialog(BuildContext context, UserModel user) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      useRootNavigator: false,
      builder: (BuildContext context) => DialogWidget(
        userModel: user,
      ),
    );
  }
}
