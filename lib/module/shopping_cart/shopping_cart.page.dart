import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';

class ShoppingCartPage extends StatelessWidget {
  AppBloc appBloc = Modular.get<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(
          bloc: appBloc,
          builder: (context, state) {
            return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
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
                              'بطارية',
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
                              '950 جنية',
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
                                  '950 امبير',
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
                                  onPressed: () {},
                                  icon: Icon(Icons.remove),
                                ),
                                Text(
                                  '1',
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                      color: AppTheme.primaryColor),
                                ),
                                IconButton(
                                  onPressed: () {},
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
                              '300 جنية',
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
                                Modular.to.pushNamed(AppRoutes.delivery);
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
                                      state.isFav ? Colors.blue : Colors.black,
                                ),
                                onPressed: () {
                                  appBloc.addFav();
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
          }),
    );
  }
}
