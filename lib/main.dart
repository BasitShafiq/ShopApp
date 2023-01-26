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
              create: null,
              update: (_, auth, prev) => Products(auth.getToken, auth.getUserId,
                  prev == null ? [] : prev.items)),
          ChangeNotifierProvider<Cart>(
            create: (_) => Cart(),
          ),
          ChangeNotifierProxyProvider<Authenticator, Order>(
            create: null,
            update: (_, authToken, prev) => Order(authToken.token,
                prev == null ? [] : prev.orders, authToken.getUserId),
          ),
        ],
        child: Consumer<Authenticator>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: Color.fromARGB(255, 247, 249, 249),
              primaryColor: Color.fromARGB(255, 31, 52, 190),
              accentColor: Color.fromARGB(255, 206, 187, 12),
              fontFamily: 'Lato',
            ),
            home: auth.isAuth
                ? ProductOverview()
                : FutureBuilder(
                    future: auth.autoLogin(),
                    builder: (ctx, snapShot) =>
                        (snapShot.connectionState == ConnectionState.waiting)
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              AuthScreen.routeName: (ctx) => AuthScreen(),
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
