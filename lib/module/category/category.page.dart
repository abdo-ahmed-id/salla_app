import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/category.dart';
import 'package:salla_app/data/models/product.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';
import 'package:salla_app/module/app/service/auth.service.dart';
import 'package:salla_app/widget.dart';

import '../app/bloc/app.bloc.dart';

class CategoryPage extends StatelessWidget {
  final Category category;
  final AppBloc _appBloc = Modular.get<AppBloc>();

  CategoryPage({this.category});
  @override
  Widget build(BuildContext context) {
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
          query: (q) => q.where('category', isEqualTo: category.title),
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
                          Modular.to
                              .pushNamed(AppRoutes.product, arguments: product);
                        },
                        child: Padding(
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
                                    'Ac delco',
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                        color: Colors.blue),
                                  ),
                                  trailing: Text(
                                    ' ${product.price}جنيه ',
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
                                        '950 امبير',
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                            color: AppTheme.primaryColor),
                                      ),
                                      RatingBar.builder(
                                        itemSize: 20,
                                        initialRating: product.rate.toDouble(),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GradientButton(
                                    text: 'اضافة الي السلة',
                                    textColor: Colors.black,
                                    onPressed: () {
                                      _appBloc.logOut();
                                      // ShoppingCart shCart =
                                      //     ShoppingCart(product: snapshot.data[index]);
                                      // shCart.create();
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
                                            ? Colors.deepOrange
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        if (AuthService.isLogin) {
                                          _appBloc.addFav(
                                              product: product,
                                              userModel: state.user);
                                          print('login');
                                        } else {
                                          loginButtomSheete(context: context);
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
                        ),
                      );
                    },
                  );
                });
          }),
    );
  }
}
