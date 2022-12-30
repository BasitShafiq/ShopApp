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
                color: Color.fromARGB(255, 221, 255, 3),
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
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: const Text(
                  "Added to cart!",
                ),
                duration: Duration(
                  seconds: 3,
                ),
                action: SnackBarAction(
                  label: "Undo",
                  onPressed: () {
                    cart.DeleteItemFromCart(product.id);
                  },
                ),
              ));
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(product.title),
        ),
      ),
    );
  }
}
