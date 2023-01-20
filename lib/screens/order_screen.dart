import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Order;
import '../widgets/orderItem.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Your Order"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        builder: (ctx, data) {
          if (data.connectionState == ConnectionState.waiting)
            return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor));
          else {
            if (data.error != null)
              return Center(
                child: Text("An Error Occured!"),
              );
            else
              return Consumer<Order>(
                  builder: (ctx, orderData, child) => ListView.builder(
                      itemBuilder: (ctx, index) => OrderItem(
                            orderData.orders[index],
                          ),
                      itemCount: orderData.orders.length));
          }
        },
        future: Provider.of<Order>(context, listen: false).fetchProduct(),
      ),
    );
  }
}
