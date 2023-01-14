import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Order;
import '../widgets/orderItem.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var isloading = true;
  var isint = false;
  @override
  void initState() {
    setState(() {
      isloading = true;
    });
    Future.delayed(
      Duration.zero,
      () async {
        await Provider.of<Order>(context, listen: false).fetchProduct();
        setState(() {
          isloading = false;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Your Order"),
        ),
        drawer: AppDrawer(),
        body: isloading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : ListView.builder(
                itemBuilder: (ctx, index) => OrderItem(
                      orderData.orders[index],
                    ),
                itemCount: orderData.orders.length));
  }
}
