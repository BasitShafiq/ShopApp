import 'package:flutter/material.dart';
import './screens/products_overview_screen.dart';
import './screens/produt_details_screen.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Products>(
      create: (_) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.black,
          fontFamily: 'Lato',
        ),
        home: ProductOverview(),
        routes: {
          ProductsDetailScreen.routeName: (ctx) => ProductsDetailScreen(),
        },
      ),
    );
  }
}
