import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salla_app/data/models/category.dart';
import 'package:salla_app/data/models/favoriets.dart';
import 'package:salla_app/data/models/product.dart';
import 'package:salla_app/data/models/promocode.dart';
import 'package:salla_app/data/models/shopping_cart.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/module/app/app.module.dart';
import 'package:salla_app/module/app/app.widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  FirestoreModel.injectAll([
    UserModel(),
    Category(),
    Product(),
    Favoriets(),
    ShoppingCart(),
    PromoCode(),
  ]);

  await Firebase.initializeApp();
  runApp(EasyLocalization(
      supportedLocales: [Locale('ar')],
      path: 'assets/translations', // <-- change patch to your
      useOnlyLangCode: true,
      fallbackLocale: Locale('ar'),
      startLocale: Locale('ar'),
      child: ModularApp(module: AppModule(), child: AppWidget())));
}
