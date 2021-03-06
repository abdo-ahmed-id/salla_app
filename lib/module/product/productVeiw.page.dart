import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/product.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';
import 'package:salla_app/module/widget/app_widgets.dart';

class ProductViewPage extends StatelessWidget {
  Product product;

  ProductViewPage({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: ModelStreamSingleBuilder<Product>(
                  docId: product.docId,
                  onLoading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  onSuccess: (product) {
                    return PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: product.images.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            product.images[index] ?? AssetsHelper.networkImage,
                            height: 200,
                            width: 300,
                          );
                        });
                  }),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 800.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.h),
                      ListTile(
                        title: Text(
                          product.title,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        leading: Container(
                          height: 200.h,
                          width: 70.w,
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
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                ' ${product.price} ???????? ',
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
                                  ' ${(int.parse(product.price) - product.discountP * (int.parse(product.price) / 100))} ???????? ',
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.subTitle,
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: AppTheme.primaryColor),
                            ),
                            CustomRaringWidget(
                              product: product,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                ' ???????????? ?????????? ???? ?????????? ',
                                style: GoogleFonts.cairo(
                                    height: 2.0.h,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Image.asset(
                              AssetsHelper.mobilImage,
                              height: 80.h,
                              width: 80.w,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '???????????? ????????????',
                          style: GoogleFonts.cairo(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          product.description,
                          style: GoogleFonts.cairo(
                              height: 2.0.h,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      ModelStreamSingleBuilder<Product>(
                          docId: product.docId,
                          onLoading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          onSuccess: (product) {
                            return BlocBuilder<AppBloc, AppState>(
                                bloc: Modular.get<AppBloc>(),
                                builder: (context, state) {
                                  return Container(
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GradientButton(
                                          text: product.shoppingCartList
                                                  .contains(state.user?.docId)
                                              ? '?????????? ???? ??????????'
                                              : '?????????? ?????? ??????????',
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Modular.get<AppBloc>()
                                                .addShoppingCart(
                                                    product: product,
                                                    userModel: state.user);
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
                                              color: product.favList.contains(
                                                      state.user?.docId)
                                                  ? AppTheme.primaryColor
                                                  : Colors.black,
                                            ),
                                            onPressed: () {
                                              Modular.get<AppBloc>().addFav(
                                                  product: product,
                                                  userModel: state.user);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }),
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
          ],
        ),
      ),
    );
  }
}
