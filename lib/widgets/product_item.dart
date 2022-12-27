import '../screens/produt_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);

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
                color: Color.fromARGB(255, 178, 9, 7),
                onPressed: () {
                  product.toggleFavourite();
                },
              );
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.shop),
            onPressed: () {
              cart.addItems(
                product.id,
                product.title,
                product.price,
              );
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(product.title),
        ),
      ),
    );
  }
}
