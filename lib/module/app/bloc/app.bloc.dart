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

  void createAccount({context, UserModel userModel}) async {
    User user =
        await _authService.register(userModel.email, userModel.password);
    if (user != null) {
      userModel.docId = user.uid;
      await userModel.create(docId: user.uid);
      Modular.to.pushNamed(AppRoutes.mainHome);
      clearState();
      // await _authService.logout();
      // Notifications.dialog(
      //   context,
      //   dismissible: false,
      //   child: Dialog(
      //     child: Container(
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           const ListTile(
      //             leading: Icon(
      //               Icons.info_outline,
      //               color: Colors.white,
      //             ),
      //             title: Text(
      //               '?????? ???????????? ???? ???????????? ????????????????????',
      //               style: TextStyle(color: Colors.black),
      //             ),
      //           ),
      //           CustomTextButton(
      //             color: AppTheme.primaryColor,
      //             text: '?????????? ????????????',
      //             onPressed: () {
      //               Modular.to.pushReplacementNamed(AppRoutes.login);
      //             },
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // );
      // print('loading verify email');
    } else {
      print('user not found');
    }
  }

  void signIn(context, String email, String password) async {
    User user = await _authService.signIn(email, password);
    if (user != null) {
      await getUserData();
      Notifications.success('???? ?????????? ???????????? ??????????');
      Modular.to.pushReplacementNamed(AppRoutes.mainHome);
    }
    // print('provider: ${user.providerData.single.providerId}');}
    // if (user.emailVerified == true) {
    //   print(user.emailVerified);
    //   print('finish verify email');
    //   Notifications.success('???? ?????????? ???????????? ??????????');
    //   Modular.to.pushReplacementNamed(AppRoutes.mainHome);
    // }
    else {
      /*await _authService.logout();
        print(user.emailVerified);
        Notifications.dialog(
          context,
          dismissible: true,
          child: Dialog(
            child: Container(
              // height: 120,
              child: const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text(
                  'You must verify your email',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        );*/
      print('loading verify email');
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

  void shoppingCartList(Product product) async {
    bool shoppingCartList = product.shoppingCartList.contains(state.user.docId);
    if (shoppingCartList) {
      await product
          .arrayRemove(field: 'shoppingCartList', elements: [state.user.docId]);
    } else if (shoppingCartList == false) {
      await product
          .arrayUnion(field: 'shoppingCartList', elements: [state.user.docId]);
    }
  }

  void addFav({UserModel userModel, dynamic product}) async {
    emit(state.copyWith(isWrite: true));
    fav(product);
    bool isFav =
        await userModel.subCollection<Favoriets>().exists(product.docId);
    print(isFav);
    if (isFav) {
      await userModel.subCollection<Favoriets>().delete(docId: product.docId);
      Notifications.success('???? ?????? ???????????? ???? ??????????????');
      emit(state.copyWith(isWrite: false));
    } else {
      Favoriets favoriets = userModel.subCollection<Favoriets>();
      favoriets.title = product.title;
      favoriets.rate = product.rate;
      favoriets.price = product.price;
      favoriets.category = product.category;
      favoriets.description = product.description;
      favoriets.images = product.images;
      favoriets.company = product.company;
      favoriets.subTitle = product.subTitle;
      favoriets.discountP = product.discountP;
      favoriets.create(docId: product.docId);

      emit(state.copyWith(isFav: !state.isFav, isWrite: false));
      Notifications.success('???? ?????????? ???????????? ?????? ??????????????');
    }
  }

  void addShoppingCart({UserModel userModel, Product product}) async {
    shoppingCartList(product);
    bool isCart =
        await userModel.subCollection<ShoppingCart>().exists(product.docId);

    print(isCart);
    if (isCart) {
      await userModel
          .subCollection<ShoppingCart>()
          .delete(docId: product.docId);
      Notifications.success('???? ?????? ???????????? ???? ???????? ????????????');
      emit(state.copyWith(isWrite: false));
    } else {
      ShoppingCart shoppingCart = userModel.subCollection<ShoppingCart>();
      shoppingCart.title = product.title;
      shoppingCart.rate = product.rate;
      shoppingCart.price = product.price;
      shoppingCart.category = product.category;
      shoppingCart.description = product.description;
      shoppingCart.images = product.images;
      shoppingCart.company = product.company;
      shoppingCart.subTitle = product.subTitle;
      shoppingCart.discountP = product.discountP;
      shoppingCart.create(docId: product.docId);
      Notifications.success('???? ?????????? ???????????? ?????? ???????? ????????????');
      emit(state.copyWith(isWrite: false));
    }
  }

  void clearState() {
    emit(state.copyWith(modelSelect: '', brandSelect: ''));
  }
}
