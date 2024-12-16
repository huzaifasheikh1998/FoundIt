// To parse this JSON data, do
//
//     final orderHistoryDataModel = orderHistoryDataModelFromJson(jsonString);

import 'dart:convert';

OrderHistoryDataModel orderHistoryDataModelFromJson(String str) =>
    OrderHistoryDataModel.fromJson(json.decode(str));

String orderHistoryDataModelToJson(OrderHistoryDataModel data) =>
    json.encode(data.toJson());

class OrderHistoryDataModel {
  final bool status;
  final String message;
  final OrderHistoryData data;

  OrderHistoryDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderHistoryDataModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryDataModel(
        status: json["status"],
        message: json["message"],
        data: OrderHistoryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class OrderHistoryData {
  final List<OrderInstance> completed;
  final List<OrderInstance> pending;
  final List<OrderInstance> canceled;

  OrderHistoryData({
    required this.completed,
    required this.pending,
    required this.canceled,
  });

  factory OrderHistoryData.fromJson(Map<String, dynamic> json) =>
      OrderHistoryData(
        completed: List<OrderInstance>.from(
            json["completed"].map((x) => OrderInstance.fromJson(x))),
        pending: List<OrderInstance>.from(
            json["pending"].map((x) => OrderInstance.fromJson(x))),
        canceled: List<OrderInstance>.from(
            json["canceled"].map((x) => OrderInstance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "completed": List<dynamic>.from(completed.map((x) => x.toJson())),
        "pending": List<dynamic>.from(pending.map((x) => x.toJson())),
        "canceled": List<dynamic>.from(canceled.map((x) => x.toJson())),
      };
}

class OrderInstance {
  final int? id;
  final int? userId;
  final int? qrCodeId;
  final int? externalId;
  final String? variant;
  final int? quantity;
  final Address? address;
  final String? amount;
  final String? status;
  final String? size;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic? deletedAt;

  OrderInstance({
    this.id,
    this.userId,
    this.qrCodeId,
    this.externalId,
    this.variant,
    this.quantity,
    this.address,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.size,
  });

  factory OrderInstance.fromJson(Map<String, dynamic> json) => OrderInstance(
        id: json["id"],
        userId: json["user_id"],
        qrCodeId: json["qr_code_id"],
        externalId: json["external_id"],
        variant: json["variant"],
        quantity: json["quantity"],
        address: Address.fromJson(json["address"]),
        amount: json["amount"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "qr_code_id": qrCodeId,
        "external_id": externalId,
        "variant": variant,
        "quantity": quantity,
        "address": address?.toJson(),
        "amount": amount,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "size": size,
      };
}

class Address {
  final String name;
  final String company;
  final String address1;
  final String city;
  final String stateName;
  final String countryName;
  final String zip;
  final String email;
  final String phone;

  Address({
    required this.name,
    required this.company,
    required this.address1,
    required this.city,
    required this.stateName,
    required this.countryName,
    required this.zip,
    required this.email,
    required this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"],
        company: json["company"],
        address1: json["address1"],
        city: json["city"],
        stateName: json["state_name"],
        countryName: json["country_name"],
        zip: json["zip"],
        email: json["email"],
        phone: json["phone"] == null ? "" : json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "company": company,
        "address1": address1,
        "city": city,
        "state_name": stateName,
        "country_name": countryName,
        "zip": zip,
        "email": email,
        "phone": phone,
      };
}
