import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_model/firestore_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salla_app/data/models/favoriets.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/helper/app.routes.dart';
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
      // Modular.to.pushReplacementNamed(AppRoutes.mainHome);
      print('userName${user.displayName}');
      userModel.create();
      getUserData();
    } else {
      print('user not found');
    }
  }

  void signIn(String email, String password) async {
    User user = await _authService.signIn(email, password);
    if (user != null) {
      Modular.to.pushReplacementNamed(AppRoutes.mainHome);
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

  void addFav({UserModel userModel, Product product}) {
    print('user ${state.user}');
    Favoriets favoriets = userModel.subCollection<Favoriets>();
    favoriets.title = product.title;
    favoriets.rate = product.rate;
    favoriets.price = product.price;
    favoriets.category = product.category;
    favoriets.description = product.description;
    favoriets.imageScr = product.imageScr;
    favoriets.create();
    emit(state.copyWith(isFav: !state.isFav));
  }
}
