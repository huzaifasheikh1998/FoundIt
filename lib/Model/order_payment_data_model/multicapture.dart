import 'package:collection/collection.dart';

class Multicapture {
  String? status;

  Multicapture({this.status});

  factory Multicapture.fromJson(Map<String, dynamic> json) => Multicapture(
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Multicapture) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode;
}
