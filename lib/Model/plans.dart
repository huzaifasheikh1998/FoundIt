class Plan {
  final Map<String, dynamic> map;

  const Plan({this.map = const {}});

  int get id => map["id"] as int? ?? 0;
  String get planName => map["name"] as String? ?? "";
  String get planId => map["plan_id"] as String? ?? '';
  String get status => map["status"] as String? ?? "";
  String get createdAt => map["created_at"] as String? ?? "";
  String get updatedAt => map["updated_at"] as String? ?? "";
  String get priceId => map["price_id"] as String? ?? "";
  String get paymentType => map["payment_type"] as String? ?? "";
  String get billingPeriod => map["billing_period"] as String? ?? "";
  int get intervalCount => map["interval_count"] as int? ?? 0;
  int get amount => map["amount"] as int? ?? 0;
}
