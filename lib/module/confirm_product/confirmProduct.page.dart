import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/order.dart';
import 'package:salla_app/data/models/shopping_cart.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/confirm_product/confirm.product_widget.dart';

class ConfirmProductPage extends StatelessWidget {
  List<ShoppingCart> products;
  UserModel user;

  ConfirmProductPage({this.products, this.user});
  AppBloc appBloc = Modular.get<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          'تاكيد المنتج',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'معلوماتك',
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            const PersonalInformation(),
            const Divider(
              thickness: 3,
            ),
            Text(
              'معلومات المنتج',
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            Container(
              height: 300.h,
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  ShoppingCart product = products[index];
                  return InkWell(
                    onTap: () {
                      Modular.to.pushNamed(
                        AppRoutes.product,
                      );
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
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              leading: Text(
                                product.company,
                                style: GoogleFonts.lato(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  'متوافر لدينا في محطات',
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
                              ),
                            ),
                            title: Text(
                              product.amount.toString(),
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: AppTheme.primaryColor),
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
                                ),
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
                              SizedBox(
                                width: 6.w,
                              ),
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
              ),
            ),
            Text(
              'الدفع عند الاستلام',
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                color: Colors.deepOrange,
              ),
            ),
            CustomButton(
              backgroundColor: AppTheme.primaryColor,
              text: 'شراء',
              textColor: Colors.black,
              onPressed: () async {
                Order order = Order(
                  user: user,
                  products: products,
                );
                await order.create();
                Modular.to.pushNamed(AppRoutes.thank);
                // product.delete(docId: product.docId);
                appBloc.changeIndexTo(0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
