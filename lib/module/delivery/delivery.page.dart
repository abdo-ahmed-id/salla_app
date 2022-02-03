import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({Key key}) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  String _selectedItem = 'اختر الموديل';
  List _options = [
    'مرسيدس',
    'لادا',
    'أودي ',
    'بريليانس ',
    'بيجو ',
    'بروتون ',
  ];
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          SizedBox(height: 40.h),
          Text(
            'لم تقم باضافة عنوان حتي الان',
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 60.h),
          Center(
            child: CustomButton(
              text: 'اضافة عنوان',
              backgroundColor: AppTheme.primaryColor,
              onPressed: () {
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    controller: ModalScrollController.of(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 15.h),
                        CustomTextForm(
                          color: Colors.black,
                          onChanged: (value) {},
                          hintText: 'الاسم بالكامل ',
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 15.h),
                        CustomTextForm(
                          color: Colors.black,
                          initialValue: '+20',
                          onChanged: (value) {},
                          hintText: 'رقم الجوال',
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 15.h),
                        CustomTextForm(
                          color: Colors.black,
                          onChanged: (value) {},
                          hintText: 'اسم الشارع',
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 15.h),
                        CustomTextForm(
                          color: Colors.black,
                          onChanged: (value) {},
                          hintText: 'اسم المدينة',
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        SizedBox(height: 15.h),
                        CustomTextForm(
                          color: Colors.black,
                          onChanged: (value) {},
                          hintText: 'اسم المنطقة',
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        SizedBox(height: 15.h),
                        PopupMenuButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 40,
                                ),
                                SizedBox(width: 120.w),
                                Text(
                                  _selectedItem,
                                  style: GoogleFonts.cairo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (BuildContext bc) {
                            return _options
                                .map((day) => PopupMenuItem(
                                      child: Text(
                                        day,
                                        style: GoogleFonts.cairo(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      value: day,
                                    ))
                                .toList();
                          },
                          onSelected: (value) {
                            setState(() {
                              _selectedItem = value;
                            });
                          },
                        ),
                        SizedBox(height: 15.h),
                        GradientButton(
                          text: 'الحفظ والمتابعة',
                          backgroundColor: AppTheme.primaryColor,
                          textColor: AppTheme.secondaryColor,
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            Modular.to.pushNamed(AppRoutes.confirm);
                          },
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
