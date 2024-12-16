import 'package:collection/collection.dart';

import 'result.dart';

class Original {
  int? code;
  Result? result;
  List<dynamic>? extra;

  Original({this.code, this.result, this.extra});

  factory Original.fromJson(Map<String, dynamic> json) => Original(
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
    if (other is! Original) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => code.hashCode ^ result.hashCode ^ extra.hashCode;
}
