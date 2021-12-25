// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
  List _carts = [];

class Cart with ChangeNotifier {


  addToCart(product, quantity) {
    var existedProduct = _carts.where((item) => item['id'] == product['id']);
    print(existedProduct);

    if (existedProduct.isEmpty) {
      print('asdasd');
      var data = product;
      data['quantity'] = quantity;
      data['total-price'] = quantity * int.parse(data['product-price']);
      _carts.add(data);
    } else {
      print('hello');      
      // existedProduct = existedProduct.first;
      var existedIndex = _carts.indexOf(product);
      print(existedIndex);
      _carts[existedIndex]['quantity'] = quantity;
      _carts[existedIndex]['total-price'] = quantity * int.parse(_carts[existedIndex]['product-price']);
    }
    // clearCart();
    print(_carts.length);
    notifyListeners();
  }

  List get getCart => [..._carts];

  int get cartCount => _carts.length;

  clearCart() {
    // _carts = [];
    notifyListeners();
  }
}