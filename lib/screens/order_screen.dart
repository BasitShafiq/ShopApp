import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Order;
import '../widgets/orderItem.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Order"),
        ),
        body: ListView.builder(
            itemBuilder: (ctx, index) => OrderItem(
                  orderData.orders[index],
                ),
            itemCount: orderData.orders.length));
  }
}
