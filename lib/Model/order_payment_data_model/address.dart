import 'package:collection/collection.dart';

class Address {
  dynamic city;
  dynamic country;
  dynamic line1;
  dynamic line2;
  dynamic postalCode;
  dynamic state;

  Address({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json['city'] as dynamic,
        country: json['country'] as dynamic,
        line1: json['line1'] as dynamic,
        line2: json['line2'] as dynamic,
        postalCode: json['postal_code'] as dynamic,
        state: json['state'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'city': city,
        'country': country,
        'line1': line1,
        'line2': line2,
        'postal_code': postalCode,
        'state': state,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Address) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      city.hashCode ^
      country.hashCode ^
      line1.hashCode ^
      line2.hashCode ^
      postalCode.hashCode ^
      state.hashCode;
}
