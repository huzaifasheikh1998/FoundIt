import 'package:collection/collection.dart';

class PackingSlip {
  String? customOrderId;
  String? email;
  String? phone;
  String? message;
  String? logoUrl;
  String? storeName;

  PackingSlip({
    this.customOrderId,
    this.email,
    this.phone,
    this.message,
    this.logoUrl,
    this.storeName,
  });

  factory PackingSlip.fromJson(Map<String, dynamic> json) => PackingSlip(
        customOrderId: json['custom_order_id'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        message: json['message'] as String?,
        logoUrl: json['logo_url'] as String?,
        storeName: json['store_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'custom_order_id': customOrderId,
        'email': email,
        'phone': phone,
        'message': message,
        'logo_url': logoUrl,
        'store_name': storeName,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PackingSlip) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      customOrderId.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      message.hashCode ^
      logoUrl.hashCode ^
      storeName.hashCode;
}
