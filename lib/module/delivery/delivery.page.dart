import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/shopping_cart.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/notifications.dart';

class DeliveryPage extends StatefulWidget {
  final ShoppingCart product;
  const DeliveryPage({Key key, this.product}) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  @override
  Widget build(BuildContext context) {
    return ModelStreamSingleBuilder<UserModel>(onSuccess: (user) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          title: Text(
            'التوصيل',
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              user.areaName == null
                  ? Text(
                      ' ${user.displayName}\n لم تقم باضافة عنوان حتي الان',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    )
                  : Text(
                      'عنوانك : ${user.cityName} - ${user.areaName} - ${user.streetName} ',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
              SizedBox(height: 15.h),
              CustomTextForm(
                initialValue: user.streetName ?? '',
                color: Colors.black,
                onChanged: (value) {
                  user.streetName = value;
                },
                hintText: 'اسم الشارع',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15.h),
              CustomTextForm(
                initialValue: user.cityName ?? '',
                color: Colors.black,
                onChanged: (value) {
                  user.cityName = value;
                },
                hintText: 'اسم المدينة',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15.h),
              CustomTextForm(
                initialValue: user.areaName ?? '',
                color: Colors.black,
                onChanged: (value) {
                  user.areaName = value;
                },
                hintText: 'اسم المنطقة',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15.h),
              CustomTextForm(
                initialValue: user.buildingNum ?? '',
                color: Colors.black,
                onChanged: (value) {
                  user.buildingNum = value;
                },
                hintText: 'رقم العمارة',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15.h),
              CustomTextForm(
                initialValue: user.flatNum ?? '',
                color: Colors.black,
                onChanged: (value) {
                  user.flatNum = value;
                },
                hintText: 'رقم الشقة',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 60.h),
              Center(
                child: CustomButton(
                    text: user.streetName != null ? 'تاكيد' : 'اضافة عنوان',
                    backgroundColor: AppTheme.primaryColor,
                    onPressed: () {
                      validationInput(user);
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }

  void validationInput(UserModel user) async {
    if (user.streetName == null || user.streetName.isEmpty) {
      Notifications.error('يجب ادخال اسم الشارع');
    } else if (user.areaName == null || user.areaName.isEmpty) {
      Notifications.error('يجب ادخال اسم المنطقة');
    } else if (user.cityName == null || user.cityName.isEmpty) {
      Notifications.error('يجب ادخال اسم المدينة');
    } else if (user.buildingNum == null || user.buildingNum.isEmpty) {
      Notifications.error('يجب ادخال رقم العمارة');
    } else if (user.flatNum == null || user.flatNum.isEmpty) {
      Notifications.error('يجب ادخال رقم الشقة');
    } else {
      await user.save();
      Modular.to.pushNamed(AppRoutes.confirm,
          arguments: {'product': widget.product, 'user': user});
    }
  }
}
