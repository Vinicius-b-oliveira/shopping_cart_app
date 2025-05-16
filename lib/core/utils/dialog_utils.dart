// lib/core/utils/dialog_utils.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showAddItemDialog({
  required BuildContext context,
  required WidgetRef ref,
  required TextEditingController controller,
  required Function(String) onAdd,
}) async {
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text('Add New Item'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter item name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.trim().isNotEmpty) {
                  await onAdd(controller.text.trim());
                  controller.clear();
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
  );
}
