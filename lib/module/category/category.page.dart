import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/category.dart';
import 'package:salla_app/data/models/product.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';
import 'package:salla_app/module/category/product.widget.dart';

import '../app/bloc/app.bloc.dart';

class CategoryPage extends StatelessWidget {
  final Category category;
  final AppBloc _appBloc = Modular.get<AppBloc>();
  final AppState _appState = Modular.get<AppBloc>().state;

  CategoryPage({this.category});

  @override
  Widget build(BuildContext context) {
    print(_appState.user.brandCar);
    print(_appState.user.modelCar);
    print(_appState.user.categoryCar);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          category.title,
          style:
              GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 22.sp),
        ),
      ),
      body: ModelStreamGetBuilder<Product>(
          query: category?.carInformation == false
              ? (q) => q
                  .where('categoryCar', isEqualTo: _appState.user.categoryCar)
                  .where('brandCar', isEqualTo: _appState.user.brandCar)
                  .where('modelCar', isEqualTo: _appState.user.modelCar)
              : (q) => q.where('category', isEqualTo: category.title),
          onLoading: () => const Center(child: CircularProgressIndicator()),
          onEmpty: () => const Center(child: Text('لا توجد منتجات حتي الان')),
          onSuccess: (products) {
            return BlocBuilder<AppBloc, AppState>(
                bloc: _appBloc,
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      Product product = products[index];
                      return InkWell(
                          onTap: () {
                            Modular.to.pushNamed(AppRoutes.product,
                                arguments: product);
                          },
                          child: ProductWidget(
                            product: product,
                            appBloc: _appBloc,
                            state: state,
                          ));
                    },
                  );
                });
          }),
    );
  }
}
