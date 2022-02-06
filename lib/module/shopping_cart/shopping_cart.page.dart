import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/shopping_cart.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';
import 'package:salla_app/module/app/service/auth.service.dart';

class ShoppingCartPage extends StatelessWidget {
  AppBloc appBloc = Modular.get<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(
          bloc: appBloc,
          builder: (context, state) {
            if (!AuthService.isLogin) {
              Center(child: Text('no product'));
            } else {
              return ModelStreamGetBuilder<ShoppingCart>(
                  parentModel: state?.user,
                  onError: (e) => Text(e),
                  onEmpty: () => Center(child: Text('لا توجد منتجات حتي الان')),
                  onSuccess: (products) {
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        ShoppingCart product = products[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16.h,
                              ),
                              Center(
                                child: ListTile(
                                  title: Text(
                                    product.title,
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  leading: Text(
                                    product?.company,
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                        color: Colors.blue),
                                  ),
                                  trailing: Text(
                                    '${product.price} جنية',
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                        color: AppTheme.primaryColor),
                                  ),
                                  subtitle: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.subTitle,
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                            color: AppTheme.primaryColor),
                                      ),
                                      RatingBar.builder(
                                        itemSize: 20,
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 10.sp,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    AssetsHelper.bataryImage,
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Flexible(
                                    child: Text(
                                      ' متوافر لدينا في محطات',
                                      style: GoogleFonts.cairo(
                                          height: 2.0.h,
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Image.asset(
                                    AssetsHelper.mobilImage,
                                    height: 80,
                                    width: 80,
                                  ),
                                ],
                              ),
                              ListTile(
                                leading: Text(
                                  'الكمية',
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                      color: AppTheme.primaryColor),
                                ),
                                title: Center(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (product.amount > 1) {
                                            product.decrement(field: 'amount');
                                          }
                                        },
                                        icon: Icon(Icons.remove),
                                      ),
                                      Text(
                                        product.amount.toString(),
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                            color: AppTheme.primaryColor),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          product.increment(field: 'amount');
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'المبلغ الاجمالي',
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                        color: AppTheme.primaryColor),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    '${int.parse(product.price) * product.amount} جنية',
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                        color: AppTheme.primaryColor),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GradientButton(
                                    text: 'متابعة',
                                    textColor: Colors.black,
                                    onPressed: () {
                                      Modular.to.pushNamed(AppRoutes.confirm,
                                          arguments: product);
                                    },
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Card(
                                    color: Colors.grey[200],
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: state.isFav
                                            ? AppTheme.primaryColor
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        if (AuthService.isLogin) {
                                          appBloc.addFav(
                                              product: product,
                                              userModel: state.user);
                                          print('login');
                                        } else {
                                          print('no login');
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const Divider(
                                thickness: 3,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  });
            }
            return Center(
                child: Text(
              'لم تقم باضافة منتجات حتي الان',
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold, fontSize: 18.sp),
            ));
          }),
    );
  }
}
