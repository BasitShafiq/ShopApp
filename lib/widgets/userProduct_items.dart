import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../screens/edit_Products_Screen.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  String id;
  String srcImage;
  String title;
  UserProductItem(
      {required this.id, required this.title, required this.srcImage});
  @override
  Widget build(BuildContext context) {
    final snackBarCtx = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(srcImage),
      ),
      title: Text(
        title,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditUserProductScreen.routeName, arguments: id);
              },
              icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
            ),
            IconButton(
              onPressed: () {
                Provider.of<Products>(context, listen: false)
                    .deleteProduct(id)
                    .catchError(
                      (value) => snackBarCtx.showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Cannot Be Deleted!",
                          ),
                          duration: Duration(
                            seconds: 3,
                          ),
                        ),
                      ),
                    );
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
