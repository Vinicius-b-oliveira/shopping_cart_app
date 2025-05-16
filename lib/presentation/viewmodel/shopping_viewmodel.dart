// lib/viewmodels/shopping_list_viewmodel.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shopping_cart_app/data/models/shopping_item.dart';
import 'package:shopping_cart_app/data/repositories/shopping_repository.dart';

part 'shopping_viewmodel.g.dart';

@riverpod
class ShoppingViewModel extends _$ShoppingViewModel {
  late final ShoppingRepository _repository = ref.read(
    shoppingRepositoryProvider,
  );

  @override
  FutureOr<List<ShoppingItem>> build() async {
    return _fetchItems();
  }

  Future<List<ShoppingItem>> _fetchItems() async {
    try {
      return await _repository.getItems();
    } catch (e) {
      throw Exception('Failed to load items: ${e.toString()}');
    }
  }

  Future<void> addItem(String name) async {
    if (name.trim().isEmpty) return;

    state = const AsyncValue.loading();
    try {
      await _repository.addItem(name.trim());
      state = await AsyncValue.guard(_fetchItems);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> togglePurchasedStatus(ShoppingItem item) async {
    final currentList = state.value ?? [];
    final updatedList =
        currentList
            .map(
              (i) =>
                  i.id == item.id ? i.copyWith(isPurchased: !i.isPurchased) : i,
            )
            .toList();

    state = AsyncValue.data(updatedList);

    await _repository.togglePurchasedStatus(item.id, item.isPurchased);
  }

  Future<void> updateItemName(ShoppingItem item, String newName) async {
    if (newName.trim().isEmpty) return;

    state = const AsyncValue.loading();
    try {
      await _repository.updateItemName(item.id, newName.trim());
      state = await AsyncValue.guard(_fetchItems);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteItem(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteItem(id);
      state = await AsyncValue.guard(_fetchItems);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
