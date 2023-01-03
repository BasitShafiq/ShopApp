import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/userProduct_items.dart';
import '../screens/edit_Products_Screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Your Products"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditUserProductScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(9),
        child: ListView.builder(
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                id: productData.items[index].id,
                title: productData.items[index].title,
                srcImage: productData.items[index].imageUrl,
              ),
              Divider(),
            ],
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
