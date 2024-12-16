import 'package:collection/collection.dart';

class Outcome {
  String? networkStatus;
  dynamic reason;
  String? riskLevel;
  int? riskScore;
  String? sellerMessage;
  String? type;

  Outcome({
    this.networkStatus,
    this.reason,
    this.riskLevel,
    this.riskScore,
    this.sellerMessage,
    this.type,
  });

  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
        networkStatus: json['network_status'] as String?,
        reason: json['reason'] as dynamic,
        riskLevel: json['risk_level'] as String?,
        riskScore: json['risk_score'] as int?,
        sellerMessage: json['seller_message'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'network_status': networkStatus,
        'reason': reason,
        'risk_level': riskLevel,
        'risk_score': riskScore,
        'seller_message': sellerMessage,
        'type': type,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Outcome) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      networkStatus.hashCode ^
      reason.hashCode ^
      riskLevel.hashCode ^
      riskScore.hashCode ^
      sellerMessage.hashCode ^
      type.hashCode;
}
