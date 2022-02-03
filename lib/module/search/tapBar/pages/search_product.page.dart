import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_app/helper/app.widget.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            CustomTextForm(
              hintText: 'البحث عن منتج',
            )
          ],
        ),
      ),
    );
  }
}
