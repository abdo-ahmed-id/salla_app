import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final int currentIndex;
  AppState({this.currentIndex = 0});

  AppState copyWith({int currentIndex}) => AppState(
        currentIndex: currentIndex ?? this.currentIndex,
      );

  @override
  List<Object> get props => [currentIndex];
}
