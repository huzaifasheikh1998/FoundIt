import 'package:collection/collection.dart';

class Variant {
  int? variantId;
  String? variantExternalId;
  String? variantSize;

  Variant({this.variantId, this.variantExternalId, this.variantSize});

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        variantId: json['variantId'] as int?,
        variantExternalId: json['variantExternalId'] as String?,
        variantSize: json['variantSize'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'variantId': variantId,
        'variantExternalId': variantExternalId,
        'variantSize': variantSize,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Variant) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      variantId.hashCode ^ variantExternalId.hashCode ^ variantSize.hashCode;
}
