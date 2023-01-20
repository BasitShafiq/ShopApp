import 'package:flutter/material.dart';
import './screens/products_overview_screen.dart';
import './screens/produt_details_screen.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/authenticate.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/user_product_screen.dart';
import './screens/edit_Products_Screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Authenticator>(
            create: (_) => Authenticator(),
          ),
          ChangeNotifierProxyProvider<Authenticator, Products>(
              update: (_, auth, prev) => Products(auth.getToken, auth.getUserId,
                  prev == null ? [] : prev.items)),
          ChangeNotifierProvider<Cart>(
            create: (_) => Cart(),
          ),
          ChangeNotifierProxyProvider<Authenticator, Order>(
            update: (_, authToken, prev) =>
                Order(authToken.token, prev == null ? [] : prev.orders),
          ),
        ],
        child: Consumer<Authenticator>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
              primaryColor: Color.fromARGB(255, 241, 34, 19),
              accentColor: Color.fromARGB(255, 206, 187, 12),
              fontFamily: 'Lato',
            ),
            home: auth.isAuth() ? ProductOverview() : AuthScreen(),
            routes: {
              ProductOverview.routeName: (ctx) => ProductOverview(),
              ProductsDetailScreen.routeName: (ctx) => ProductsDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditUserProductScreen.routeName: (ctx) => EditUserProductScreen(),
            },
          ),
        ));
  }
}
