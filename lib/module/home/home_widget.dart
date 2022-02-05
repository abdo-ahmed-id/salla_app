import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/constants.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';

class HomeWidget {
  static Widget bottomSheet() {
    return BlocBuilder<AppBloc, AppState>(
        bloc: Modular.get<AppBloc>(),
        builder: (context, state) {
          return Container(
            color: Colors.grey[300],
            height: 500.h,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                popupItem(
                    mainText: 'اختر النمط',
                    onSelect: (value) {
                      Modular.get<AppBloc>().selectItem(categorySelect: value);
                    },
                    selectedItem: state.categorySelect ?? '',
                    list: Constants.categoryCars),
                SizedBox(height: 20.h),
                popupItem(
                    onSelect: (value) {
                      Modular.get<AppBloc>().selectItem(brandSelect: value);
                    },
                    mainText: 'اختر فئة السيارة' ?? '',
                    selectedItem: state.brandSelect,
                    list: Constants.brandCars),
                SizedBox(height: 20.h),
                popupItem(
                    onSelect: (value) {
                      Modular.get<AppBloc>().selectItem(modelSelect: value);
                    },
                    mainText: 'اختر الموديل',
                    selectedItem: state.modelSelect ?? '',
                    list: modelList(state)),
                SizedBox(height: 20.h),
                if (state.modelSelect != null &&
                    state.brandSelect != null &&
                    state.categorySelect != null)
                  CustomButton(
                    text: 'حفظ',
                    textColor: Colors.black,
                    backgroundColor: AppTheme.primaryColor,
                    onPressed: () {
                      state.user.update(data: {
                        'categoryCar': state.categorySelect,
                        'brandCar': state.brandSelect,
                        'modelCar': state.modelSelect,
                      });
                      Modular.to.pushNamed(AppRoutes.category);
                    },
                  )
              ],
            ),
          );
        });
  }

  static Widget popupItem(
      {String mainText, String selectedItem, List list, Function onSelect}) {
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
              selectedItem ?? '',
              style: GoogleFonts.cairo(
                  fontSize: 20.sp, fontWeight: FontWeight.bold),
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
      onSelected: onSelect,
    );
  }

  static List modelList(AppState state) {
    if (state.brandSelect == 'MG') {
      return Constants.mGModelCars;
    }
    if (state.brandSelect == 'BYD') {
      return Constants.bYDModelCars;
    }
  }
}
