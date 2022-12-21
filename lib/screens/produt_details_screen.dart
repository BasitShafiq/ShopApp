import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductsDetailScreen extends StatelessWidget {
  static const routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    final String ID = ModalRoute.of(context)!.settings.arguments as String;
    final productList = Provider.of<Products>(context, listen: false);
    final productItem = productList.findById(ID);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(productItem.title),
      ),
    );
  }
}
