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
import 'package:salla_app/module/home/home_widget.dart';

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
                  if (index == 1) {
                    showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        controller: ModalScrollController.of(context),
                        child: HomeWidget.bottomSheet(),
                      ),
                    );
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
}
