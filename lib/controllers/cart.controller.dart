import 'package:get/get.dart';

class CartController extends GetxController {

  var carts = [].obs;
  var wishlist = [].obs;

  addtoCart(product, quantity) {
    var existedProduct = carts.where((item) => item['id'] == product['id']);
    print(existedProduct);

    if (existedProduct.isEmpty) {
      print('asdasd');
      var data = product;
      data['quantity'] = quantity;
      data['total-price'] = quantity * int.parse(data['product-price']);
      carts.add(data);
    } else {
      print('hello');      
      // existedProduct = existedProduct.first;
      var existedIndex = carts.indexOf(product);
      print(existedIndex);
      carts[existedIndex]['quantity'] = quantity;
      carts[existedIndex]['total-price'] = quantity * int.parse(carts[existedIndex]['product-price']);
    }
  }

  addtoWishlist(product) {
    var existedProduct = wishlist.where((item) => item['id'] == product['id']);
    print(existedProduct);

    if (existedProduct.isEmpty) {
      print('asdasd');
      var data = product;
      wishlist.add(data);
    } else {
    }

    print(wishlist);
  }

  increaseQuantity(product) {
    var existedProduct = carts.where((item) => item['id'] == product['id']);
    print(existedProduct);

    var tempCarts = carts;

    if (existedProduct.isNotEmpty) {
      
      print('hello');      
      // existedProduct = existedProduct.first;
      var existedIndex = carts.indexOf(product);
      
      carts[existedIndex]['quantity'] = carts[existedIndex]['quantity'] + 1;
      carts[existedIndex]['total-price'] = carts[existedIndex]['quantity'] * int.parse(carts[existedIndex]['product-price']);
      print(carts[existedIndex]);

    }
  }

  removeCartItem(product) {
    var existedProduct = carts.removeWhere((item) => item['id'] == product['id']);

    print(carts.length);
    // print(existedProduct);

    // var tempCarts = carts;

    // if (existedProduct.isNotEmpty) {
      
    //   print('hello');      
    //   // existedProduct = existedProduct.first;
    //   var existedIndex = carts.indexOf(product);

    //   cart
      
    //   carts[existedIndex]['quantity'] = carts[existedIndex]['quantity'] + 1;
    //   carts[existedIndex]['total-price'] = carts[existedIndex]['quantity'] * int.parse(carts[existedIndex]['product-price']);
    //   print(carts[existedIndex]);

    // }
  }

  getCartProduct(product) {
    var existedProduct = carts.where((item) => item['id'] == product['id']);
    return existedProduct.isNotEmpty ? existedProduct.first : null;
  }

  clearCart() {
    carts.value = [];
  }

}