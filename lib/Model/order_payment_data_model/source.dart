import 'package:collection/collection.dart';

class Source {
  String? id;
  String? object;
  dynamic addressCity;
  dynamic addressCountry;
  dynamic addressLine1;
  dynamic addressLine1Check;
  dynamic addressLine2;
  dynamic addressState;
  dynamic addressZip;
  dynamic addressZipCheck;
  String? brand;
  String? country;
  dynamic customer;
  String? cvcCheck;
  dynamic dynamicLast4;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? last4;
  List<dynamic>? metadata;
  dynamic name;
  dynamic tokenizationMethod;
  dynamic wallet;

  Source({
    this.id,
    this.object,
    this.addressCity,
    this.addressCountry,
    this.addressLine1,
    this.addressLine1Check,
    this.addressLine2,
    this.addressState,
    this.addressZip,
    this.addressZipCheck,
    this.brand,
    this.country,
    this.customer,
    this.cvcCheck,
    this.dynamicLast4,
    this.expMonth,
    this.expYear,
    this.fingerprint,
    this.funding,
    this.last4,
    this.metadata,
    this.name,
    this.tokenizationMethod,
    this.wallet,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json['id'] as String?,
        object: json['object'] as String?,
        addressCity: json['address_city'] as dynamic,
        addressCountry: json['address_country'] as dynamic,
        addressLine1: json['address_line1'] as dynamic,
        addressLine1Check: json['address_line1_check'] as dynamic,
        addressLine2: json['address_line2'] as dynamic,
        addressState: json['address_state'] as dynamic,
        addressZip: json['address_zip'] as dynamic,
        addressZipCheck: json['address_zip_check'] as dynamic,
        brand: json['brand'] as String?,
        country: json['country'] as String?,
        customer: json['customer'] as dynamic,
        cvcCheck: json['cvc_check'] as String?,
        dynamicLast4: json['dynamic_last4'] as dynamic,
        expMonth: json['exp_month'] as int?,
        expYear: json['exp_year'] as int?,
        fingerprint: json['fingerprint'] as String?,
        funding: json['funding'] as String?,
        last4: json['last4'] as String?,
        metadata: json['metadata'] as List<dynamic>?,
        name: json['name'] as dynamic,
        tokenizationMethod: json['tokenization_method'] as dynamic,
        wallet: json['wallet'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'object': object,
        'address_city': addressCity,
        'address_country': addressCountry,
        'address_line1': addressLine1,
        'address_line1_check': addressLine1Check,
        'address_line2': addressLine2,
        'address_state': addressState,
        'address_zip': addressZip,
        'address_zip_check': addressZipCheck,
        'brand': brand,
        'country': country,
        'customer': customer,
        'cvc_check': cvcCheck,
        'dynamic_last4': dynamicLast4,
        'exp_month': expMonth,
        'exp_year': expYear,
        'fingerprint': fingerprint,
        'funding': funding,
        'last4': last4,
        'metadata': metadata,
        'name': name,
        'tokenization_method': tokenizationMethod,
        'wallet': wallet,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Source) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      object.hashCode ^
      addressCity.hashCode ^
      addressCountry.hashCode ^
      addressLine1.hashCode ^
      addressLine1Check.hashCode ^
      addressLine2.hashCode ^
      addressState.hashCode ^
      addressZip.hashCode ^
      addressZipCheck.hashCode ^
      brand.hashCode ^
      country.hashCode ^
      customer.hashCode ^
      cvcCheck.hashCode ^
      dynamicLast4.hashCode ^
      expMonth.hashCode ^
      expYear.hashCode ^
      fingerprint.hashCode ^
      funding.hashCode ^
      last4.hashCode ^
      metadata.hashCode ^
      name.hashCode ^
      tokenizationMethod.hashCode ^
      wallet.hashCode;
}
