import 'package:equatable/equatable.dart';
import 'package:salla_app/data/models/users.dart';

class AppState extends Equatable {
  final int currentIndex;
  final UserModel user;
  final bool isFav;
  AppState({this.currentIndex = 0, this.isFav = false, this.user});

  AppState copyWith({int currentIndex, bool isFav, UserModel user}) => AppState(
        currentIndex: currentIndex ?? this.currentIndex,
        isFav: isFav ?? this.isFav,
        user: user ?? this.user,
      );

  @override
  List<Object> get props => [
        currentIndex,
        isFav,
        user,
      ];
}
