import 'package:collection/collection.dart';

class NetworkToken {
  bool? used;

  NetworkToken({this.used});

  factory NetworkToken.fromJson(Map<String, dynamic> json) => NetworkToken(
        used: json['used'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'used': used,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! NetworkToken) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => used.hashCode;
}
