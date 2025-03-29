import 'package:flutter/foundation.dart';

class CartModel extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  double get totalPrice {
    return _items.fold(0, (total, item) => total + (item['price'] as num) * (item['quantity'] as int));
  }

  int get itemCount {
    return _items.fold(0, (total, item) => total + (item['quantity'] as int));
  }

  void addItem(Map<String, dynamic> product) {
    final existingIndex = _items.indexWhere((item) => item['id'] == product['id']);
    if (existingIndex != -1) {
      _items[existingIndex]['quantity'] = (_items[existingIndex]['quantity'] as int) + 1;
    } else {
      _items.add({...product, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeItem(Map<String, dynamic> product) {
    _items.removeWhere((item) => item['id'] == product['id']);
    notifyListeners();
  }

  void incrementQuantity(Map<String, dynamic> product) {
    final index = _items.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      _items[index]['quantity'] = (_items[index]['quantity'] as int) + 1;
      notifyListeners();
    }
  }

  void decrementQuantity(Map<String, dynamic> product) {
    final index = _items.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      if (_items[index]['quantity'] as int > 1) {
        _items[index]['quantity'] = (_items[index]['quantity'] as int) - 1;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> item) {
    removeItem(item);
  }
}

