class Order {
  int id;
  String statusOrder;
  String dateTime;
  Order({required this.id, required this.statusOrder, required this.dateTime});
}

class OrdersData {
  List<Order>? orders;
  OrdersData(this.orders);
}
