import 'package:collection/collection.dart';

import 'city.dart';

class StateList {
  int? id;
  String? name;
  int? countryId;
  List<City>? city;

  StateList({this.id, this.name, this.countryId, this.city});

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        id: json['id'] as int?,
        name: json['name'] as String?,
        countryId: json['country_id'] as int?,
        city: (json['city'] as List<dynamic>?)
            ?.map((e) => City.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country_id': countryId,
        'city': city?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! StateList) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ countryId.hashCode ^ city.hashCode;
}
