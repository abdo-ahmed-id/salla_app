import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/users.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModelStreamSingleBuilder<UserModel>(onSuccess: (user) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الاسم بالكامل',
                  style: GoogleFonts.cairo(
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'اسم المدينة',
                  style: GoogleFonts.cairo(
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'اسم المنطقة',
                  style: GoogleFonts.cairo(
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'اسم الشارع',
                  style: GoogleFonts.cairo(
                    fontSize: 20.sp,
                  ),
                ),
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
                  user.cityName,
                  style: GoogleFonts.cairo(color: Colors.blueGrey),
                ),
                SizedBox(height: 22.h),
                Text(
                  user.areaName,
                  style: GoogleFonts.cairo(color: Colors.blueGrey),
                ),
                SizedBox(height: 22.h),
                Text(
                  user.streetName,
                  style: GoogleFonts.cairo(color: Colors.blueGrey),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
