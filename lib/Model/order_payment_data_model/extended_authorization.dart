import 'package:collection/collection.dart';

class ExtendedAuthorization {
  String? status;

  ExtendedAuthorization({this.status});

  factory ExtendedAuthorization.fromJson(Map<String, dynamic> json) {
    return ExtendedAuthorization(
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ExtendedAuthorization) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode;
}
