import 'package:collection/collection.dart';

class Overcapture {
  int? maximumAmountCapturable;
  String? status;

  Overcapture({this.maximumAmountCapturable, this.status});

  factory Overcapture.fromJson(Map<String, dynamic> json) => Overcapture(
        maximumAmountCapturable: json['maximum_amount_capturable'] as int?,
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'maximum_amount_capturable': maximumAmountCapturable,
        'status': status,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Overcapture) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => maximumAmountCapturable.hashCode ^ status.hashCode;
}
