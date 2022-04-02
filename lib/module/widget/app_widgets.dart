import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_app/data/models/product.dart';
import 'package:share/share.dart';

import '../app/service/auth.service.dart';

class CustomRaringWidget extends StatelessWidget {
  Product product;
  bool isShow;

  CustomRaringWidget({this.product, this.isShow = true});

  @override
  Widget build(BuildContext context) {
    List<num> rates = [];
    int sum;
    num newRate;

    return RatingBar.builder(
      itemSize: 20,
      initialRating: product?.rate?.toInt()?.toDouble() ?? 5,
      minRating: 1,
      direction: Axis.horizontal,
      // allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
        size: 10.sp,
      ),

      onRatingUpdate: isShow == false
          ? (rating) {}
          : (rating) async {
              print(rating);
              rates = [];
              await product.arrayUnion(
                  field: 'rates',
                  elements: ['${rating}${DateTime.now().microsecond}']);
              num toDouble;
              product.rates.forEach((element) {
                toDouble = double.parse(element);
                rates.add(toDouble.toInt());
              });
              sum = rates?.reduce((a, b) => a + b);
              newRate = sum / (rates.length);
              product.rate = newRate;
              // await product.update(data: {'rate': newRate});
              await product.save();
              print('newRate $newRate');
              print('sum $sum');
              print('rates ${rates.toList()}');

              // print(product.rates);
            },
    );
  }
}

class ShareButton extends StatelessWidget {
  final Product product;
  const ShareButton({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          String url = await Modular.get<AuthService>().createDynamicLink(
              description: product.description,
              imageUrl: product.images[0],
              id: product.docId);

          await Share.share(url);
        },
        icon: Icon(Icons.share));
  }
}
