// lib/views/shopping_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart_app/core/utils/dialog_utils.dart';
import 'package:shopping_cart_app/presentation/viewmodel/shopping_viewmodel.dart';
import 'package:shopping_cart_app/presentation/widgets/list_item.dart';

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ConsumerState<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends ConsumerState<ShoppingListScreen> {
  final TextEditingController _addItemController = TextEditingController();
  final Map<String, TextEditingController> _editControllers = {};

  @override
  void dispose() {
    _addItemController.dispose();
    for (var controller in _editControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleAddItem() {
    showAddItemDialog(
      context: context,
      ref: ref,
      controller: _addItemController,
      onAdd: (itemName) async {
        await ref.read(shoppingViewModelProvider.notifier).addItem(itemName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(shoppingViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Compras')),
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data:
            (items) => ListView.separated(
              padding: const EdgeInsets.only(top: 32),
              itemCount: items.length,
              separatorBuilder:
                  (context, index) => const Divider(
                    height: 5,
                    thickness: 1,
                    color: Colors.white24,
                  ),
              itemBuilder: (context, index) {
                final item = items[index];
                _editControllers[item.id] ??= TextEditingController(
                  text: item.name,
                );

                return ListItem(
                  item: item,
                  onToggle:
                      (isPurchased) => ref
                          .read(shoppingViewModelProvider.notifier)
                          .togglePurchasedStatus(item),
                  onEdit:
                      (newName) => ref
                          .read(shoppingViewModelProvider.notifier)
                          .updateItemName(item, newName),
                  onDelete:
                      () => ref
                          .read(shoppingViewModelProvider.notifier)
                          .deleteItem(item.id),
                );
              },
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
