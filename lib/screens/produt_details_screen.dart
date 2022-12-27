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
      body: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20),
          height: 300,
          width: double.infinity,
          child: Image.network(
            productItem.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "${productItem.price}",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontFamily: 'OoohBaby',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "${productItem.description}",
          textAlign: TextAlign.center,
          softWrap: true,
        ),
      ]),
    );
  }
}
