import 'package:collection/collection.dart';

class Recipient {
  String? name;
  String? company;
  String? address1;
  dynamic address2;
  String? city;
  String? stateCode;
  String? stateName;
  String? countryCode;
  String? countryName;
  String? zip;
  String? phone;
  String? email;
  dynamic taxNumber;

  Recipient({
    this.name,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.stateCode,
    this.stateName,
    this.countryCode,
    this.countryName,
    this.zip,
    this.phone,
    this.email,
    this.taxNumber,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
        name: json['name'] as String?,
        company: json['company'] as String?,
        address1: json['address1'] as String?,
        address2: json['address2'] as dynamic,
        city: json['city'] as String?,
        stateCode: json['state_code'] as String?,
        stateName: json['state_name'] as String?,
        countryCode: json['country_code'] as String?,
        countryName: json['country_name'] as String?,
        zip: json['zip'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        taxNumber: json['tax_number'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'company': company,
        'address1': address1,
        'address2': address2,
        'city': city,
        'state_code': stateCode,
        'state_name': stateName,
        'country_code': countryCode,
        'country_name': countryName,
        'zip': zip,
        'phone': phone,
        'email': email,
        'tax_number': taxNumber,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Recipient) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      name.hashCode ^
      company.hashCode ^
      address1.hashCode ^
      address2.hashCode ^
      city.hashCode ^
      stateCode.hashCode ^
      stateName.hashCode ^
      countryCode.hashCode ^
      countryName.hashCode ^
      zip.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      taxNumber.hashCode;
}
