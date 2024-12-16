import 'package:collection/collection.dart';

import 'data.dart';

class SetNotificationDataModel {
  bool? status;
  String? message;
  Data? data;

  SetNotificationDataModel({this.status, this.message, this.data});

  factory SetNotificationDataModel.fromJson(Map<String, dynamic> json) {
    return SetNotificationDataModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SetNotificationDataModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
