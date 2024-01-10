import 'package:flutter_riverpod/flutter_riverpod.dart';

class CastController extends StateNotifier<bool> {
  CastController() : super(false);

  void toggleShowAll() {
    state = !state;
  }
}

final castControllerProvider = StateNotifierProvider<CastController, bool>(
  (_) => CastController(),
);

class CrewController extends StateNotifier<bool> {
  CrewController() : super(false);

  void toggleShowAll() {
    state = !state;
  }
}

final crewControllerProvider = StateNotifierProvider<CrewController, bool>(
  (_) => CrewController(),
);
