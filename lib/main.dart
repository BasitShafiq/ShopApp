import 'package:flutter/material.dart';
import './screens/products_overview_screen.dart';
import './screens/produt_details_screen.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/user_product_screen.dart';
import './screens/edit_Products_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider<Order>(
          create: (_) => Order(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primaryColor: Color.fromARGB(228, 167, 36, 233),
          accentColor: Colors.red,
          fontFamily: 'Lato',
        ),
        home: ProductOverview(),
        routes: {
          ProductsDetailScreen.routeName: (ctx) => ProductsDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditUserProductScreen.routeName: (ctx) => EditUserProductScreen(),
        },
      ),
    );
  }
}
