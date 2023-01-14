import 'package:flutter/foundation.dart';
import './cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> addOrder(List<CartItem> order, double total) async {
    final url = 'https://shopapp-34812-default-rtdb.firebaseio.com/Orders.json';
    final timeStamp = DateTime.now().toIso8601String();
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp,
          'product': order
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'price': cp.price,
                    'quantity': cp.quantity,
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      OrderItem(
          id: json.decode(response.body)['name'],
          total: total,
          date: DateTime.now(),
          cartItem: order),
    );
  }

  Future<void> fetchProduct() async {
    final url = 'https://shopapp-34812-default-rtdb.firebaseio.com/Orders.json';
    final response = await http.get(Uri.parse(url));
    if (response == null) {
      return;
    }
    final List<OrderItem> serverOrders = [];
    final orderData = json.decode(response.body) as Map<String, dynamic>;
    orderData.forEach(
      (key, value) {
        serverOrders.add(OrderItem(
            id: key,
            date: DateTime.parse(
              value['dateTime'],
            ),
            total: value['amount'],
            cartItem: (value['product'] as List<dynamic>)
                .map((item) => CartItem(
                      id: item['id'],
                      price: item['price'],
                      title: item['title'],
                      quantity: item['quantity'],
                    ))
                .toList()));
      },
    );
    _orders = serverOrders;
    notifyListeners();
  }
}
