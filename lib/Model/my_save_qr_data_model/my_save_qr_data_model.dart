import 'package:collection/collection.dart';

import 'save_qr_data.dart';

class MySaveQrDataModel {
  bool? status;
  String? message;
  List<SaveQrData>? data;

  MySaveQrDataModel({this.status, this.message, this.data});

  factory MySaveQrDataModel.fromJson(Map<String, dynamic> json) {
    return MySaveQrDataModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SaveQrData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MySaveQrDataModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
