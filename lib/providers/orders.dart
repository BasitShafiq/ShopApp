import 'package:flutter/foundation.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final DateTime date;
  final double total;
  final List<CartItem> cartItem;
  OrderItem({
    required this.id,
    required this.date,
    required this.total,
    required this.cartItem,
  });
}

class Order with ChangeNotifier {
  late List<OrderItem> _orders = [];
  
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> order, double total) {
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          total: total,
          date: DateTime.now(),
          cartItem: order),
    );
  }
}
