class OrderData {
  OrderData(
      {required this.orderId,
      required this.size,
      required this.qty,
      required this.price,
      required this.shipping,
      required this.tax,
      required this.total});
  final String orderId;
  final String size;
  final int? qty;
  final String price;
  final String shipping;
  final String tax;
  final String total;
}
