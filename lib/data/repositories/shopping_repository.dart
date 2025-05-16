import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/shopping_item.dart';

part 'shopping_repository.g.dart';

class ShoppingRepository {
  final SupabaseClient _client = Supabase.instance.client;
  final String _tableName = 'shopping_items';

  Future<List<ShoppingItem>> getItems() async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .order('created_at', ascending: false);

      return response
          .map((item) => ShoppingItem.fromJson(item))
          .toList()
          .cast<ShoppingItem>();
    } catch (e) {
      throw Exception('Failed to fetch shopping items: $e');
    }
  }

  Future<ShoppingItem> addItem(String name) async {
    try {
      final response =
          await _client
              .from(_tableName)
              .insert({'name': name, 'is_purchased': false})
              .select()
              .single();

      return ShoppingItem.fromJson(response);
    } catch (e) {
      throw Exception('Failed to add shopping item: $e');
    }
  }

  Future<ShoppingItem> updateItemName(String id, String newName) async {
    try {
      final response =
          await _client
              .from(_tableName)
              .update({'name': newName})
              .eq('id', id)
              .select()
              .single();

      return ShoppingItem.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update shopping item: $e');
    }
  }

  Future<ShoppingItem> togglePurchasedStatus(
    String id,
    bool currentStatus,
  ) async {
    try {
      final response =
          await _client
              .from(_tableName)
              .update({'is_purchased': !currentStatus})
              .eq('id', id)
              .select()
              .single();

      return ShoppingItem.fromJson(response);
    } catch (e) {
      throw Exception('Failed to toggle purchased status: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _client.from(_tableName).delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete shopping item: $e');
    }
  }
}

@riverpod
ShoppingRepository shoppingRepository(Ref ref) {
  return ShoppingRepository();
}
