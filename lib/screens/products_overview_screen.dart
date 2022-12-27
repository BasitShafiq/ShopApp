import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/screens/cart_screen.dart';
import '../widgets/product_item.dart';
import '../widgets/product_Grid.dart';
import '../widgets/badge.dart';

enum FilterOPtions { showAll, ShowFavourities }

class ProductOverview extends StatefulWidget {
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool _showFavourities = false;
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<Cart>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOPtions selected) {
              setState(() {
                if (selected == FilterOPtions.ShowFavourities) {
                  _showFavourities = true;
                } else {
                  _showFavourities = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOPtions.showAll,
              ),
              PopupMenuItem(
                child: Text("Favourities Only"),
                value: FilterOPtions.ShowFavourities,
              )
            ],
          ),
          Consumer<Cart>(
              builder: (_, builder, ch) => Badge(
                    child: ch,
                    value: cartItems.quantity.toString(),
                    color: Theme.of(context).primaryColor,
                  ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Icon(Icons.shopping_cart),
              ))
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Amazon",
        ),
      ),
      body: ProductGrid(_showFavourities),
    );
  }
}
