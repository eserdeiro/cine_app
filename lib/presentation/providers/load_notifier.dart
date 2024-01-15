import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadNotifier<T> extends StateNotifier<Map<String, T>> {
  final Future<T> Function(String) getItem;

  LoadNotifier({required this.getItem}) : super({});

  Future<void> load(String itemId) async {
    if (state[itemId] != null) return;
    final item = await getItem(itemId);
    state = {...state, itemId: item};
  }
}
