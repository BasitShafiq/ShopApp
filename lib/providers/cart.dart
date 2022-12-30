import 'package:flutter/foundation.dart';

class CartItem {
  String id;
  int quantity;
  double price;
  String title;
  CartItem({
    required this.id,
    required this.price,
    required this.title,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get quantity {
    return _items.length;
  }

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItems(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => CartItem(
            id: value.id,
            price: value.price,
            title: value.title,
            quantity: value.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                price: price,
                title: title,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void DeleteItemFromCart(String productId) {
    if (!_items.containsKey(productId))
      return;
    else if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (exist) => CartItem(
            id: exist.id,
            price: exist.price,
            title: exist.title,
            quantity: exist.quantity - 1),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
