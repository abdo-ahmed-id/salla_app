import 'package:equatable/equatable.dart';
import 'package:salla_app/data/models/users.dart';

class AppState extends Equatable {
  final int currentIndex;
  final UserModel user;
  final bool isFav;
  final String categorySelect;
  final String brandSelect;
  final String modelSelect;

  AppState({
    this.currentIndex = 0,
    this.isFav = false,
    this.user,
    this.brandSelect,
    this.categorySelect,
    this.modelSelect,
  });

  AppState copyWith({
    int currentIndex,
    bool isFav,
    UserModel user,
    String categorySelect,
    String brandSelect,
    String modelSelect,
  }) =>
      AppState(
        currentIndex: currentIndex ?? this.currentIndex,
        isFav: isFav ?? this.isFav,
        user: user ?? this.user,
        categorySelect: categorySelect ?? this.categorySelect,
        brandSelect: brandSelect ?? this.brandSelect,
        modelSelect: modelSelect ?? this.modelSelect,
      );

  @override
  List<Object> get props => [
        currentIndex,
        isFav,
        user,
        categorySelect,
        brandSelect,
        modelSelect,
      ];
}
