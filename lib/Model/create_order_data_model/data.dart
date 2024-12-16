import 'package:collection/collection.dart';

import 'original.dart';

class Data {
  Original? original;
  dynamic exception;

  Data({this.original, this.exception});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        original: json['original'] == null
            ? null
            : Original.fromJson(json['original'] as Map<String, dynamic>),
        exception: json['exception'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'original': original?.toJson(),
        'exception': exception,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => original.hashCode ^ exception.hashCode;
}
