import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleController extends StateNotifier<bool> {
  ToggleController() : super(false);

  void toggleShowAll() {
    state = !state;
  }
}

final castControllerProvider = StateNotifierProvider<ToggleController, bool>(
  (_) => ToggleController(),
);

final crewControllerProvider = StateNotifierProvider<ToggleController, bool>(
  (_) => ToggleController(),
);
