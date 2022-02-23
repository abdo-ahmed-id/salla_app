import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/notifications.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/app/service/auth.service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthService.isLogin
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomListTile(
                      text: 'المعلومات الشخصية',
                      onTap: () {
                        AuthService.isLogin
                            ? Modular.to.pushNamed(AppRoutes.personal)
                            : Notifications.error('يجب تسجيل الدخول');
                      },
                      icon: Icons.person,
                    ),
                    CustomListTile(
                      text: 'عنوانك',
                      onTap: () {
                        Modular.to.pushNamed(AppRoutes.address);
                      },
                      icon: Icons.location_on,
                    ),
                    CustomListTile(
                      text: 'طرق الدفع',
                      onTap: () {},
                      icon: Icons.card_travel,
                    ),
                    CustomListTile(
                      text: 'تسجيل الخروج',
                      onTap: () {
                        Modular.get<AppBloc>().logOut();
                        // Modular.to.pushNamed(AppRoutes.mainHome);
                        Modular.get<AppBloc>().changeIndexTo(0);
                      },
                      icon: Icons.logout,
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'يجب تسجيل الدخول اولا',
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    GradientButton(
                      text: 'تسجيل الدخول',
                      textColor: Colors.white,
                      onPressed: () {
                        Modular.to.pushNamed(AppRoutes.login);
                      },
                    ),
                  ],
                ),
              ));
  }
}
