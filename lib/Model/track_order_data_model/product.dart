import 'package:collection/collection.dart';

class Product {
  int? variantId;
  int? productId;
  String? image;
  String? name;

  Product({this.variantId, this.productId, this.image, this.name});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        variantId: json['variant_id'] as int?,
        productId: json['product_id'] as int?,
        image: json['image'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'variant_id': variantId,
        'product_id': productId,
        'image': image,
        'name': name,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Product) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      variantId.hashCode ^ productId.hashCode ^ image.hashCode ^ name.hashCode;
}
