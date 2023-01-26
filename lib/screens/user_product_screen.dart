import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/userProduct_items.dart';
import '../screens/edit_Products_Screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    print("Reloading");
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
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: ((context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => (_refreshProducts(context)),
                    child: Padding(
                        padding: EdgeInsets.all(9),
                        child: Consumer<Products>(
                          builder: (ctx, productData, _) => ListView.builder(
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
                        )),
                  )),
      ),
    );
  }
}
