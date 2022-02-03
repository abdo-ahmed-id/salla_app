import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';
import 'package:salla_app/module/app/service/auth.service.dart';

class AppBloc extends Cubit<AppState> {
  final AuthService _authService;
  AppBloc(this._authService) : super(AppState());
  void onChanged(int index) {
    emit(state.copyWith(
      currentIndex: index,
    ));
  }

  void createAccount(String email, String password) async {
    User user = await _authService.register(email, password);
    if (user != null) {
      Modular.to.pushReplacementNamed(AppRoutes.mainHome);
    }
    print('user not found');
  }

  void signIn(String email, String password) async {
    User user = await _authService.signIn(email, password);
    if (user != null) {
      Modular.to.pushReplacementNamed(AppRoutes.mainHome);
    }
    print('user not found');
  }
}
