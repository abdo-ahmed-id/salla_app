import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';

import '../../data/models/product.dart';

class ProductViewPage extends StatelessWidget {
  final Product product;
  const ProductViewPage({this.product});

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
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      AssetsHelper.bataryImage,
                      height: 200,
                      width: 300,
                    );
                  }),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 500.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      product.title,
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    leading: Text(
                      'Ac delco',
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '950 امبير',
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: AppTheme.primaryColor),
                        ),
                        RatingBar.builder(
                          itemSize: 20.sp,
                          initialRating: product.rate.toDouble(),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            ' متوافر لدينا في محطات ',
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
                      'تفاصيل المنتج',
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
                  Container(
                    height: 70,
                    color: Colors.grey[400],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientButton(
                          text: 'اضافة الي السلة',
                          textColor: Colors.black,
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Card(
                          color: Colors.grey[200],
                          child: IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
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
