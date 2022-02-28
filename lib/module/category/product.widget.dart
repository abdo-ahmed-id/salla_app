import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/product.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';
import 'package:salla_app/module/app/service/auth.service.dart';
import 'package:salla_app/widget.dart';

import '../app/bloc/app.bloc.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key key, this.product, this.state, this.appBloc})
      : super(key: key);
  final Product product;
  final AppBloc appBloc;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          InkWell(
            onTap: () {
              Modular.to.pushNamed(AppRoutes.product, arguments: product);
            },
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
                          fontWeight: FontWeight.bold, fontSize: 22.sp),
                    ),
                    leading: Container(
                      height: 200,
                      width: 70,
                      child: Flexible(
                        child: Text(
                          product.company ?? 'Ac delco',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: Colors.blue),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            ' ${product.price} جنيه ',
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: (product.discountP ?? 0) > 0
                                    ? Colors.grey
                                    : AppTheme.primaryColor),
                          ),
                        ),
                        if ((product.discountP ?? 0) > 0)
                          Expanded(
                            flex: 1,
                            child: Text(
                              ' ${(int.parse(product.price) - product.discountP * (int.parse(product.price) / 100))} جنيه ',
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: AppTheme.primaryColor),
                            ),
                          ),
                      ],
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            product.subTitle,
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: AppTheme.primaryColor),
                          ),
                        ),
                        RatingBar.builder(
                          itemSize: 20.sp,
                          initialRating: product?.rate.toDouble() ?? 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
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
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    product.images != null
                        ? Image.network(
                            product.images[0] ?? AssetsHelper.networkImage,
                            height: 100.h,
                            width: 100.w,
                          )
                        : Image.network(
                            AssetsHelper.networkImage,
                            height: 90.h,
                            width: 90.w,
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
                      height: 80.h,
                      width: 80.w,
                    ),
                  ],
                ),
                ModelStreamSingleBuilder<Product>(
                    docId: product.docId,
                    onLoading: () =>
                        Center(child: const CircularProgressIndicator()),
                    onSuccess: (product) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientButton(
                            text: product.shoppingCartList
                                    .contains(state.user?.docId)
                                ? 'ازالة من السلة'
                                : 'اضافة الي السلة',
                            textColor: Colors.black,
                            onPressed: () {
                              AuthService.isLogin
                                  ? appBloc.addShoppingCart(
                                      userModel: state.user, product: product)
                                  : Modular.to.pushNamed(AppRoutes.login);
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
                                color:
                                    product.favList.contains(state.user?.docId)
                                        ? AppTheme.primaryColor
                                        : Colors.black,
                              ),
                              onPressed: state.isWrite == false
                                  ? () {
                                      if (AuthService.isLogin) {
                                        appBloc.addFav(
                                            product: product,
                                            userModel: state.user);
                                        print('login');
                                      } else {
                                        loginButtomSheete(context: context);
                                        print('no login');
                                      }
                                    }
                                  : () {},
                            ),
                          )
                        ],
                      );
                    }),
                const Divider(
                  thickness: 3,
                ),
              ],
            ),
          ),
          if ((product.discountP ?? 0) > 0)
            Container(
              height: 40,
              width: 80,
              color: Colors.red[800],
              child: Center(
                  child: Text(
                '% ${product.discountP.toString()}',
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              )),
            ),
        ],
      ),
    );
  }
}
