import 'package:collection/collection.dart';

import 'file.dart';
import 'product.dart';

class Item {
  int? id;
  String? externalId;
  int? variantId;
  dynamic syncVariantId;
  dynamic externalVariantId;
  int? quantity;
  String? price;
  String? retailPrice;
  String? name;
  Product? product;
  List<File>? files;
  List<dynamic>? options;
  dynamic sku;
  bool? discontinued;
  bool? outOfStock;

  Item({
    this.id,
    this.externalId,
    this.variantId,
    this.syncVariantId,
    this.externalVariantId,
    this.quantity,
    this.price,
    this.retailPrice,
    this.name,
    this.product,
    this.files,
    this.options,
    this.sku,
    this.discontinued,
    this.outOfStock,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'] as int?,
        externalId: json['external_id'] as String?,
        variantId: json['variant_id'] as int?,
        syncVariantId: json['sync_variant_id'] as dynamic,
        externalVariantId: json['external_variant_id'] as dynamic,
        quantity: json['quantity'] as int?,
        price: json['price'] as String?,
        retailPrice: json['retail_price'] as String?,
        name: json['name'] as String?,
        product: json['product'] == null
            ? null
            : Product.fromJson(json['product'] as Map<String, dynamic>),
        files: (json['files'] as List<dynamic>?)
            ?.map((e) => File.fromJson(e as Map<String, dynamic>))
            .toList(),
        options: json['options'] as List<dynamic>?,
        sku: json['sku'] as dynamic,
        discontinued: json['discontinued'] as bool?,
        outOfStock: json['out_of_stock'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'external_id': externalId,
        'variant_id': variantId,
        'sync_variant_id': syncVariantId,
        'external_variant_id': externalVariantId,
        'quantity': quantity,
        'price': price,
        'retail_price': retailPrice,
        'name': name,
        'product': product?.toJson(),
        'files': files?.map((e) => e.toJson()).toList(),
        'options': options,
        'sku': sku,
        'discontinued': discontinued,
        'out_of_stock': outOfStock,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Item) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      externalId.hashCode ^
      variantId.hashCode ^
      syncVariantId.hashCode ^
      externalVariantId.hashCode ^
      quantity.hashCode ^
      price.hashCode ^
      retailPrice.hashCode ^
      name.hashCode ^
      product.hashCode ^
      files.hashCode ^
      options.hashCode ^
      sku.hashCode ^
      discontinued.hashCode ^
      outOfStock.hashCode;
}
