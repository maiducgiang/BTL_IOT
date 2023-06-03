import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({required bool isLoading, String? error}) =
      _MainState;

  factory MainState.initial({
    String? id,
  }) =>
      const MainState(
        isLoading: false,
      );
}
