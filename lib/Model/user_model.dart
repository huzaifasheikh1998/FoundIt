import 'package:foundit/services/local_storage_service.dart';

class User extends LocalStorage {
  static User data = User();

  final Map<String, dynamic> map;
  const User({this.map = const {}}) : super(fileName: "user", value: map);

  @override
  Future<void> clear() async {
    await clearLocal();
  }

  @override
  Future<void> init() async {
    data = User(map: await readFromFile());
  }

  set notification(bool value) {
    map["notificationOn"] = value;
  }

  int get userId => map["id"] as int? ?? 0;
  bool get notification => map["notification"] as bool? ?? true;

  String get userName => map["name"] as String? ?? '';
  String get userEmail => map["email"] as String? ?? '';
  String get otp => map["email"] ?? '';
  String get mobileNo => map["mobile_no"] as String? ?? '';
  String get apiToken => map["api_token"] as String? ?? '';
  String get deviceToken => map["device_token"] as String? ?? '';
  String get emailVerifiedAt => map["email_verified_at"] as String? ?? '';
  String get boxLimit => map["box_limit"].toString();
  String get boxRemaining => map["box_remaining"].toString();
  bool get isSubscribed => map["is_subscribed"] as bool? ?? false;
  SubscriptionModel get subscriptionModel => SubscriptionModel(
      map: map['subscription'] as Map<String, dynamic>? ?? const {});
}

class SubscriptionModel {
  int get id => map["id"] as int? ?? 0;
  String get subcriptionId => map["subscription_id"] as String? ?? '';
  String get customerId => map["customer_id"] as String? ?? '';
  String get priceId => map["price_id"] as String? ?? '';
  String get planId => map["plan_id"] as String? ?? '';
  String get status => map["status"] as String? ?? '';
  int get userId => map["user_id"] as int? ?? 0;

  String get deletedAt => map["deleted_at"] as String? ?? '';
  final Map<String, dynamic> map;
  SubscriptionModel({this.map = const {}});
}

/* 
class User  {
  static User data = User();

  final Map<String, dynamic> map;
  const User({this.map = const {}}) ;

  int get userId => map["id"] as int? ?? 0;
  String get userName => map["name"] as String? ?? '';
  String get userEmail => map["email"] as String? ?? '';
  String get otp => map["email"] as String? ?? '';
  String get mobileNo => map["mobile_no"] as String? ?? '';
  String get apiToken => map["api_token"] as String? ?? '';
  String get deviceToken => map["device_token"] as String? ?? '';
  String get emailVerifiedAt => map["email_verified_at"] as String? ?? '';
}

*/

/*
   "id": 56,
        "name": "Henry",
        "email": "henry@yopmail.com",
        "otp": "8373",
        "mobile_no": "1122334455",
        "api_token": "78|Stj5xmzp6SGod04AmYlT3pcieWR8GXAYxWekKc5G",
        "device_token": "aaaaaaaaabbbc",
        "email_verified_at": "2023-07-17T13:50:01.000000Z"

*/
