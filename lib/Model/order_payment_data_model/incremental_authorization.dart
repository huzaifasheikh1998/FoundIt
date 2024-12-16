import 'package:collection/collection.dart';

class IncrementalAuthorization {
  String? status;

  IncrementalAuthorization({this.status});

  factory IncrementalAuthorization.fromJson(Map<String, dynamic> json) {
    return IncrementalAuthorization(
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! IncrementalAuthorization) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode;
}
