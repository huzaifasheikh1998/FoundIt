import 'package:collection/collection.dart';

class PricingBreakdown {
  String? customerPays;
  String? printfulPrice;
  String? profit;
  String? currencySymbol;

  PricingBreakdown({
    this.customerPays,
    this.printfulPrice,
    this.profit,
    this.currencySymbol,
  });

  factory PricingBreakdown.fromJson(Map<String, dynamic> json) {
    return PricingBreakdown(
      customerPays: json['customer_pays'] as String?,
      printfulPrice: json['printful_price'] as String?,
      profit: json['profit'] as String?,
      currencySymbol: json['currency_symbol'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'customer_pays': customerPays,
        'printful_price': printfulPrice,
        'profit': profit,
        'currency_symbol': currencySymbol,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PricingBreakdown) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      customerPays.hashCode ^
      printfulPrice.hashCode ^
      profit.hashCode ^
      currencySymbol.hashCode;
}
