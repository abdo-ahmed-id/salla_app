import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:salla_app/data/models/category.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/assets.helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModelStreamGetBuilder<Category>(builder: (context, snapshot) {
      return GridView.builder(
          itemCount: snapshot.data.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 1.2.w,
            crossAxisSpacing: 1.2.h,
            maxCrossAxisExtent: 150.h,
          ),
          itemBuilder: (_, index) {
            Category category = snapshot.data[index];
            return Padding(
              padding: EdgeInsets.all(8.0.h),
              child: InkWell(
                onTap: () {
                  if (index == 10) {
                    setState(() {
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          controller: ModalScrollController.of(context),
                          child: bottomSheet(),
                        ),
                      );
                    });
                  } else {
                    Modular.to
                        .pushNamed(AppRoutes.category, arguments: category);
                  }
                },
                child: Column(
                  children: [
                    Container(
                      height: 80.h,
                      width: 80.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(AssetsHelper.engineImage),
                    ),
                    Text(
                      category.title,
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    )
                  ],
                ),
              ),
            );
          });
    }));
  }

  String _selectedItem1 = 'النمط ';
  String _selectedItem2 = 'مرسيدس';
  String _selectedItem3 = 'الفئة';
  List _options = [
    'مرسيدس',
    'لادا',
    'أودي ',
    'بريليانس ',
    'بيجو ',
    'بروتون ',
  ];

  Widget bottomSheet() {
    return Container(
      color: Colors.grey[300],
      height: 500.h,
      child: Column(
        children: [
          SizedBox(height: 20.h),
          popupItem(
              mainText: 'اختر النمط',
              selectedItem: _selectedItem1,
              list: _options),
          SizedBox(height: 20.h),
          popupItem(
              mainText: 'اختر الموديل',
              selectedItem: _selectedItem2,
              list: _options),
          SizedBox(height: 20.h),
          popupItem(
              mainText: 'اختر فئة السيارة',
              selectedItem: _selectedItem3,
              list: _options),
        ],
      ),
    );
  }

  Widget popupItem({String mainText, String selectedItem, List list}) {
    return PopupMenuButton(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              mainText,
              style:
                  GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 40,
            ),
            SizedBox(width: 120.w),
            Text(
              selectedItem,
              style:
                  GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
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
      onSelected: (value) {
        setState(() {
          selectedItem = value;
        });
      },
    );
  }
}
