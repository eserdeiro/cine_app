import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleController extends StateNotifier<bool> {
  ToggleController() : super(false);

  void toggleShowAll() {
    state = !state;
  }

    void setToFalse() {
    state = false;
  }
}

final castControllerProvider = StateNotifierProvider.autoDispose<ToggleController, bool>(
  (_) => ToggleController(),
);

final crewControllerProvider = StateNotifierProvider.autoDispose<ToggleController, bool>(
  (_) => ToggleController(),
);
