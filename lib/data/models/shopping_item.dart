import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopping_cart_app/core/utils/datetime_converter';

part 'shopping_item.freezed.dart';
part 'shopping_item.g.dart';

@freezed
abstract class ShoppingItem with _$ShoppingItem {
  const ShoppingItem._();

  const factory ShoppingItem({
    required String id,
    required String name,
    @JsonKey(name: 'is_purchased') @Default(false) bool isPurchased,
    @JsonKey(name: 'created_at')
    @DateTimeConverter()
    required DateTime createdAt,
  }) = _ShoppingItem;

  factory ShoppingItem.fromJson(Map<String, dynamic> json) =>
      _$ShoppingItemFromJson(json);
}
