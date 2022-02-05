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
                color: Colors.black,
                onChanged: (value) {
                  user.streetName = value;
                },
                hintText: 'اسم الشارع',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15.h),
              CustomTextForm(
                color: Colors.black,
                onChanged: (value) {
                  user.cityName = value;
                },
                hintText: 'اسم المدينة',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15.h),
              CustomTextForm(
                color: Colors.black,
                onChanged: (value) {
                  user.areaName = value;
                },
                hintText: 'اسم المنطقة',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 60.h),
              Center(
                child: CustomButton(
                  text: user.streetName != null ? 'تاكيد' : 'اضافة عنوان',
                  backgroundColor: AppTheme.primaryColor,
                  onPressed: user.streetName != null
                      ? () {
                          Modular.to.pushNamed(AppRoutes.confirm);
                        }
                      : () async {
                          await user.save();
                          Modular.to.pushNamed(AppRoutes.confirm,
                              arguments: widget.product);
                        },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
