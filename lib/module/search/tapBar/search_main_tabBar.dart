import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/module/search/tapBar/pages/search_product.page.dart';
import 'package:salla_app/module/search/tapBar/pages/search_type.page.dart';

class SearchTabBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'البحث',
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          elevation: 0.0,
          backgroundColor: AppTheme.primaryColor,
          // toolbarHeight: 0.h,
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                text: 'المنتج',
              ),
              Tab(
                text: 'النوع',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchProduct(),
            SearchType(),
          ],
        ),
      ),
    );
  }
}
