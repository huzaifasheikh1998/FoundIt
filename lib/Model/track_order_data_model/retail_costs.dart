import 'package:collection/collection.dart';

class RetailCosts {
  String? currency;
  String? subtotal;
  String? discount;
  String? shipping;
  String? tax;
  dynamic vat;
  String? total;

  RetailCosts({
    this.currency,
    this.subtotal,
    this.discount,
    this.shipping,
    this.tax,
    this.vat,
    this.total,
  });

  factory RetailCosts.fromJson(Map<String, dynamic> json) => RetailCosts(
        currency: json['currency'] as String?,
        subtotal: json['subtotal'] as String?,
        discount: json['discount'] as String?,
        shipping: json['shipping'] as String?,
        tax: json['tax'] as String?,
        vat: json['vat'] as dynamic,
        total: json['total'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'currency': currency,
        'subtotal': subtotal,
        'discount': discount,
        'shipping': shipping,
        'tax': tax,
        'vat': vat,
        'total': total,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RetailCosts) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      currency.hashCode ^
      subtotal.hashCode ^
      discount.hashCode ^
      shipping.hashCode ^
      tax.hashCode ^
      vat.hashCode ^
      total.hashCode;
}
