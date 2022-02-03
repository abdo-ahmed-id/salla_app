import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';
import 'package:salla_app/module/favorite/favorite.page.dart';
import 'package:salla_app/module/home/home.page.dart';
import 'package:salla_app/module/profile/profile.page.dart';
import 'package:salla_app/module/shopping_cart/shopping_cart.page.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
        bloc: Modular.get<AppBloc>(),
        builder: (_, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'الرئيسية',
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold, fontSize: 22),
              ),
              backgroundColor: AppTheme.primaryColor,
              actions: [
                IconButton(
                    onPressed: () {
                      Modular.to.pushNamed(AppRoutes.search);
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            body: IndexedStack(
              index: state.currentIndex,
              children: [
                HomePage(),
                ShoppingCartPage(),
                FavoritePage(),
                ProfilePage(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              items: _listItems(state),
              onTap: (int index) {
                Modular.get<AppBloc>().onChanged(index);
              },
            ),
          );
        });
  }

  List<BottomNavigationBarItem> _listItems(state) => [
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: AppTheme.primaryColor,
              size: 40.sp,
            ),
            icon: Icon(Icons.home),
            label: 'الرئيسية',
            backgroundColor: AppTheme.backgroundColor),
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.shopping_cart,
              color: AppTheme.primaryColor,
              size: 40.sp,
            ),
            icon: const Icon(Icons.shopping_cart),
            label: 'السلة',
            backgroundColor: AppTheme.backgroundColor),
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.favorite,
              color: AppTheme.primaryColor,
              size: 40.sp,
            ),
            icon: Icon(Icons.favorite),
            label: 'المفضلة',
            backgroundColor: AppTheme.backgroundColor),
        BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person_outline_rounded,
              color: AppTheme.primaryColor,
              size: 40.sp,
            ),
            icon: Icon(Icons.person_outline_rounded),
            label: 'حسابك',
            backgroundColor: AppTheme.backgroundColor),
      ];
}
