import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/helper/app.theme.dart';

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
          child: Row(
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
        );
      }),
    );
  }
}
