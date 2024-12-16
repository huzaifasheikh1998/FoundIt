import 'package:collection/collection.dart';

class Checks {
  dynamic addressLine1Check;
  dynamic addressPostalCodeCheck;
  String? cvcCheck;

  Checks({
    this.addressLine1Check,
    this.addressPostalCodeCheck,
    this.cvcCheck,
  });

  factory Checks.fromJson(Map<String, dynamic> json) => Checks(
        addressLine1Check: json['address_line1_check'] as dynamic,
        addressPostalCodeCheck: json['address_postal_code_check'] as dynamic,
        cvcCheck: json['cvc_check'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'address_line1_check': addressLine1Check,
        'address_postal_code_check': addressPostalCodeCheck,
        'cvc_check': cvcCheck,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Checks) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      addressLine1Check.hashCode ^
      addressPostalCodeCheck.hashCode ^
      cvcCheck.hashCode;
}
