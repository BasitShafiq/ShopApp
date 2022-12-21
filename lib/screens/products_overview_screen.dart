import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';
import '../widgets/product_Grid.dart';

enum FilterOPtions { showAll, ShowFavourities }

class ProductOverview extends StatefulWidget {
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool _showFavourities = false;
  @override
  Widget build(BuildContext context) {
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
          )
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
