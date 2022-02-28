import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/order.dart';
import 'package:salla_app/data/models/product.dart';
import 'package:salla_app/data/models/promocode.dart';
import 'package:salla_app/data/models/shopping_cart.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/helper/notifications.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';

class ConfirmProductPage extends StatelessWidget {
  List<ShoppingCart> products;
  UserModel user;
  String notes;
  String code;

  num orderCoast({PromoCode promoCode}) {
    num orderCoast = products
        .map((e) => int.parse(e.price) * e.amount)
        .reduce((a, b) => a + b);
    num discountP = orderCoast * (promoCode.discountP / 100);
    print('price $orderCoast}');
    num newCoast = orderCoast - discountP;
    return newCoast;
  }

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ModelStreamGetBuilder<PromoCode>(onSuccess: (promoCods) {
            return Column(
              children: [
                PrimaryTextField(
                  hintText: 'اضف بعض الملاحظات',
                  onChanged: (value) {
                    notes = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                PrimaryTextField(
                  hintText: 'ادخل كوبون الخصم',
                  onChanged: (value) {
                    code = value;
                  },
                ),
                // Text(
                //   'معلوماتك',
                //   style: GoogleFonts.cairo(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 18.sp,
                //   ),
                // ),
                // const PersonalInformation(),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: [
                              Column(
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
                                            initialRating:
                                                product.rate.toDouble(),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
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
                                            color: (product.discountP ?? 0) > 0
                                                ? Colors.grey
                                                : AppTheme.primaryColor),
                                      ),
                                    ],
                                  ),
                                  if ((product.discountP ?? 0) > 0)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'المبلغ الاجمالي بعد الخصم',
                                          style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Text(
                                          coastAfterDiscount(product) ?? 0,
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
                  // '${products.map((e) => int.parse(e.price) * e.amount).reduce((a, b) => a + b)}',
                  textColor: Colors.black,
                  onPressed: () async {
                    List<String> cods = [];
                    promoCods.forEach((e) => cods.add(e.code));
                    print(cods.toString());
                    bool trueCode = cods.contains(code);
                    print(trueCode);
                    if (code != null && code != '' && trueCode == true) {
                      PromoCode promoCode =
                          await FirestoreModel.use<PromoCode>().first(
                              queryBuilder: (q) =>
                                  q.where('code', isEqualTo: code));
                      if (promoCode.code == code) {
                        Notifications.success(
                            'لقد استخدمت برومو كود ${promoCode.title} سوف يتم خصم ${promoCode.discountP} %',
                            time: 4);
                      }
                      print(promoCode.toMap);

                      Order order = Order(
                        user: user,
                        products: products,
                        notes: notes,
                        promoCode:
                            promoCode.code == code ? promoCode : PromoCode(),
                        orderCoast: promoCode.code == code
                            ? orderCoast(promoCode: promoCode)
                            : null,
                      );
                      await order.create();
                      products.forEach((element) async {
                        AppState state = Modular.get<AppBloc>().state;
                        Product product2 = await FirestoreModel.use<Product>()
                            .find(element.docId);
                        await product2.arrayRemove(
                            field: 'shoppingCartList',
                            elements: [state.user?.docId]);
                        element.delete();
                      });
                      Modular.to.pushNamed(AppRoutes.thank);
                      appBloc.changeIndexTo(0);
                    } else {
                      Order order = Order(
                        user: user,
                        products: products,
                        notes: notes,
                      );
                      await order.create();
                      products.forEach((element) async {
                        AppState state = Modular.get<AppBloc>().state;
                        Product product2 = await FirestoreModel.use<Product>()
                            .find(element.docId);
                        await product2.arrayRemove(
                            field: 'shoppingCartList',
                            elements: [state.user?.docId]);
                        element.delete();
                      });
                      Modular.to.pushNamed(AppRoutes.thank);
                      appBloc.changeIndexTo(0);
                      //
                    }
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  String coastAfterDiscount(ShoppingCart product) {
    num totalCoast = int.parse(product.price) * product.amount;
    num discountP = totalCoast * (product.discountP / 100);
    String newPrice = ' ${totalCoast - discountP} جنية';
    return newPrice;
  }
}
