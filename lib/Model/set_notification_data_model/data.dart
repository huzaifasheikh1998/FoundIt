import 'package:collection/collection.dart';

class Data {
  int? id;
  int? userId;
  String? fcmToken;
  bool? notificationEnabled;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.fcmToken,
    this.notificationEnabled,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        fcmToken: json['fcm_token'] as String?,
        notificationEnabled: json['notification_enabled'] as bool?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'fcm_token': fcmToken,
        'notification_enabled': notificationEnabled,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      fcmToken.hashCode ^
      notificationEnabled.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
