import 'package:collection/collection.dart';

import 'result.dart';

class Data {
  int? code;
  Result? result;
  List<dynamic>? extra;

  Data({this.code, this.result, this.extra});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json['code'] as int?,
        result: json['result'] == null
            ? null
            : Result.fromJson(json['result'] as Map<String, dynamic>),
        extra: json['extra'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'result': result?.toJson(),
        'extra': extra,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => code.hashCode ^ result.hashCode ^ extra.hashCode;
}
