import '../screens/produt_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/product.dart';

class ProductItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductsDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Image.network(product.imageUrl)),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (context, product, child) {
              return IconButton(
                icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border,
                ),
                color: Colors.amber,
                onPressed: () {
                  product.toggleFavourite();
                },
              );
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          title: Text(product.title),
        ),
      ),
    );
  }
}
