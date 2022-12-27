import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Order;
import '../widgets/orderItem.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Your Order"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
            itemBuilder: (ctx, index) => OrderItem(
                  orderData.orders[index],
                ),
            itemCount: orderData.orders.length));
  }
}
