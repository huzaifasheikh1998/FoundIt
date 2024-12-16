import 'package:collection/collection.dart';

class Costs {
  String? currency;
  String? subtotal;
  String? discount;
  String? shipping;
  String? digitization;
  dynamic additionalFee;
  dynamic fulfillmentFee;
  String? retailDeliveryFee;
  String? tax;
  String? vat;
  dynamic total;

  Costs({
    this.currency,
    this.subtotal,
    this.discount,
    this.shipping,
    this.digitization,
    this.additionalFee,
    this.fulfillmentFee,
    this.retailDeliveryFee,
    this.tax,
    this.vat,
    this.total,
  });

  factory Costs.fromJson(Map<String, dynamic> json) => Costs(
        currency: json['currency'] as String?,
        subtotal: json['subtotal'] as String?,
        discount: json['discount'] as String?,
        shipping: json['shipping'] as String?,
        digitization: json['digitization'] as String?,
        additionalFee: json['additional_fee'] as dynamic,
        fulfillmentFee: json['fulfillment_fee'] as dynamic,
        retailDeliveryFee: json['retail_delivery_fee'] as String?,
        tax: json['tax'] as String?,
        vat: json['vat'] as String?,
        total: json['total'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'currency': currency,
        'subtotal': subtotal,
        'discount': discount,
        'shipping': shipping,
        'digitization': digitization,
        'additional_fee': additionalFee,
        'fulfillment_fee': fulfillmentFee,
        'retail_delivery_fee': retailDeliveryFee,
        'tax': tax,
        'vat': vat,
        'total': total,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Costs) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      currency.hashCode ^
      subtotal.hashCode ^
      discount.hashCode ^
      shipping.hashCode ^
      digitization.hashCode ^
      additionalFee.hashCode ^
      fulfillmentFee.hashCode ^
      retailDeliveryFee.hashCode ^
      tax.hashCode ^
      vat.hashCode ^
      total.hashCode;
}
