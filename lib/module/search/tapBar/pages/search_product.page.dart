import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/product.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';

import '../../../../helper/app.routes.dart';

class SearchProduct extends StatefulWidget {
  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController _textEditingController = TextEditingController();
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    return ModelStreamGetBuilder<Product>(
        // query: (q) =>
        //     q.where('description', isGreaterThanOrEqualTo: searchValue),
        builder: (
      context,
      snapshot,
    ) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextForm(
                controller: _textEditingController,
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                  });
                },
                hintText: 'Search',
              ),
              SizedBox(
                height: 8.h,
              ),
              searchValue.length >= 1
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            String titleList = snapshot.data[index].title;
                            String descriptionList =
                                snapshot.data[index].description;
                            Product product = snapshot.data[index];
                            if (titleList.contains(searchValue) ||
                                descriptionList.contains(searchValue)) {
                              return InkWell(
                                onTap: () {
                                  Modular.to.pushNamed(AppRoutes.product,
                                      arguments: product);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      elevation: 4,
                                      // margin: EdgeInsets.all(20),
                                      color: Colors.grey[200],
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 100.h,
                                            child: Image.network(
                                                product.images[0]),
                                          ),
                                          ListTile(
                                            trailing: Text(
                                              ' ${product.price}  جنية',
                                              style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp,
                                                  color: AppTheme.primaryColor),
                                            ),
                                            title: Text(
                                              product.title,
                                              style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp,
                                                  color: AppTheme.primaryColor),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            }
                            return SizedBox();
                          }),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      );
    });
  }
}
