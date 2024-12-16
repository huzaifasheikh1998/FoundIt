import 'package:collection/collection.dart';

import 'card.dart';

class PaymentMethodDetails {
  Card? card;
  String? type;

  PaymentMethodDetails({this.card, this.type});

  factory PaymentMethodDetails.fromJson(Map<String, dynamic> json) {
    return PaymentMethodDetails(
      card: json['card'] == null
          ? null
          : Card.fromJson(json['card'] as Map<String, dynamic>),
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'card': card?.toJson(),
        'type': type,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PaymentMethodDetails) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => card.hashCode ^ type.hashCode;
}
