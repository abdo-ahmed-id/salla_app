import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/category.dart';
import 'package:salla_app/data/models/product.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';
import 'package:salla_app/module/category/product.widget.dart';

import '../app/bloc/app.bloc.dart';

class CategoryPage extends StatelessWidget {
  final Category category;
  final AppBloc _appBloc = Modular.get<AppBloc>();
  final AppState _appState = Modular.get<AppBloc>().state;
  Product product;

  CategoryPage({this.category});

  @override
  Widget build(BuildContext context) {
    // print(_appState.user.brandCar);
    // print(_appState.user.modelCar);
    // print(_appState.user.categoryCar);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          category.title,
          style:
              GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 22.sp),
        ),
      ),
      body: FutureBuilder(
          future: allProduct(),
          builder: (context, snapshot) {
            return BlocBuilder<AppBloc, AppState>(
                bloc: _appBloc,
                builder: (context, state) {
                  if (!snapshot.hasData) {
                    return Text('');
                  }
                  print('data ${snapshot.data}');
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      product = snapshot.data[index];
                      return InkWell(
                          // onTap: () {
                          //   Modular.to.pushNamed(AppRoutes.product,
                          //       arguments: product);
                          // },
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

  Future<List<Product>> allProduct() async {
    if (category?.carInformation == false) {
      List<Product> products = await FirestoreModel.use<Product>().get(
          queryBuilder: (q) => q
              .where('category', isEqualTo: category.title)
              .where('brandCar', isEqualTo: '')
              .where('modelCar', isEqualTo: ''));
      return products;
    }

    if (category?.carInformation == true) {
      List<Product> products1 = await FirestoreModel.use<Product>().get(
          queryBuilder: (q) => q
              .where('category', isEqualTo: category.title)
              .where('brandCar', isEqualTo: '')
              .where('modelCar', isEqualTo: ''));
      List<Product> products2 = await FirestoreModel.use<Product>().get(
          queryBuilder: (q) => q
              .where('brandCar', isEqualTo: _appState.brandSelect)
              .where('modelCar', isEqualTo: _appState.modelSelect));
      products1.addAll(products2);
      if (_appState.modelSelect == '') {
        List<Product> products3 = await FirestoreModel.use<Product>().get(
            queryBuilder: (q) => q
                .where('category', isEqualTo: category.title)
                .where('brandCar', isEqualTo: _appState.brandSelect)
                .where('modelCar', isEqualTo: ''));
        products1.addAll(products3);
      }

      //اضافة ان لو المنتج موجود ميفهوش في تاني

      return products1;
    }
  }
}
