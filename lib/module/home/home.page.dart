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
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';
import 'package:salla_app/module/app/service/auth.service.dart';
import 'package:salla_app/module/home/home_widget.dart';

class HomePage extends StatefulWidget {
  AppState appState = Modular.get<AppBloc>().state;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Modular.get<AppBloc>().initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModelStreamGetBuilder<Category>(builder: (context, snapshot) {
      return GridView.builder(
          itemCount: snapshot.data.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 1.2.w,
            crossAxisSpacing: 1.3.h,
            maxCrossAxisExtent: 130.w,
          ),
          itemBuilder: (_, index) {
            Category category = snapshot.data[index];
            return Padding(
              padding: EdgeInsets.all(8.0.h),
              child: InkWell(
                onTap: AuthService.isLogin
                    ? () {
                        if (category.carInformation == true) {
                          showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              controller: ModalScrollController.of(context),
                              child: HomeWidget.bottomSheet(index, category),
                            ),
                          );
                        } else {
                          Modular.to.pushNamed(AppRoutes.category,
                              arguments: category);
                        }
                      }
                    : () {
                        if (category.carInformation == true) {
                          Modular.to.pushNamed(AppRoutes.login);
                        } else {
                          Modular.to.pushNamed(AppRoutes.category,
                              arguments: category);
                        }
                      },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 100.h,
                        width: 100.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          category.imageScr ?? AssetsHelper.networkImage,
                          fit: BoxFit.contain,
                          height: 100.h,
                          width: 100.w,
                        ),
                      ),
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
