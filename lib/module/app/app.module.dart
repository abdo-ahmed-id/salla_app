import 'package:flutter_modular/flutter_modular.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/module/Thank/thank.page.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/app/service/auth.service.dart';
import 'package:salla_app/module/category/category.page.dart';
import 'package:salla_app/module/confirm_product/confirmProduct.page.dart';
import 'package:salla_app/module/delivery/delivery.page.dart';
import 'package:salla_app/module/home/mainHome.page.dart';
import 'package:salla_app/module/login/forget_password.page.dart';
import 'package:salla_app/module/login/login.page.dart';
import 'package:salla_app/module/product/productVeiw.page.dart';
import 'package:salla_app/module/search/search.page.dart';
import 'package:salla_app/module/signUp/signUp.page.dart';
import 'package:salla_app/module/splash/splash.page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AuthService()),
    Bind((i) => AppBloc(i.get<AuthService>())),
  ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.splash, child: (_, __) => SplashPage()),
    ChildRoute(AppRoutes.signUp, child: (_, __) => SignUpPage()),
    ChildRoute(AppRoutes.login, child: (_, __) => LoginPage()),
    ChildRoute(AppRoutes.mainHome, child: (_, __) => MainHomePage()),
    ChildRoute(AppRoutes.category,
        child: (_, args) => CategoryPage(
              category: args.data,
            )),
    ChildRoute(AppRoutes.product,
        child: (_, args) => ProductViewPage(
              product: args.data,
            )),
    ChildRoute(AppRoutes.delivery, child: (_, __) => DeliveryPage()),
    ChildRoute(AppRoutes.search, child: (_, __) => SearchPage()),
    ChildRoute(AppRoutes.confirm, child: (_, __) => ConfirmProductPage()),
    ChildRoute(AppRoutes.thank, child: (_, __) => ThankPage()),
    ChildRoute(AppRoutes.forgetPassword,
        child: (_, __) => ForgetPasswordPage()),
  ];
}
