import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salla_app/data/models/favoriets.dart';
import 'package:salla_app/data/models/shopping_cart.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/notifications.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';
import 'package:salla_app/module/app/service/auth.service.dart';

import '../../../data/models/product.dart';

class AppBloc extends Cubit<AppState> {
  final AuthService _authService;

  AppBloc(this._authService) : super(AppState());

  void initState() {
    getUserData();
    print(state.user);
  }

  void onChanged(int index) {
    emit(state.copyWith(
      currentIndex: index,
    ));
  }

  void changeIndexTo(
    int index,
  ) {
    emit(state.copyWith(
      currentIndex: index,
    ));
  }

  Future<void> getUserData() async {
    User user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserModel userModel =
          await FirestoreModel.use<UserModel>().find(user.uid);
      //print("uid ${userModel.uId}");
      emit(state.copyWith(user: userModel));
      print("userF ${user}");
      print("userModel ${userModel}");
    }
  }

  void logOut() {
    _authService.logout();
  }

  void createAccount({UserModel userModel}) async {
    User user =
        await _authService.register(userModel.email, userModel.password);
    if (user != null) {
      Modular.to.pushReplacementNamed(AppRoutes.mainHome);
      print('userName${user.displayName}');
      await userModel.create(docId: user.uid);
      Notifications.success('تم انشاء حسابك بنجاح شكرا لك');
      getUserData();
    } else {
      print('user not found');
    }
  }

  void signIn(String email, String password) async {
    User user = await _authService.signIn(email, password);
    if (user != null) {
      Modular.to.pushReplacementNamed(AppRoutes.mainHome);
      Notifications.success('تم تسجيل الدخول بنجاح');
      getUserData();
    } else {
      print('user not found');
    }
  }

  void selectItem({
    String categorySelect,
    String brandSelect,
    String modelSelect,
  }) {
    emit(state.copyWith(
        categorySelect: categorySelect,
        brandSelect: brandSelect,
        modelSelect: modelSelect));
  }

  void fav(Product product) async {
    bool fav = product.favList.contains(state.user.docId);
    if (fav) {
      await product.arrayRemove(field: 'favList', elements: [state.user.docId]);
    } else if (fav == false) {
      await product.arrayUnion(field: 'favList', elements: [state.user.docId]);
    }
  }

  void addFav({UserModel userModel, product}) async {
    fav(product);
    bool isFav =
        await userModel.subCollection<Favoriets>().exists(product.docId);
    print(isFav);
    if (isFav) {
      await userModel.subCollection<Favoriets>().delete(docId: product.docId);
      Notifications.success('تم حذف المنتج من المفضلة');
    } else {
      Favoriets favoriets = userModel.subCollection<Favoriets>();
      favoriets.title = product.title;
      favoriets.rate = product.rate;
      favoriets.price = product.price;
      favoriets.category = product.category;
      favoriets.description = product.description;
      favoriets.imageScr = product.imageScr;
      favoriets.create(docId: product.docId);
      emit(state.copyWith(isFav: !state.isFav));
      Notifications.success('تم اضافة المنتج الي المفضلة');
    }
  }

  void addShoppingCart({UserModel userModel, Product product}) async {
    bool isCart =
        await userModel.subCollection<ShoppingCart>().exists(product.docId);
    Notifications.success('تم حذف المنتج من عربة التسوق');

    print(isCart);
    if (isCart) {
      await userModel
          .subCollection<ShoppingCart>()
          .delete(docId: product.docId);
    } else {
      ShoppingCart shoppingCart = userModel.subCollection<ShoppingCart>();
      shoppingCart.title = product.title;
      shoppingCart.rate = product.rate;
      shoppingCart.price = product.price;
      shoppingCart.category = product.category;
      shoppingCart.description = product.description;
      shoppingCart.imageScr = product.imageScr;
      shoppingCart.create(docId: product.docId);
      Notifications.success('تم اضافة المنتج الي عربة التسوق');
    }
  }
}
