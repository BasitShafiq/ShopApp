import 'package:flutter/foundation.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/deleteException.dart';

class Products extends ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  final String? userToken;
  final String? userId;
  Products(this.userToken, this.userId, this._items);

  Future<void> fetchProducts([bool filter = false]) async {
    var filterurl = filter ? 'orderBy="createrId"&equalTo="$userId"' : '';

    var url =
        'https://shopapp-34812-default-rtdb.firebaseio.com/products.json?auth=$userToken&';

    try {
      final response = await http.get(Uri.parse(url));
      final productData = json.decode(response.body) as Map<String, dynamic>;
      url =
          'https://shopapp-34812-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$userToken';
      final favouriteRespons = await http.get(Uri.parse(url));
      final favouriteData = json.decode(favouriteRespons.body);
      final List<Product> listOfProduct = [];
      productData.forEach(
        (key, value) {
          listOfProduct.add(
            Product(
              id: key,
              title: value['title'],
              description: value['description'],
              price: value['price'],
              imageUrl: value['imageUrl'],
              isFavourite:
                  favouriteData == null ? false : favouriteData[key] ?? false,
            ),
          );
        },
      );
      _items = listOfProduct;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProducts(Product product) async {
    final url =
        'https://shopapp-34812-default-rtdb.firebaseio.com/products.json?auth=$userToken';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'createrId': userId,
          },
        ),
      );
      print(response.body);
      final addedProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(addedProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Product findById(String Id) {
    return _items.firstWhere((element) => element.id == Id);
  }

  Future<void> updateProduct(String Id, Product product) async {
    final index = _items.indexWhere((element) => element.id == Id);
    if (index >= 0) {
      final url =
          'https://shopapp-34812-default-rtdb.firebaseio.com/products/$Id.json?auth=$userToken';
      try {
        await http.patch(
          Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }),
        );
      } catch (error) {
        throw error;
      }
    }
    _items[index] = product;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((element) => element.id == id);
    final url =
        'https://shopapp-34812-default-rtdb.firebaseio.com/products/$id.json?=auth$userToken';
    Product? tempProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(index, tempProduct);
      notifyListeners();
      throw DeleteException("Product cannot be Deleted!");
    }
    tempProduct = null;
  }
}
